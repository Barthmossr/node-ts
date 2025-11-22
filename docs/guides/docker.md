# Docker Guide

Guide for containerizing your Node.js TypeScript application with Docker.

## 📋 Table of Contents

- [Overview](#overview)
- [Prerequisites](#prerequisites)
- [Development Setup](#development-setup)
- [Production Setup](#production-setup)
- [Docker Compose](#docker-compose)
- [Best Practices](#best-practices)
- [Troubleshooting](#troubleshooting)

## 🐳 Overview

This guide covers Docker setup for both development and production environments. Docker ensures your application runs consistently across different environments.

## ✅ Prerequisites

- **Docker**: Install from [docker.com](https://www.docker.com/get-started)
- **Docker Compose**: Usually included with Docker Desktop

Check installation:

```bash
docker --version
docker-compose --version
```

## 🔧 Development Setup

### Dockerfile.dev

```dockerfile
# Development Dockerfile
FROM node:24.11.1-alpine

# Set working directory
WORKDIR /app

# Install dependencies for development
COPY package*.json ./
RUN npm ci

# Copy source code
COPY . .

# Expose port
EXPOSE 3000

# Development command with hot reload
CMD ["npm", "run", "dev"]
```

### Build and Run (Development)

```bash
# Build development image
docker build -f Dockerfile.dev -t node-ts:dev .

# Run development container
docker run -p 3000:3000 -v $(pwd):/app -v /app/node_modules node-ts:dev
```

**Flags Explained**:

- `-p 3000:3000`: Map port 3000 from container to host
- `-v $(pwd):/app`: Mount current directory to /app (hot reload)
- `-v /app/node_modules`: Use container's node_modules (not host's)

## 🚀 Production Setup

### Dockerfile

```dockerfile
# Production Dockerfile - Multi-stage build

# Stage 1: Build
FROM node:24.11.1-alpine AS builder

WORKDIR /app

# Copy package files
COPY package*.json ./

# Install dependencies (including devDependencies for build)
RUN npm ci

# Copy source code
COPY . .

# Build the application
RUN npm run build

# Stage 2: Production
FROM node:24.11.1-alpine

WORKDIR /app

# Copy package files
COPY package*.json ./

# Install only production dependencies
RUN npm ci --only=production

# Copy built application from builder stage
COPY --from=builder /app/dist ./dist

# Create non-root user
RUN addgroup -g 1001 -S nodejs && \
    adduser -S nodejs -u 1001

# Change ownership
RUN chown -R nodejs:nodejs /app

# Switch to non-root user
USER nodejs

# Expose port
EXPOSE 3000

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD node -e "require('http').get('http://localhost:3000/health', (r) => {process.exit(r.statusCode === 200 ? 0 : 1)})"

# Start the application
CMD ["node", "dist/app/main.js"]
```

**Why Multi-stage Build**:

- Smaller final image (no dev dependencies)
- Faster deployment
- More secure (no build tools in production)

### Build and Run (Production)

```bash
# Build production image
docker build -t node-ts:latest .

# Run production container
docker run -p 3000:3000 node-ts:latest
```

## 🐙 Docker Compose

### docker-compose.yml

```yaml
version: "3.8"

services:
  app:
    build:
      context: .
      dockerfile: Dockerfile.dev
    ports:
      - "3000:3000"
    volumes:
      - .:/app
      - /app/node_modules
    environment:
      - NODE_ENV=development
      - APP_PORT=3000
    command: npm run dev
    restart: unless-stopped

  # Example: Database service
  # postgres:
  #   image: postgres:15-alpine
  #   ports:
  #     - "5432:5432"
  #   environment:
  #     POSTGRES_USER: user
  #     POSTGRES_PASSWORD: password
  #     POSTGRES_DB: mydb
  #   volumes:
  #     - postgres-data:/var/lib/postgresql/data
# volumes:
#   postgres-data:
```

### docker-compose.prod.yml

```yaml
version: "3.8"

services:
  app:
    build:
      context: .
      dockerfile: Dockerfile
    ports:
      - "3000:3000"
    environment:
      - NODE_ENV=production
      - APP_PORT=3000
    restart: always
    healthcheck:
      test:
        [
          "CMD",
          "node",
          "-e",
          "require('http').get('http://localhost:3000/health', (r) => {process.exit(r.statusCode === 200 ? 0 : 1)})",
        ]
      interval: 30s
      timeout: 3s
      retries: 3
      start_period: 40s
```

### Using Docker Compose

```bash
# Development
docker-compose up

# Production
docker-compose -f docker-compose.prod.yml up

# Build and run
docker-compose up --build

# Run in background
docker-compose up -d

# View logs
docker-compose logs -f

# Stop containers
docker-compose down

# Stop and remove volumes
docker-compose down -v
```

## 📄 .dockerignore

Create `.dockerignore` to exclude unnecessary files:

```
node_modules
dist
coverage
.git
.github
.vscode
.idea
.env
.env.local
*.log
npm-debug.log*
.DS_Store
README.md
docs
tests
*.test.ts
*.spec.ts
.eslintrc.json
.prettierrc.json
jest.config.js
```

**Why**: Smaller build context = faster builds.

## ✨ Best Practices

### 1. Use Multi-stage Builds

Reduces final image size by excluding build dependencies.

```dockerfile
# Build stage
FROM node:24.11.1-alpine AS builder
# ... build steps ...

# Production stage
FROM node:24.11.1-alpine
# ... only copy what's needed ...
```

### 2. Use Alpine Linux

Alpine is much smaller than standard Node images.

```dockerfile
# ✅ Good: ~120MB
FROM node:24.11.1-alpine

# ❌ Larger: ~900MB
FROM node:24.11.1
```

### 3. Run as Non-root User

Security best practice:

```dockerfile
RUN addgroup -g 1001 -S nodejs && \
    adduser -S nodejs -u 1001
USER nodejs
```

### 4. Use npm ci Instead of npm install

`npm ci` is faster and more reliable for CI/CD:

```dockerfile
RUN npm ci
```

### 5. Layer Caching

Copy `package*.json` before source code to leverage Docker layer caching:

```dockerfile
# ✅ Good: Dependency layer cached if package.json unchanged
COPY package*.json ./
RUN npm ci
COPY . .

# ❌ Bad: Installs dependencies every time
COPY . .
RUN npm ci
```

### 6. Health Checks

Add health checks for container orchestration:

```dockerfile
HEALTHCHECK --interval=30s --timeout=3s \
  CMD node -e "..." || exit 1
```

### 7. Use .dockerignore

Exclude unnecessary files to speed up builds.

### 8. Pin Versions

Always use specific versions:

```dockerfile
# ✅ Good
FROM node:24.11.1-alpine

# ❌ Bad (unpredictable)
FROM node:latest
```

### 9. Environment Variables

Use environment variables for configuration:

```dockerfile
ENV NODE_ENV=production
ENV APP_PORT=3000
```

### 10. Clean Up

Remove unnecessary files in the same layer:

```dockerfile
RUN npm ci --only=production && \
    npm cache clean --force
```

## 🐛 Troubleshooting

### Issue: Container exits immediately

**Check logs**:

```bash
docker logs <container-id>
```

**Common causes**:

- Application crashes on startup
- Missing environment variables
- Port already in use

### Issue: Changes not reflected

**Solution**: Rebuild the image

```bash
docker-compose up --build
```

Or force recreation:

```bash
docker-compose up --force-recreate
```

### Issue: Permission denied

**Solution**: Check file ownership

```bash
# In Dockerfile
RUN chown -R nodejs:nodejs /app
USER nodejs
```

### Issue: Cannot connect to container

**Check port mapping**:

```bash
docker ps
# Ensure port is mapped correctly
```

**Check if service is running**:

```bash
docker exec -it <container-id> sh
# Inside container
ps aux
```

### Issue: Out of disk space

**Clean up Docker resources**:

```bash
# Remove unused images
docker image prune -a

# Remove unused volumes
docker volume prune

# Remove everything unused
docker system prune -a --volumes
```

## 🚀 CI/CD with Docker

### GitHub Actions Example

```yaml
name: Docker Build and Push

on:
  push:
    branches: [main]

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3

      - name: Build Docker image
        run: docker build -t node-ts:latest .

      - name: Run tests in container
        run: docker run node-ts:latest npm test

      # Push to registry (Docker Hub, GitHub Container Registry, etc.)
      # - name: Push to registry
      #   run: |
      #     docker login -u ${{ secrets.DOCKER_USERNAME }} -p ${{ secrets.DOCKER_PASSWORD }}
      #     docker push node-ts:latest
```

## 📚 Common Commands Reference

```bash
# Build
docker build -t myapp .
docker build -f Dockerfile.dev -t myapp:dev .

# Run
docker run -p 3000:3000 myapp
docker run -d -p 3000:3000 myapp  # Detached mode

# Execute command in container
docker exec -it <container-id> sh
docker exec -it <container-id> npm test

# View logs
docker logs <container-id>
docker logs -f <container-id>  # Follow logs

# Stop/Remove
docker stop <container-id>
docker rm <container-id>
docker rmi <image-id>

# Docker Compose
docker-compose up
docker-compose up -d
docker-compose down
docker-compose logs -f
docker-compose exec app sh
```

## 🔗 Related Guides

- [Development Guide](development.md) - Development workflow
- [Configuration Guide](configuration.md) - Configuration files

---

**Note**: This Docker setup is designed for the template. Adapt it based on your specific application needs (databases, caching, etc.).

**Need Help?** Open an issue on [GitHub](https://github.com/Barthmossr/node-ts/issues).

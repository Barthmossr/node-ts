# Docker Guide

Complete guide for running this project with Docker, including development and production environments.

## 📋 Table of Contents

- [Overview](#overview)
- [Prerequisites](#prerequisites)
- [Quick Start](#quick-start)
- [Development Environment](#development-environment)
- [Production Environment](#production-environment)
- [Docker Commands](#docker-commands)
- [Dev Containers](#dev-containers)
- [Architecture](#architecture)
- [Troubleshooting](#troubleshooting)

## 🎯 Overview

This project includes a complete Docker setup with:

- **Multi-stage Dockerfile**: Optimized builds for development and production
- **Docker Compose**: Easy orchestration of services
- **Dev Container**: Full VS Code development environment in Docker
- **Hot Reload**: File watching in development mode
- **Security**: Non-root user in production, minimal image size

## ✅ Prerequisites

- [Docker](https://docs.docker.com/get-docker/) (v20.10+)
- [Docker Compose](https://docs.docker.com/compose/install/) (v2.0+)
- [VS Code](https://code.visualstudio.com/) with [Dev Containers extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers) (optional, for Dev Container)

## 🚀 Quick Start

### Development Mode

```bash
# Start development container with hot reload
npm run docker:dev

# Or build and start
npm run docker:dev:build
```

### Production Mode

```bash
# Build and start production container
npm run docker:prod
```

### Run Tests in Docker

```bash
npm run docker:test
```

## 🛠️ Development Environment

The development environment provides:

- Hot reload with file watching
- Full source code mounted
- All dev dependencies available
- Same Node.js version as production

### Starting Development

```bash
# Start the development container
npm run docker:dev

# The container will:
# 1. Mount your local files
# 2. Start tsx in watch mode
# 3. Reload on file changes
```

### Accessing the Container

```bash
# Open a shell in the running container
docker compose exec dev sh

# Run commands inside
npm run lint
npm test
```

### File Sync

Your local `src/` directory is mounted into the container. Changes are immediately reflected without rebuilding.

**Note**: `node_modules` is stored in a Docker volume to:

- Avoid conflicts between host and container dependencies
- Improve performance on macOS/Windows
- Ensure Linux-compatible binaries

## 🏭 Production Environment

The production build is optimized for:

- Minimal image size (~150MB)
- Security (non-root user)
- Fast startup
- Health checks

### Building for Production

```bash
# Build and run production container
npm run docker:prod

# Or build separately
docker compose build prod
docker compose up prod
```

### Production Features

| Feature           | Description                       |
| ----------------- | --------------------------------- |
| **Multi-stage**   | Only production files in image    |
| **Alpine Linux**  | Minimal base image                |
| **Non-root user** | Runs as `appuser` (UID 1001)      |
| **Health check**  | Built-in health endpoint          |
| **No dev deps**   | Only production dependencies      |
| **Optimized**     | npm cache cleaned, minimal layers |

### Health Check

The production container includes a health check that pings `/health` every 30 seconds:

```bash
# Check container health
docker inspect --format='{{.State.Health.Status}}' node-ts-prod
```

## 📜 Docker Commands

### npm Scripts

| Script             | Description                            |
| ------------------ | -------------------------------------- |
| `docker:dev`       | Start development container            |
| `docker:dev:build` | Rebuild and start development          |
| `docker:prod`      | Build and start production container   |
| `docker:test`      | Run tests in container                 |
| `docker:down`      | Stop all containers                    |
| `docker:clean`     | Remove containers, volumes, and images |

### Docker Compose Commands

```bash
# Start specific service
docker compose up dev
docker compose up prod

# Start in detached mode
docker compose up -d dev

# View logs
docker compose logs -f dev

# Stop all services
docker compose down

# Rebuild without cache
docker compose build --no-cache dev

# Remove everything (containers, volumes, images)
docker compose down -v --rmi local
```

### Docker Commands

```bash
# List running containers
docker ps

# View container logs
docker logs node-ts-dev -f

# Execute command in container
docker exec -it node-ts-dev sh

# Build production image manually
docker build --target production -t node-ts:prod .

# Run production image
docker run -p 3000:3000 node-ts:prod
```

## 💻 Dev Containers

This project supports VS Code Dev Containers for a consistent development environment.

### Opening in Dev Container

1. Install the [Dev Containers extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)
2. Open the project in VS Code
3. Click "Reopen in Container" when prompted (or use Command Palette: `Dev Containers: Reopen in Container`)

### What's Included

- Node.js 24.11.1
- All VS Code extensions pre-installed
- ESLint and Prettier configured
- Git available inside container
- Port 3000 forwarded automatically

### Dev Container Features

| Feature             | Description                      |
| ------------------- | -------------------------------- |
| **Extensions**      | ESLint, Prettier, Jest, GitLens  |
| **Settings**        | Format on save, ESLint auto-fix  |
| **Port forwarding** | 3000 exposed to host             |
| **Post-create**     | Runs `npm install` automatically |

## 🏗️ Architecture

### Docker Files

| File             | Purpose                                 |
| ---------------- | --------------------------------------- |
| `Dockerfile`     | Production multi-stage build            |
| `Dockerfile.dev` | Development environment with hot reload |

### Dockerfile (Production) Stages

```
┌─────────────────────────────────────────────────────────────┐
│                    Dockerfile (Production)                  │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  ┌─────────┐                                                │
│  │  base   │ ← Alpine + Node.js 24.11.1                     │
│  └────┬────┘                                                │
│       │                                                     │
│  ┌────┴────┐                                                │
│  │  deps   │ ← Install all dependencies                     │
│  └────┬────┘                                                │
│       │                                                     │
│       ├──────────────────┐                                  │
│       │                  │                                  │
│  ┌────┴────┐        ┌────┴────┐                             │
│  │ builder │        │prod-deps│                             │
│  └────┬────┘        └────┬────┘                             │
│       │                  │                                  │
│       └────────┬─────────┘                                  │
│                │                                            │
│       ┌────────┴────────┐                                   │
│       │   production    │                                   │
│       └─────────────────┘                                   │
│                ↓                                            │
│          Prod Image                                         │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

### Dockerfile.dev (Development)

```
┌─────────────────────────────────────────────────────────────┐
│                    Dockerfile.dev                           │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  ┌─────────────────────────────────────────────────────┐    │
│  │  node:24.11.1-alpine                                │    │
│  │  + All dependencies (npm ci)                        │    │
│  │  + Source code                                      │    │
│  │  + Hot reload (tsx watch)                           │    │
│  └─────────────────────────────────────────────────────┘    │
│                          ↓                                  │
│                    Dev Container                            │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

### Image Sizes

| Image          | Approximate Size | Use Case          |
| -------------- | ---------------- | ----------------- |
| Dockerfile.dev | ~500MB           | Local development |
| Dockerfile     | ~150MB           | Deployment        |

## 🐛 Troubleshooting

### Common Issues

#### Issue: Port already in use

```bash
# Error: port 3000 is already in use
# Solution: Stop the conflicting process or use a different port
docker compose down
lsof -i :3000  # Find what's using the port
```

#### Issue: node_modules sync issues

```bash
# Solution: Rebuild the container
npm run docker:clean
npm run docker:dev:build
```

#### Issue: Permission denied

```bash
# Solution: Fix file permissions
sudo chown -R $(whoami):$(whoami) .
```

#### Issue: Changes not reflecting

```bash
# Solution: Restart the container
docker compose restart dev

# Or rebuild
npm run docker:dev:build
```

#### Issue: Out of disk space

```bash
# Clean up Docker resources
docker system prune -a
docker volume prune
```

### Logs and Debugging

```bash
# View container logs
docker compose logs -f dev

# Check container status
docker compose ps

# Inspect container
docker inspect node-ts-dev

# Shell into container
docker compose exec dev sh
```

## 🔗 Related Guides

- [Development Guide](development.md) - Development workflow
- [Configuration Guide](configuration.md) - Configuration files
- [Project Overview](project-overview.md) - Project structure

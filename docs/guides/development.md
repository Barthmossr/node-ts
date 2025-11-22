# Development Guide

Complete guide for setting up your development environment and working with this template.

## 📋 Table of Contents

- [Prerequisites](#prerequisites)
- [Initial Setup](#initial-setup)
- [Development Workflow](#development-workflow)
- [Project Scripts](#project-scripts)
- [Testing Guide](#testing-guide)
- [Building for Production](#building-for-production)
- [Troubleshooting](#troubleshooting)
- [Best Practices](#best-practices)

## ✅ Prerequisites

Before you begin, ensure you have the following installed:

### Required

- **Node.js v24.11.1**

  - Check version: `node --version`
  - Download: [nodejs.org](https://nodejs.org/)
  - We recommend using [nvm](https://github.com/nvm-sh/nvm) (Node Version Manager)

- **npm** (comes with Node.js)

  - Check version: `npm --version`
  - Should be v10+ for best compatibility

- **Git**
  - Check version: `git --version`
  - Download: [git-scm.com](https://git-scm.com/)

### Recommended

- **Visual Studio Code** (or any IDE of your choice)

  - Download: [code.visualstudio.com](https://code.visualstudio.com/)
  - Extensions we recommend:
    - ESLint
    - Prettier - Code formatter
    - EditorConfig for VS Code
    - GitLens
    - Jest Runner

- **nvm (Node Version Manager)**
  - Automatically use the correct Node.js version
  - Install: [github.com/nvm-sh/nvm](https://github.com/nvm-sh/nvm)

## 🚀 Initial Setup

### 1. Clone the Repository

```bash
# If using this as a template (recommended)
# Use GitHub's "Use this template" button, then clone your new repo

# If forking for contribution
git clone https://github.com/Barthmossr/node-ts.git
cd node-ts
```

### 2. Install Node.js Version

If you have nvm installed:

```bash
# Install the version specified in .nvmrc
nvm install

# Use the version
nvm use
```

Without nvm, ensure you have Node.js v24.11.1 installed.

### 3. Install Dependencies

```bash
npm install
```

This will:

- Install all project dependencies
- Set up Husky git hooks
- Prepare the development environment

### 4. Verify Setup

```bash
# Check if everything is working
npm run lint
npm test
npm run build
```

If all commands succeed, you're ready to develop! 🎉

## 🔄 Development Workflow

### Day-to-Day Development

```bash
# 1. Make sure you're on the latest develop branch
git checkout develop
git pull origin develop

# 2. Create a feature branch
git checkout -b feat/your-feature-name

# 3. Start development server (when implemented)
npm run dev

# 4. Make your changes
# Edit files in src/

# 5. Run tests in watch mode
npm run test:watch

# 6. Lint and format your code
npm run lint
npm run format

# 7. Commit your changes (commitlint will enforce standards)
git add .
git commit -m "feat: add new feature"

# 8. Push your branch
git push origin feat/your-feature-name

# 9. Open a Pull Request to develop branch on GitHub
```

### Git Hooks

Git hooks will automatically run on certain actions:

#### pre-commit

Runs automatically before each commit:

- Lints staged files with ESLint
- Formats staged files with Prettier
- Prevents commit if there are errors

#### commit-msg

Runs automatically on commit:

- Validates commit message format
- Ensures conventional commits standard
- Prevents commit if message is invalid

**Example**:

```bash
# ✅ Valid commit - will succeed
git commit -m "feat: add user authentication"

# ❌ Invalid commit - will fail
git commit -m "Added authentication"
# Error: commit message must follow conventional commits
```

## 📜 Project Scripts

### Development Scripts

```bash
# Start development server with hot reload (when implemented)
npm run dev

# Watch mode for development
npm run dev:watch
```

### Testing Scripts

```bash
# Run all tests
npm test

# Run only unit tests
npm run test:unit

# Run only integration tests
npm run test:integration

# Run only e2e tests
npm run test:e2e

# Run tests in watch mode
npm run test:watch

# Run tests with coverage report
npm run test:coverage

# Run specific test file
npm test -- path/to/test.test.ts
```

### Linting and Formatting

```bash
# Lint all files
npm run lint

# Lint and auto-fix issues
npm run lint:fix

# Format all files with Prettier
npm run format

# Check formatting without changing files
npm run format:check
```

### Build Scripts

```bash
# Build for production
npm run build

# Clean build directory
npm run clean

# Clean and rebuild
npm run clean:build
```

### Utility Scripts

```bash
# Type check without emitting files
npm run type-check

# Run all quality checks (lint, format, type-check, test)
npm run validate
```

## 🧪 Testing Guide

### Test Organization

Tests are organized by type in the `tests/` directory:

```
tests/
├── unit/              # Fast, isolated tests
│   └── app/
│       └── example.test.ts
├── integration/       # Component interaction tests
│   └── app/
│       └── example.integration.test.ts
└── e2e/              # End-to-end tests
    └── app/
        └── example.e2e.test.ts
```

### Writing Unit Tests

Unit tests test individual functions/classes in isolation.

**Example**:

```typescript
// tests/unit/app/math.test.ts
import { add } from "../../../src/app/math"

describe("add function", () => {
  it("should add two numbers correctly", () => {
    expect(add(2, 3)).toBe(5)
  })

  it("should handle negative numbers", () => {
    expect(add(-1, 1)).toBe(0)
  })

  it("should handle zero", () => {
    expect(add(0, 5)).toBe(5)
  })
})
```

**Best Practices**:

- ✅ Test one thing per test
- ✅ Use descriptive test names
- ✅ Mock external dependencies
- ✅ Test edge cases
- ✅ Keep tests fast

### Writing Integration Tests

Integration tests test multiple components working together.

**Example**:

```typescript
// tests/integration/app/service.integration.test.ts
import { UserService } from "../../../src/app/services/user-service"
import { Database } from "../../../src/app/database"

describe("UserService Integration", () => {
  let service: UserService
  let db: Database

  beforeAll(async () => {
    db = new Database()
    await db.connect()
    service = new UserService(db)
  })

  afterAll(async () => {
    await db.disconnect()
  })

  it("should create and retrieve user", async () => {
    const user = await service.createUser({ name: "John" })
    const retrieved = await service.getUser(user.id)
    expect(retrieved.name).toBe("John")
  })
})
```

**Best Practices**:

- ✅ Test real component interactions
- ✅ Use real dependencies (or realistic fakes)
- ✅ Clean up after tests
- ✅ Test happy path and error cases

### Writing E2E Tests

E2E tests test the complete system from user's perspective.

**Example**:

```typescript
// tests/e2e/app/api.e2e.test.ts
import request from "supertest"
import { app } from "../../../src/app/main"

describe("API E2E Tests", () => {
  it("should handle complete user flow", async () => {
    // Create user
    const createResponse = await request(app)
      .post("/api/users")
      .send({ name: "John" })
      .expect(201)

    const userId = createResponse.body.id

    // Get user
    await request(app)
      .get(`/api/users/${userId}`)
      .expect(200)
      .expect((res) => {
        expect(res.body.name).toBe("John")
      })

    // Update user
    await request(app)
      .put(`/api/users/${userId}`)
      .send({ name: "Jane" })
      .expect(200)

    // Verify update
    await request(app)
      .get(`/api/users/${userId}`)
      .expect(200)
      .expect((res) => {
        expect(res.body.name).toBe("Jane")
      })
  })
})
```

**Best Practices**:

- ✅ Test complete user workflows
- ✅ Use the application as a black box
- ✅ Test critical paths
- ✅ Keep tests independent

### Test Coverage

```bash
# Generate coverage report
npm run test:coverage
```

Coverage report will be generated in `coverage/` directory.

**Coverage Goals**:

- Overall: 80%+
- Critical paths: 100%
- New code: 90%+

**View Coverage**:

```bash
# Open HTML coverage report
open coverage/lcov-report/index.html
```

## 🏗️ Building for Production

### Build Process

```bash
# Build the project
npm run build
```

This will:

1. Clean the `dist/` directory
2. Compile TypeScript to JavaScript
3. Generate source maps
4. Copy necessary assets

### Build Output

```
dist/
├── app/
│   └── main.js
└── ...
```

### Test Production Build

```bash
# Build
npm run build

# Run the built application
node dist/app/main.js
```

## 🐛 Troubleshooting

### Common Issues

#### Issue: `command not found: npm`

**Solution**: Install Node.js which includes npm

```bash
# Install Node.js from nodejs.org
# Or use nvm
nvm install 24.11.1
```

#### Issue: `Cannot find module`

**Solution**: Install dependencies

```bash
rm -rf node_modules package-lock.json
npm install
```

#### Issue: Git hooks not working

**Solution**: Reinstall Husky

```bash
npm run prepare
```

#### Issue: Tests failing

**Solution**: Check Node.js version and dependencies

```bash
node --version  # Should be v24.11.1
npm ci  # Clean install
npm test
```

#### Issue: Lint errors

**Solution**: Auto-fix what can be fixed

```bash
npm run lint:fix
npm run format
```

#### Issue: TypeScript errors

**Solution**: Check TypeScript configuration

```bash
npm run type-check
# Fix errors shown in output
```

### Getting Help

1. **Check Documentation**: Read the docs in `docs/guides/`
2. **Search Issues**: Look for similar issues on GitHub
3. **Ask for Help**: Open an issue with the `question` label

### Debug Mode

For more verbose output:

```bash
# Debug Jest tests
DEBUG=* npm test

# Debug with Node.js inspector
node --inspect-brk node_modules/.bin/jest --runInBand

# TypeScript verbose
npm run build -- --verbose
```

## 💡 Best Practices

### Code Style

- ✅ Use TypeScript strict mode
- ✅ Define explicit return types
- ✅ Avoid `any` type
- ✅ Use meaningful variable names
- ✅ Keep functions small and focused
- ✅ Write self-documenting code
- ✅ Add comments for complex logic

### File Organization

- ✅ Follow the folder structure
- ✅ One class/function per file (when large)
- ✅ Group related files in subdirectories
- ✅ Use index.ts for exports
- ✅ Keep files under 300 lines

### Git Workflow

- ✅ Commit often with clear messages
- ✅ Keep commits focused and atomic
- ✅ Branch from develop, not main
- ✅ Pull before pushing
- ✅ Rebase to keep history clean

### Testing

- ✅ Write tests before fixing bugs
- ✅ Test edge cases
- ✅ Use descriptive test names
- ✅ Keep tests independent
- ✅ Don't test implementation details

### Performance

- ✅ Avoid premature optimization
- ✅ Profile before optimizing
- ✅ Use async/await properly
- ✅ Clean up resources (close connections, clear timers)

## 🎯 Development Checklist

Before submitting a PR, ensure:

- [ ] Code follows style guidelines
- [ ] All tests pass
- [ ] New tests added for new features
- [ ] Code coverage maintained
- [ ] No TypeScript errors
- [ ] No ESLint warnings
- [ ] Documentation updated
- [ ] Commit messages follow conventions
- [ ] Branch name follows conventions
- [ ] CI checks pass

## 🔗 Related Guides

- [Project Overview](project-overview.md) - Understanding the project
- [Libraries](libraries.md) - Why we chose these tools
- [Configuration](configuration.md) - Configuration details
- [Contributing](../../CONTRIBUTING.md) - Contribution guidelines

---

**Happy Coding! 🚀**

Need help? Open an issue on [GitHub](https://github.com/Barthmossr/node-ts/issues).

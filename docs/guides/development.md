# Development Guide

Complete guide for setting up your development environment and working with this template.

## 📋 Table of Contents

- [Prerequisites](#prerequisites)
- [Initial Setup](#initial-setup)
- [Development Workflow](#development-workflow)
- [Project Scripts](#project-scripts)
- [Testing Guide](#testing-guide)
- [Building for Production](#building-for-production)
- [Git Workflow](#git-workflow)
- [CI/CD](#cicd)
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

- **nvm (Node Version Manager)**
  - Automatically use the correct Node.js version
  - Install: [github.com/nvm-sh/nvm](https://github.com/nvm-sh/nvm)

### VS Code Extensions

Extensions are automatically suggested from `.vscode/extensions.json`:

- **ESLint** - Code linting
- **Prettier** - Code formatting
- **EditorConfig** - Editor settings
- **Jest** - Test runner integration
- **GitLens** - Git history and blame
- **Conventional Commits** - Commit message helper

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

### 3. Run Setup

**Option 1: Use the setup script (recommended)**

```bash
./scripts/setup.sh
```

This script will:

- Check Node.js version
- Install all dependencies
- Set up Husky git hooks
- Run validation checks
- Display available commands

**Option 2: Manual setup**

```bash
# Install dependencies
npm install

# Verify setup
npm run validate
```

If all checks pass, you're ready to develop! 🎉

## 🔄 Development Workflow

### Day-to-Day Development

```bash
# 1. Make sure you're on the latest develop branch
git checkout develop
git pull origin develop

# 2. Create a feature branch
git checkout -b feat/your-feature-name

# 3. Start development server
npm run dev        # Single run
npm run dev:watch  # With hot reload

# 4. Run tests in watch mode while developing
npm run test:watch

# 5. Before committing, validate your changes
npm run validate

# 6. Commit your changes (hooks will run automatically)
git add .
git commit -m "feat: add new feature"

# 7. Push your branch
git push origin feat/your-feature-name

# 8. Open a Pull Request to develop branch on GitHub
```

### Git Hooks (Husky)

Git hooks run automatically on certain actions:

#### pre-commit

Runs lint-staged which:

- Lints staged `.js` and `.ts` files with ESLint
- Formats staged files with Prettier
- Prevents commit if there are errors

#### commit-msg

Runs commitlint which:

- Validates commit message format
- Ensures conventional commits standard
- Prevents commit if message is invalid

#### pre-push

Runs tests before pushing:

- Ensures all tests pass
- Prevents push if tests fail

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

| Script      | Command                     | Description             |
| ----------- | --------------------------- | ----------------------- |
| `dev`       | `tsx src/app/main.ts`       | Run TypeScript directly |
| `dev:watch` | `tsx watch src/app/main.ts` | Run with hot reload     |
| `start`     | `node dist/app/main.js`     | Run built application   |

### Build Scripts

| Script      | Command                      | Description            |
| ----------- | ---------------------------- | ---------------------- |
| `build`     | `tsc -p tsconfig.build.json` | Compile TypeScript     |
| `clean`     | `rimraf dist coverage`       | Remove build artifacts |
| `typecheck` | `tsc --noEmit`               | Check types only       |

### Quality Scripts

| Script         | Command                           | Description            |
| -------------- | --------------------------------- | ---------------------- |
| `lint`         | `eslint .`                        | Check code with ESLint |
| `lint:fix`     | `eslint . --fix`                  | Auto-fix ESLint issues |
| `format`       | `prettier --write .`              | Format all files       |
| `format:check` | `prettier --check .`              | Check formatting       |
| `validate`     | lint + format + typecheck + build | Run all checks         |

### Test Scripts

| Script          | Command           | Description              |
| --------------- | ----------------- | ------------------------ |
| `test`          | `jest`            | Run all tests            |
| `test:watch`    | `jest --watch`    | Run in watch mode        |
| `test:coverage` | `jest --coverage` | Generate coverage report |

### Other Scripts

| Script    | Command   | Description                   |
| --------- | --------- | ----------------------------- |
| `check`   | `ncu -ui` | Interactive dependency update |
| `prepare` | `husky`   | Set up git hooks              |

## 🧪 Testing Guide

### Test Organization

Tests mirror the `src/` structure in the `tests/` directory:

```
tests/
├── setup.ts          # Global test setup
└── app/
    └── main.test.ts  # Tests for src/app/main.ts
```

### Writing Tests

```typescript
// tests/app/main.test.ts
import { main } from '@/app/main'

describe('main', () => {
  it('should return void', () => {
    const result = main()
    expect(result).toBeUndefined()
  })
})
```

**Best Practices**:

- ✅ Use `it('should...')` format for test names
- ✅ Test one thing per test
- ✅ Use path alias `@/*` for imports
- ✅ Test edge cases
- ✅ Keep tests fast and independent

### Running Tests

```bash
# Run all tests
npm test

# Watch mode (great for development)
npm run test:watch

# Generate coverage report
npm run test:coverage
```

### Test Coverage

Coverage thresholds are set to **100%** for:

- Branches
- Functions
- Lines
- Statements

Coverage reports are generated in multiple formats:

- `text`: Console output
- `lcov`: For CI tools
- `html`: Visual report in `coverage/`
- `json-summary`: For badges

**View Coverage Report**:

```bash
# Open HTML coverage report (macOS)
open coverage/lcov-report/index.html

# Open HTML coverage report (Windows)
start coverage/lcov-report/index.html
```

## 🏗️ Building for Production

### Build Process

```bash
# Build the project
npm run build
```

This will:

1. Compile TypeScript to JavaScript using `tsconfig.build.json`
2. Output to `dist/` directory
3. Generate source maps and declaration files

### Build Output

```
dist/
└── app/
    └── main.js
```

### Test Production Build

```bash
# Build and run
npm run build
npm start
```

## 🔄 Git Workflow

### Branching Strategy

- **main**: Production-ready code
- **develop**: Integration branch
- **feat/\***: New features
- **fix/\***: Bug fixes
- **chore/\***: Maintenance tasks

### Commit Messages

Follow Conventional Commits specification:

```
<type>[optional scope]: <description>

[optional body]

[optional footer(s)]
```

**Types**:

- **feat**: New feature
- **fix**: Bug fix
- **docs**: Documentation only
- **style**: Code style (formatting, no logic change)
- **refactor**: Code change that neither fixes a bug nor adds a feature
- **perf**: Performance improvement
- **test**: Adding or updating tests
- **chore**: Maintenance tasks
- **ci**: CI/CD changes
- **build**: Build system changes

**Examples**:

```bash
feat: add user authentication
fix: resolve login timeout issue
docs: update API documentation
chore: update dependencies
```

### Pull Request Process

1. Create feature branch from `develop`
2. Make changes with conventional commits
3. Ensure all checks pass (`npm run validate`)
4. Create PR to `develop`
5. Request review
6. Merge after approval

## 🚢 CI/CD

### GitHub Actions Workflows

Two workflows are configured in `.github/workflows/`:

#### validate.yml

Runs on every push and PR:

1. Checkout code
2. Setup Node.js (from `.nvmrc`)
3. Install dependencies (`npm ci`)
4. Run lint check
5. Run format check
6. Run type check
7. Build project

#### test.yml

Runs on every push and PR:

1. Checkout code
2. Setup Node.js
3. Install dependencies
4. Run tests with coverage
5. Upload coverage to Codecov
6. Generate coverage badge
7. Upload artifacts

### Required Secrets

For full CI/CD functionality, add these secrets in GitHub:

- `CODECOV_TOKEN`: For coverage uploads (optional but recommended)

## 🐛 Troubleshooting

### Common Issues

#### Issue: `command not found: npm`

**Solution**: Install Node.js which includes npm

```bash
# Install Node.js from nodejs.org
# Or use nvm
nvm install 24.11.1
```

#### Issue: Node.js Version Mismatch

```bash
# Error: The engine "node" is incompatible
nvm use
```

#### Issue: `Cannot find module`

**Solution**: Install dependencies

```bash
rm -rf node_modules package-lock.json
npm install
```

#### Issue: ESLint Config Not Loading

```bash
# Error: Cannot find module 'jiti'
npm install
```

The `jiti` package is required for TypeScript ESLint config files.

#### Issue: Git hooks not working

**Solution**: Reinstall Husky

```bash
npm run prepare
```

#### Issue: TypeScript errors in tests

Ensure `tsconfig.json` includes both `src` and `tests`:

```json
{
  "include": ["src/**/*", "tests/**/*"]
}
```

#### Issue: Coverage Below Threshold

Coverage must be 100%. Check the detailed report:

```bash
npm run test:coverage
# Open coverage/lcov-report/index.html
```

### Getting Help

1. **Check Documentation**: Read the docs in `docs/guides/`
2. **Search Issues**: Look for similar issues on GitHub
3. **Ask for Help**: Open an issue with the `question` label

## 💡 Best Practices

### Code Style

- ✅ Use TypeScript strict mode
- ✅ Define explicit return types for all functions
- ✅ Never use `any` type
- ✅ Use single quotes (no semicolons)
- ✅ Keep functions under 20 lines
- ✅ Keep files under 100 lines
- ✅ Use path aliases (`@/*`) for imports

### File Organization

- ✅ Follow the folder structure
- ✅ Types in `*.types.ts` files
- ✅ Styles in `*.styles.ts` files
- ✅ Use `index.ts` for module exports
- ✅ Never export inline with declarations

### Git Workflow

- ✅ Commit often with clear messages
- ✅ Keep commits focused and atomic
- ✅ Branch from develop, not main
- ✅ Pull before pushing
- ✅ Use conventional commit format

### Testing

- ✅ Write tests alongside code
- ✅ Test edge cases
- ✅ Use `it('should...')` format
- ✅ Keep tests independent
- ✅ Aim for 100% coverage

## 🎯 Development Checklist

Before submitting a PR, ensure:

- [ ] Code follows style guidelines (no semi, single quotes)
- [ ] All tests pass
- [ ] New tests added for new features
- [ ] Code coverage is 100%
- [ ] No TypeScript errors (`npm run typecheck`)
- [ ] No ESLint warnings (`npm run lint`)
- [ ] Code is formatted (`npm run format:check`)
- [ ] Commit messages follow conventions
- [ ] CI checks pass

## 🔗 Related Guides

- [Project Overview](project-overview.md) - Understanding the project
- [Libraries](libraries.md) - Why we chose these tools
- [Configuration](configuration.md) - Configuration details
- [Contributing](../CONTRIBUTING.md) - Contribution guidelines

---

**Happy Coding! 🚀**

Need help? Open an issue on [GitHub](https://github.com/Barthmossr/node-ts/issues).

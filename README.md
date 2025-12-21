# Node ts

> A production-ready Node.js TypeScript template repository with comprehensive development tooling, CI/CD pipelines, and strict organizational standards.

<!-- CI/CD Status -->

[![CI - Validate](https://github.com/Barthmossr/node-ts/actions/workflows/validate.yml/badge.svg)](https://github.com/Barthmossr/node-ts/actions/workflows/validate.yml)
[![CI - Test](https://github.com/Barthmossr/node-ts/actions/workflows/test.yml/badge.svg)](https://github.com/Barthmossr/node-ts/actions/workflows/test.yml)
[![CI - Security](https://github.com/Barthmossr/node-ts/actions/workflows/security.yml/badge.svg)](https://github.com/Barthmossr/node-ts/actions/workflows/security.yml)

<!-- Code Quality -->

[![Code Coverage](https://img.shields.io/badge/coverage-100%25-brightgreen.svg)](https://codecov.io/gh/Barthmossr/node-ts)

<!-- Technology -->

[![Node.js Version](https://img.shields.io/badge/node-v24.12.0-brightgreen.svg)](https://nodejs.org/)
[![TypeScript](https://img.shields.io/badge/TypeScript-v5.9.3-blue.svg)](https://www.typescriptlang.org/)
[![ESLint](https://img.shields.io/badge/ESLint-v9.39.2-4B32C3.svg)](https://eslint.org/)
[![Prettier](https://img.shields.io/badge/Prettier-v3.7.4-F7B93E.svg)](https://prettier.io/)
[![Jest](https://img.shields.io/badge/Jest-v30.2.0-C21325.svg)](https://jestjs.io/)

<!-- Standards -->

[![Conventional Commits](https://img.shields.io/badge/Conventional%20Commits-1.0.0-FE5196.svg?logo=conventionalcommits&logoColor=white)](https://conventionalcommits.org)
[![Commitizen friendly](https://img.shields.io/badge/commitizen-friendly-brightgreen.svg)](http://commitizen.github.io/cz-cli/)
[![code style: prettier](https://img.shields.io/badge/code_style-prettier-ff69b4.svg)](https://github.com/prettier/prettier)
[![ESLint: strict](https://img.shields.io/badge/ESLint-strict-4B32C3.svg)](https://eslint.org/)

<!-- Module & Package -->

[![ES Modules](https://img.shields.io/badge/ES%20Modules-enabled-yellow.svg)](https://nodejs.org/api/esm.html)
[![npm](https://img.shields.io/badge/npm-package%20manager-CB3837.svg?logo=npm)](https://www.npmjs.com/)

<!-- License -->

[![License](https://img.shields.io/badge/license-MIT-red.svg)](LICENSE)

## 📋 Overview

**Node ts** is a general-purpose Node.js TypeScript template designed to serve as a solid foundation for future projects. This template provides everything you need to start a new project with best practices already in place, including:

- 🏗️ **Strict folder structure** - No loose files, organized subfolders for everything
- 🛠️ **Complete development tooling** - ESLint (flat config), Prettier, Husky, commitlint
- 🧪 **Testing infrastructure** - Jest with 100% coverage threshold
- 🚀 **CI/CD pipelines** - GitHub Actions with validation, test, and security workflows
- 🐳 **Docker support** - Development and production containerization
- 🤖 **AI Agent guidelines** - Copilot instructions for consistent code generation
- 📝 **Conventional commits** - Enforced for all commits
- 📚 **Comprehensive documentation** - Detailed guides for all aspects

## 🎯 Objectives

This template is intentionally **framework-agnostic** and **database-agnostic**. The focus is on:

1. **Security** - Input validation, secure patterns, and regular audits (Critical Priority)
2. **Performance** - Optimized for any device, efficient resource usage (High Priority)
3. **Accessibility** - WCAG 2.1 AA compliant foundations (High Priority)
4. **Development Environment** - Robust, consistent development experience
5. **Code Quality** - Enforcing best practices through linting, formatting, and testing
6. **Automation** - CI/CD pipelines for validation, testing, and security
7. **Structure** - Scalable, organized folder structure
8. **Documentation** - Clear guidance for contributors and users

### Future Plans

This template will serve as the base for specialized templates:

- Backend API template
- Frontend application template
- Full-stack template
- And more...

## 🚀 Quick Start

```bash
# Clone the repository
git clone https://github.com/Barthmossr/node-ts.git
cd node-ts

# Option 1: Use the setup script (recommended)
./scripts/setup.sh

# Option 2: Manual setup
nvm use
npm install

# Run in development mode
npm run dev

# Run tests
npm test

# Build for production
npm run build
```

## 🛠️ Technology Stack

| Tool        | Version  | Purpose                |
| ----------- | -------- | ---------------------- |
| Node.js     | v24.12.0 | Runtime                |
| TypeScript  | ^5.9.3   | Type system            |
| ESLint      | ^9.39.2  | Linting (flat config)  |
| Prettier    | ^3.7.4   | Formatting             |
| Jest        | ^30.2.0  | Testing                |
| Husky       | ^9.1.7   | Git hooks              |
| lint-staged | ^16.2.7  | Pre-commit linting     |
| commitlint  | ^20.2.0  | Commit message linting |
| tsx         | ^4.21.0  | Direct TS execution    |
| tsdown      | ^0.18.2  | Build bundler          |

## 📁 Project Structure

```
node-ts/
├── src/
│   └── app/              # Application code
│       └── main.ts       # Entry point
├── tests/
│   ├── setup.ts          # Global test setup
│   └── unit/
│       └── app/
│           └── main.test.ts  # Tests mirror src/ structure
├── docs/
│   ├── CONTRIBUTING.md
│   ├── README.md
│   └── guides/           # Documentation files
├── docker/
│   ├── docker-compose.yml
│   ├── Dockerfile
│   └── Dockerfile.dev    # Docker configurations
├── scripts/
│   └── setup.sh          # Setup script
├── .github/
│   ├── workflows/        # CI/CD workflows
│   └── copilot-instructions.md  # AI Agent guidelines
├── .devcontainer/        # VS Code Dev Container
├── .vscode/              # Editor configuration
└── dist/                 # Build output (git ignored)
```

**Strict Rule**: No loose files directly in main directories. All files must be organized in appropriate subfolders.

## 📜 Available Scripts

| Script                     | Description                   |
| -------------------------- | ----------------------------- |
| `npm run dev`              | Run TypeScript directly       |
| `npm run dev:watch`        | Run with hot reload           |
| `npm run build`            | Compile to JavaScript         |
| `npm start`                | Run built application         |
| `npm run typecheck`        | Check TypeScript types        |
| `npm run lint`             | Check code with ESLint        |
| `npm run lint:fix`         | Auto-fix ESLint issues        |
| `npm run format`           | Format with Prettier          |
| `npm run format:check`     | Check formatting              |
| `npm run validate`         | Run all quality checks        |
| `npm test`                 | Run tests                     |
| `npm run test:watch`       | Tests in watch mode           |
| `npm run test:coverage`    | Generate coverage report      |
| `npm run check`            | Interactive dependency update |
| `npm run clean`            | Remove build artifacts        |
| `npm run docker:dev`       | Run dev container             |
| `npm run docker:dev:build` | Build and run dev container   |
| `npm run docker:prod`      | Run production container      |
| `npm run docker:test`      | Run tests in container        |
| `npm run docker:down`      | Stop containers               |
| `npm run docker:clean`     | Clean containers and volumes  |

## 🌿 Branch Strategy

- **`main`** - Production/deployment branch (only merge from `develop`)
- **`develop`** - Development and testing branch (merge feature branches here)
- **Feature branches** - Follow conventional commits format:
  - `feat/` - New features
  - `fix/` - Bug fixes
  - `docs/` - Documentation updates
  - `refactor/` - Code refactoring
  - `test/` - Test additions/updates
  - `chore/` - Maintenance tasks

## 📖 Documentation

For detailed documentation, please refer to the `docs/` directory:

- [Contributing Guidelines](docs/CONTRIBUTING.md) - How to contribute to this project
- [Project Overview](docs/guides/project-overview.md) - Architectural decisions and rationale
- [Library Decisions](docs/guides/libraries.md) - Why each tool was chosen
- [Development Guide](docs/guides/development.md) - Setup and workflow instructions
- [Configuration Guide](docs/guides/configuration.md) - Understanding config files
- [Docker Guide](docs/guides/docker.md) - Docker setup and usage

## 🧪 Testing

```bash
# Run all tests
npm test

# Run tests with coverage
npm run test:coverage

# Run tests in watch mode
npm run test:watch
```

Coverage threshold is set to **100%** for branches, functions, lines, and statements.

## ✅ Code Quality

This template enforces:

- **No semicolons** - Cleaner code
- **Single quotes** - Consistency
- **No `any` type** - Type safety
- **Explicit return types** - Self-documenting code
- **100% test coverage** - Quality assurance

## 🤝 Contributing

We follow strict conventional commit standards. Please read [CONTRIBUTING.md](docs/CONTRIBUTING.md) for details.

**All pull requests must be made to the `develop` branch, not `main`.**

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🔗 Links

- [GitHub Repository](https://github.com/Barthmossr/node-ts)
- [Issue Tracker](https://github.com/Barthmossr/node-ts/issues)
- [Documentation](docs/README.md)

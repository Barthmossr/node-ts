# Node ts

> A production-ready Node.js TypeScript template repository with comprehensive development tooling, CI/CD pipelines, and strict organizational standards.

[![Node.js Version](https://img.shields.io/badge/node-v24.11.1-brightgreen.svg)](https://nodejs.org/)
[![TypeScript](https://img.shields.io/badge/TypeScript-v5.9.3-blue.svg)](https://www.typescriptlang.org/)
[![License](https://img.shields.io/badge/license-MIT-red.svg)](LICENSE)

## 📋 Overview

**Node ts** is a general-purpose Node.js TypeScript template designed to serve as a solid foundation for future projects. This template provides everything you need to start a new project with best practices already in place, including:

- 🏗️ **Strict folder structure** - No loose files, organized subfolders for everything
- 🛠️ **Complete development tooling** - ESLint, Prettier, Husky, commitlint
- 🧪 **Testing infrastructure** - Jest with unit, integration, and e2e test support
- 🚀 **CI/CD pipelines** - GitHub Actions with automated testing and Vercel deployment
- 📝 **Conventional commits** - Enforced for commits and branch names
- 🐳 **Docker support** - Development and production containerization
- 📚 **Comprehensive documentation** - Detailed guides for all aspects of the project

## 🎯 Objectives

This template is intentionally **framework-agnostic** and **database-agnostic**. The focus is on:

1. **Development Environment** - Setting up a robust, consistent development experience
2. **Code Quality** - Enforcing best practices through linting, formatting, and testing
3. **Automation** - CI/CD pipelines for testing, deployment, and releases
4. **Structure** - A scalable, organized folder structure with strict rules
5. **Documentation** - Clear guidance for contributors and users

### Future Plans

This template will serve as the base for specialized templates:

- Mobile application template
- Backend API template
- Frontend application template
- And more...

## 🚀 Quick Start

```bash
# Clone the repository
git clone https://github.com/Barthmossr/node-ts.git

# Install dependencies
npm install

# Run in development mode
npm run dev

# Run tests
npm test

# Build for production
npm run build
```

## 🛠️ Technology Stack

- **Runtime**: Node.js v24.11.1
- **Language**: TypeScript
- **Package Manager**: npm v11.6.2
- **Testing**: Jest (unit, integration, e2e)
- **Linting**: ESLint
- **Formatting**: Prettier
- **Git Hooks**: Husky + lint-staged
- **Commit Standards**: commitlint (conventional commits)
- **CI/CD**: GitHub Actions
- **Deployment**: Vercel
- **Containerization**: Docker

## 📁 Project Structure

```
node-ts/
├── src/
│   └── app/              # Application code
├── tests/
│   ├── unit/            # Unit tests
│   ├── integration/     # Integration tests
│   └── e2e/             # End-to-end tests
├── docs/
│   └── guides/          # Documentation files
├── scripts/
│   └── utils/           # Utility scripts
├── .github/
│   └── workflows/       # CI/CD workflows
├── docker/
│   └── configs/         # Docker configuration
└── package.json
```

**Strict Rule**: No loose files directly in main directories. All files must be organized in appropriate subfolders.

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

- [Contributing Guidelines](docs/contributing.md) - How to contribute to this project
- [Project Overview](docs/guides/project-overview.md) - Architectural decisions and rationale
- [Library Decisions](docs/guides/libraries.md) - Why each tool was chosen
- [Development Guide](docs/guides/development.md) - Setup and workflow instructions
- [Docker Guide](docs/guides/docker.md) - Container setup and usage
- [Configuration Guide](docs/guides/configuration.md) - Understanding config files

## 🧪 Testing

This template supports three types of tests:

```bash
# Run all tests
npm test

# Run specific test types
npm run test:unit
npm run test:integration
npm run test:e2e

# Run tests with coverage
npm run test:coverage

# Run tests in watch mode
npm run test:watch
```

## 🤝 Contributing

We follow strict conventional commit standards for both commits and branch names. Please read [CONTRIBUTING.md](CONTRIBUTING.md) for details on our code of conduct and the process for submitting pull requests.

**All pull requests must be made to the `develop` branch, not `main`.**

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🔗 Links

- [GitHub Repository](https://github.com/Barthmossr/node-ts)
- [Issue Tracker](https://github.com/Barthmossr/node-ts/issues)
- [Documentation](docs/)

---

**Note**: This is a template repository. Detailed documentation will be created as features are implemented. For now, this README provides a high-level overview of the project's goals and structure.

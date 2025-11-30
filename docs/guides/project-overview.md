# Project Overview

## 📖 Introduction

**Node ts** is a comprehensive Node.js TypeScript template repository designed to serve as a production-ready foundation for future projects. This document explains the architectural decisions, design philosophy, and rationale behind this template.

## 🎯 Philosophy

### General-Purpose by Design

This template is intentionally **framework-agnostic** and **database-agnostic**. We believe in:

1. **Flexibility** - Not locking developers into specific frameworks or databases
2. **Modularity** - Easy to add or remove components based on project needs
3. **Standards** - Enforcing best practices that apply to any Node.js project
4. **Simplicity** - Starting with essentials, not overwhelming with choices

### What This Template IS

✅ **A solid foundation** for Node.js TypeScript projects  
✅ **A development environment** with modern tooling  
✅ **A standard** for code quality and organization  
✅ **A starting point** that can be customized  
✅ **A template** for creating specialized templates

### What This Template IS NOT

❌ **NOT a full-stack framework** (no Express, Fastify, NestJS, etc.)  
❌ **NOT database-specific** (no MongoDB, PostgreSQL, etc.)  
❌ **NOT opinionated about architecture** (no MVC, Clean Architecture, etc.)  
❌ **NOT a production application** (no business logic)  
❌ **NOT feature-complete** (intentionally minimal)

## 🏗️ Architectural Decisions

### 1. ES Modules (ESM)

**Decision**: Use ES modules (`"type": "module"`) as the module system.

**Rationale**:

- **Modern Standard**: ESM is the official JavaScript module standard
- **Future-Proof**: Node.js is moving towards ESM
- **Tree Shaking**: Better support for bundler optimizations
- **Interoperability**: Works well with modern TypeScript settings

### 2. Strict Folder Structure

**Decision**: Enforce a strict folder structure with no loose files at the root of any directory.

**Rationale**:

- **Scalability**: Easy to add new modules without cluttering directories
- **Organization**: Clear separation of concerns
- **Consistency**: Everyone knows where files should go
- **Maintainability**: Easier to navigate large codebases

**Example**:

```
❌ BAD: src/main.ts (loose file in src/)
✅ GOOD: src/app/main.ts (file in proper subdirectory)
```

### 3. TypeScript First

**Decision**: Use TypeScript as the primary language with strict mode enabled.

**Rationale**:

- **Type Safety**: Catch errors at compile time, not runtime
- **Developer Experience**: Better autocomplete and IDE support
- **Documentation**: Types serve as inline documentation
- **Refactoring**: Safer and easier to refactor code
- **Industry Standard**: TypeScript is now the standard for modern Node.js projects

**Key TypeScript Settings**:

- ES2022 target with ESNext modules
- Bundler module resolution
- All strict options enabled
- Path aliases (`@/*` maps to `src/*`)
- Separate build config for production

### 4. Conventional Commits

**Decision**: Strictly enforce conventional commits using commitlint and Husky.

**Rationale**:

- **Automation**: Enables automated versioning and changelogs
- **Clarity**: Clear commit history for everyone
- **Standardization**: Industry-standard practice
- **Tooling**: Works with semantic-release and other tools
- **Consistency**: Branches and commits follow the same pattern

### 5. Git Flow Branch Strategy

**Decision**: Use a Git Flow-inspired branching model with `main`, `develop`, and feature branches.

**Rationale**:

- **Stability**: `main` is always production-ready
- **Safety**: Development happens in isolation
- **Review Process**: All changes go through PRs to `develop`
- **Deployment**: Clean separation between development and production
- **Rollback**: Easy to roll back changes if needed

### 6. 100% Test Coverage

**Decision**: Require 100% code coverage for all tests.

**Rationale**:

- **Quality**: Forces thoughtful code design
- **Confidence**: High confidence in code correctness
- **Regression**: Prevents bugs from reappearing
- **Documentation**: Tests serve as usage examples
- **Best Practice**: Industry standard for quality assurance

### 7. CI/CD from Day One

**Decision**: Include CI/CD pipelines from the start, not as an afterthought.

**Workflows**:

- **validate.yml**: Lint, format check, typecheck, build
- **test.yml**: Run tests with coverage, upload to Codecov

**Rationale**:

- **Automation**: Automated testing and deployment save time
- **Quality**: Catch issues before they reach production
- **Standards**: Enforce code quality automatically
- **Best Practice**: Modern development requires automation

### 8. ESLint Flat Config

**Decision**: Use ESLint's modern flat config format with TypeScript config file.

**Rationale**:

- **Modern**: Flat config is the future of ESLint
- **Type Safety**: TypeScript config file for better IDE support
- **Simpler**: Single file configuration
- **Explicit**: Clear configuration hierarchy

### 9. Code Style (No Semicolons, Single Quotes)

**Decision**: Use single quotes and no semicolons throughout the codebase.

**Rationale**:

- **Consistency**: One style everywhere
- **Simplicity**: Less visual noise
- **ASI**: JavaScript's automatic semicolon insertion works reliably
- **Modern**: Common in modern JavaScript/TypeScript projects

### 10. npm as Package Manager

**Decision**: Use npm as the official package manager (with future consideration for Bun).

**Rationale**:

- **Compatibility**: Works everywhere Node.js works
- **Stability**: Mature and battle-tested
- **Features**: Modern npm has most features of alternatives
- **Default**: Ships with Node.js by default
- **Future-Proof**: Can migrate to Bun when it's more mature

## 📁 Folder Structure

```
node-ts/
├── src/
│   └── app/              # Application code
│       └── main.ts       # Entry point
├── tests/
│   ├── setup.ts          # Global test setup
│   └── app/
│       └── main.test.ts  # Tests mirror src/ structure
├── docs/
│   ├── CONTRIBUTING.md
│   ├── README.md
│   └── guides/           # Detailed documentation
├── scripts/
│   └── setup.sh          # Setup and utility scripts
├── .github/
│   └── workflows/        # CI/CD automation
├── .vscode/              # Editor configuration
└── dist/                 # Build output (git ignored)
```

### Why This Structure

1. **Tests mirror src/**: Easy to find corresponding tests
2. **Docs in dedicated folder**: Documentation organized separately
3. **VS Code config included**: Consistent editor experience
4. **Build output ignored**: Only source in version control

## 🛠️ Tooling Stack

| Tool              | Purpose                | Version  |
| ----------------- | ---------------------- | -------- |
| Node.js           | Runtime                | v24.11.1 |
| TypeScript        | Type system            | ^5.9.3   |
| ESLint            | Linting                | ^9.39.1  |
| Prettier          | Formatting             | ^3.7.3   |
| Jest              | Testing                | ^30.2.0  |
| Husky             | Git hooks              | ^9.1.7   |
| lint-staged       | Pre-commit linting     | ^16.2.7  |
| commitlint        | Commit message linting | ^20.1.0  |
| tsx               | Direct TS execution    | ^4.20.6  |
| npm-check-updates | Dependency updates     | ^19.1.2  |

## 📜 Available Scripts

| Script                  | Description                   |
| ----------------------- | ----------------------------- |
| `npm run dev`           | Run TypeScript directly       |
| `npm run dev:watch`     | Run with hot reload           |
| `npm run build`         | Compile to JavaScript         |
| `npm start`             | Run built application         |
| `npm run typecheck`     | Check TypeScript types        |
| `npm run lint`          | Check code with ESLint        |
| `npm run lint:fix`      | Auto-fix ESLint issues        |
| `npm run format`        | Format with Prettier          |
| `npm run format:check`  | Check formatting              |
| `npm run validate`      | Run all quality checks        |
| `npm test`              | Run tests                     |
| `npm run test:watch`    | Tests in watch mode           |
| `npm run test:coverage` | Generate coverage report      |
| `npm run check`         | Interactive dependency update |
| `npm run clean`         | Remove build artifacts        |

## 🎓 Design Principles

### 1. Convention Over Configuration

We prefer established conventions (conventional commits, Git Flow, etc.) over custom configurations.

### 2. Explicit Over Implicit

Configuration files are explicit and well-documented. No "magic" behavior.

### 3. Quality Over Speed

We prioritize code quality and maintainability over rapid development.

### 4. Documentation is Code

Documentation is treated with the same importance as code.

### 5. Automation Where Possible

Automate repetitive tasks (testing, linting, deployment) to reduce human error.

## 🚀 Future Plans

### Specialized Templates

This template will serve as the foundation for specialized templates:

1. **Backend API Template**
   - Add Express/Fastify
   - Add database support (PostgreSQL, MongoDB, etc.)
   - Add authentication/authorization
   - Add API documentation (Swagger/OpenAPI)

2. **Frontend Template**
   - Add React/Vue/Svelte
   - Add bundler configuration
   - Add styling solutions
   - Add state management

3. **Full-Stack Template**
   - Combine backend and frontend
   - Add monorepo structure
   - Add shared types

### Docker Support

Docker configuration is planned for a future branch:

- Multi-stage builds
- Development and production images
- Docker Compose for local development

### Continuous Improvement

We will continuously:

- **Update dependencies** to latest stable versions
- **Improve documentation** based on feedback
- **Add best practices** as they emerge
- **Simplify setup** to reduce friction
- **Enhance automation** to improve efficiency

## 📚 Learning Resources

To understand the concepts in this template:

- [Conventional Commits](https://www.conventionalcommits.org/)
- [Git Flow](https://nvie.com/posts/a-successful-git-branching-model/)
- [TypeScript Handbook](https://www.typescriptlang.org/docs/handbook/intro.html)
- [ESLint Flat Config](https://eslint.org/docs/latest/use/configure/configuration-files-new)
- [Jest Testing](https://jestjs.io/docs/getting-started)
- [Husky](https://typicode.github.io/husky/)

## 🎯 Success Metrics

We consider this template successful if:

1. **Easy to start**: New projects can be created in minutes
2. **Easy to maintain**: Code remains clean and organized
3. **Easy to scale**: Adding features doesn't create chaos
4. **Easy to understand**: New developers can onboard quickly
5. **Production-ready**: Can deploy to production with confidence

## 💭 Philosophy Summary

> "A template should provide the foundation, not the building. It should enforce quality without restricting creativity. It should be simple to start with, yet powerful enough to grow into any project."

---

**Next Steps**: Check out our [Development Guide](development.md) to start building on this foundation.

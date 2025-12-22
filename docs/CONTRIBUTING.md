# Contributing to Node ts

Thank you for your interest in contributing to **Node ts**! This document provides guidelines and instructions for contributing to this project.

## 📋 Table of Contents

- [Code of Conduct](#code-of-conduct)
- [Getting Started](#getting-started)
- [Development Workflow](#development-workflow)
- [Branch Strategy](#branch-strategy)
- [Commit Standards](#commit-standards)
- [Pull Request Process](#pull-request-process)
- [Testing Requirements](#testing-requirements)
- [Code Review](#code-review)

## 📜 Code of Conduct

This project adheres to the [Contributor Covenant Code of Conduct](https://www.contributor-covenant.org/version/2/1/code_of_conduct/). By participating, you are expected to uphold this code. Please report unacceptable behavior via GitHub Issues.

## 🚀 Getting Started

1. **Fork the repository** and clone your fork locally
2. **Install dependencies**: `npm install`
3. **Create a branch** following our naming conventions (see below)
4. **Make your changes** following our coding standards
5. **Test your changes** thoroughly
6. **Submit a pull request** to the `develop` branch

### Prerequisites

- Node.js v24.12.0 (use `.nvmrc` or `.node-version` file)
- npm (our official package manager)
- Git

## 🔄 Development Workflow

```bash
# 1. Clone your fork
git clone https://github.com/YOUR-USERNAME/node-ts.git
cd node-ts

# 2. Install dependencies
npm install

# 3. Create a feature branch
git checkout -b feat/your-feature-name

# 4. Make your changes and test
npm run dev
npm test
npm run lint

# 5. Commit following conventional commits
git add .
git commit -m "feat: add new feature"

# 6. Push to your fork
git push origin feat/your-feature-name

# 7. Open a Pull Request to the develop branch
```

## 🌿 Branch Strategy

We follow a **Git Flow** inspired branching model:

### Main Branches

- **`main`** - Production/deployment branch
  - Always stable and deployable
  - Only accepts merges from `develop`
  - Protected branch - no direct commits

- **`develop`** - Development and integration branch
  - Latest development changes
  - Feature branches merge here
  - Protected branch - requires PR

### Feature Branches

All feature branches **must** follow conventional commit prefixes:

| Prefix      | Purpose                  | Example                     |
| ----------- | ------------------------ | --------------------------- |
| `feat/`     | New features             | `feat/add-authentication`   |
| `fix/`      | Bug fixes                | `fix/resolve-memory-leak`   |
| `docs/`     | Documentation            | `docs/update-readme`        |
| `refactor/` | Code refactoring         | `refactor/simplify-config`  |
| `test/`     | Test additions/updates   | `test/add-unit-tests`       |
| `chore/`    | Maintenance tasks        | `chore/update-dependencies` |
| `perf/`     | Performance improvements | `perf/optimize-build`       |
| `style/`    | Code style changes       | `style/format-code`         |
| `ci/`       | CI/CD changes            | `ci/add-workflow`           |

### Branch Naming Rules

- Use lowercase
- Use hyphens to separate words
- Be descriptive but concise
- Include issue number if applicable

**Examples:**

- ✅ `feat/user-authentication`
- ✅ `fix/login-error-123`
- ✅ `docs/api-documentation`
- ❌ `myFeature`
- ❌ `fix_bug`
- ❌ `FEAT/NewThing`

## 📝 Commit Standards

We strictly enforce **Conventional Commits** for all commit messages.

### Commit Message Format

```
<type>[optional scope]: <description>

[optional body]

[optional footer(s)]
```

### Commit Types

- **feat**: New feature
- **fix**: Bug fix
- **docs**: Documentation changes
- **refactor**: Code refactoring (no feature change)
- **test**: Adding or updating tests
- **chore**: Maintenance tasks
- **perf**: Performance improvements
- **style**: Code style/formatting
- **ci**: CI/CD changes
- **build**: Build system changes
- **revert**: Revert previous commit

### Examples

```bash
# Simple feature
git commit -m "feat: add user authentication"

# Bug fix with scope
git commit -m "fix(api): resolve null pointer exception"

# Breaking change
git commit -m "feat!: change API response structure

BREAKING CHANGE: API now returns data in a different format"

# With issue reference
git commit -m "fix: resolve login timeout issue

Fixes #123"
```

### Commit Message Rules

- ✅ Use present tense ("add feature" not "added feature")
- ✅ Use imperative mood ("move cursor to..." not "moves cursor to...")
- ✅ Don't capitalize first letter after colon
- ✅ No period at the end of the subject line
- ✅ Separate subject from body with a blank line
- ✅ Wrap body at 72 characters
- ✅ Use body to explain what and why, not how

## 🔀 Pull Request Process

### Before Submitting

1. **Run all validation checks**: `npm run validate`
   - This runs lint, format check, typecheck, and build
2. **Ensure all tests pass**: `npm run test:coverage`
3. **Update documentation** if needed
4. **Add/update tests** for your changes (100% coverage required)
5. **Rebase on latest develop**: `git rebase develop`

### PR Requirements

- **Target branch**: Always create PRs to `develop`, never to `main`
- **Title**: Follow conventional commit format (e.g., "feat: add new feature")
- **Description**: Clearly explain what and why
- **Tests**: All CI checks must pass (build, lint, tests)
- **Reviews**: Requires 1 approval from @Barthmossr
- **Merge**: Manual merge only (no auto-merge)

### PR Template

When creating a PR, include:

```markdown
## Description

Brief description of changes

## Type of Change

- [ ] Bug fix (non-breaking change which fixes an issue)
- [ ] New feature (non-breaking change which adds functionality)
- [ ] Breaking change (fix or feature that would cause existing functionality to not work as expected)
- [ ] Documentation update

## Related Issue(s)

Fixes #(issue number)

## Checklist

- [ ] Code follows project style guidelines (no semicolons, single quotes)
- [ ] No TypeScript errors (`npm run typecheck`)
- [ ] No ESLint warnings (`npm run lint`)
- [ ] Code is formatted (`npm run format:check`)
- [ ] Tests added/updated with 100% coverage
- [ ] All CI checks pass (`npm run validate`)
- [ ] Documentation updated if needed
```

### PR Review Process

1. Submit PR to `develop` branch
2. Automated CI/CD runs (build, lint, test)
3. Code review by @Barthmossr
4. Address review feedback if needed
5. Manual merge after approval and all checks pass

## 🧪 Testing Requirements

All contributions must include appropriate tests:

### Test Structure

Tests mirror the `src/` structure in the `tests/` directory:

```
tests/
├── setup.ts          # Global test setup
└── app/
    └── main.test.ts  # Tests for src/app/main.ts
```

### Writing Tests

```typescript
// tests/app/example.test.ts
import { myFunction } from '@/app/example'

describe('myFunction', () => {
  it('should do something', () => {
    const result = myFunction()
    expect(result).toBeDefined()
  })
})
```

**Best Practices**:

- Use `it('should...')` format for test names
- Use path alias `@/*` for imports
- Test one thing per test
- Keep tests independent

### Running Tests

```bash
# Run all tests
npm test

# Run with coverage
npm run test:coverage

# Watch mode during development
npm run test:watch
```

### Coverage Requirements

- **100% coverage is required** for branches, functions, lines, and statements
- Coverage reports are generated in multiple formats (text, lcov, html, json-summary)
- CI will fail if coverage drops below 100%

## 👀 Code Review

### What We Look For

- **Functionality**: Does it work as intended?
- **Tests**: Are there adequate tests?
- **Code Quality**: Is it readable and maintainable?
- **Documentation**: Is it properly documented?
- **Standards**: Does it follow our conventions?
- **Performance**: Are there any performance concerns?
- **Security**: Are there any security issues?

### Review Timeline

- Initial review within 48 hours
- Follow-up reviews within 24 hours
- Urgent fixes reviewed ASAP

## 🐛 Bug Reports

When reporting bugs via GitHub Issues:

1. **Use a clear title** describing the issue
2. **Provide steps to reproduce** the bug
3. **Include expected vs actual behavior**
4. **Add system information** (OS, Node version, etc.)
5. **Include relevant logs or screenshots**
6. **Suggest a fix** if possible

## 💡 Feature Requests

When requesting features via GitHub Issues:

1. **Describe the problem** you're trying to solve
2. **Explain your proposed solution**
3. **Provide use cases** and examples
4. **Consider alternatives** you've thought about

## 📚 Documentation

- Update README.md for user-facing changes
- Add/update docs in `docs/guides/` for detailed information
- **Do not add code comments** - code should be self-documenting
- All documentation goes in the `docs/` folder only

## ❓ Questions?

If you have questions:

1. Check existing [documentation](docs/)
2. Search [existing issues](https://github.com/Barthmossr/node-ts/issues)
3. Open a new issue with the `question` label

## 🙏 Thank You!

Your contributions make this project better. We appreciate your time and effort!

---

**Happy Coding! 🚀**

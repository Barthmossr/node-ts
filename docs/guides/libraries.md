# Library Decisions

This document explains why each library was chosen, what it does, and how it's configured in this template.

## 📋 Table of Contents

- [Core Technologies](#core-technologies)
- [Code Quality \& Formatting](#code-quality--formatting)
- [Git Hooks \& Commit Standards](#git-hooks--commit-standards)
- [Testing](#testing)
- [Build \& Development](#build--development)
- [CI/CD](#cicd)
- [Future Considerations](#future-considerations)

## 🎯 Core Technologies

### Node.js v24.11.1

**What**: JavaScript runtime built on Chrome's V8 engine

**Why**:

- Latest LTS (Long Term Support) version
- Best performance and security updates
- Modern JavaScript features
- Wide ecosystem support

**Alternatives Considered**:

- **Deno**: Too new, smaller ecosystem
- **Bun**: Exciting but not mature enough (future consideration)
- **Older Node versions**: Missing modern features

### TypeScript ^5.9.3

**What**: Typed superset of JavaScript

**Why**:

- **Type Safety**: Catch errors at compile time
- **Developer Experience**: Excellent IDE support
- **Refactoring**: Safer and easier
- **Documentation**: Types serve as inline docs
- **Industry Standard**: Expected in modern projects

**Configuration**:

```json
{
  "compilerOptions": {
    "target": "ES2022",
    "module": "ESNext",
    "moduleResolution": "bundler",
    "outDir": "./dist",
    "strict": true,
    "verbatimModuleSyntax": true
  }
}
```

**Key Settings**:

- **ES2022 target**: Modern JavaScript with good Node.js support
- **ESNext module**: ES modules for modern Node.js
- **bundler moduleResolution**: Modern resolution strategy
- **verbatimModuleSyntax**: Explicit import/export type annotations

**Alternatives Considered**:

- **Plain JavaScript**: Lacks type safety
- **Flow**: Less popular, smaller ecosystem
- **ReScript**: Too different from JavaScript

### npm

**What**: Package manager for Node.js

**Why**:

- **Default**: Ships with Node.js
- **Mature**: Battle-tested and stable
- **Compatible**: Works everywhere
- **Features**: Workspaces, package-lock security
- **Ecosystem**: Largest package registry

**Future Consideration**: May migrate to **Bun** when mature for performance

**Alternatives Considered**:

- **yarn**: Similar features, one more tool to install
- **pnpm**: Faster but less common
- **Bun**: Very fast but still maturing

## 🎨 Code Quality & Formatting

### ESLint ^9.39.1

**What**: Pluggable linting utility for JavaScript and TypeScript

**Why**:

- **Code Quality**: Catch bugs and bad patterns
- **Consistency**: Enforce coding standards
- **Customizable**: Extensive plugin ecosystem
- **TypeScript Support**: First-class TypeScript support
- **IDE Integration**: Real-time feedback

**Key Plugins**:

- `typescript-eslint`: TypeScript rules and parser
- `eslint-plugin-prettier`: Run Prettier as ESLint rule
- `eslint-config-prettier`: Disable conflicting formatting rules
- `globals`: Node.js global definitions

**Configuration** (Flat Config in `eslint.config.ts`):

```typescript
import js from '@eslint/js'
import globals from 'globals'
import tseslint from 'typescript-eslint'
import { defineConfig } from 'eslint/config'
import eslintPluginPrettier from 'eslint-plugin-prettier'
import eslintConfigPrettier from 'eslint-config-prettier'

export default defineConfig([
  {
    ignores: ['dist/**'],
  },
  {
    files: ['**/*.{js,mjs,cjs,ts,mts,cts}'],
    plugins: { js, prettier: eslintPluginPrettier },
    extends: ['js/recommended'],
    languageOptions: { globals: globals.node },
    rules: {
      ...eslintConfigPrettier.rules,
      'prettier/prettier': 'error',
      semi: ['error', 'never'],
      quotes: ['error', 'single', { avoidEscape: true }],
      'no-console': 'warn',
    },
  },
  {
    files: ['**/*.{ts,mts,cts}'],
    extends: [tseslint.configs.recommended],
    rules: {
      '@typescript-eslint/no-explicit-any': 'error',
      '@typescript-eslint/explicit-function-return-type': 'error',
    },
  },
])
```

**Key Rules**:

- **semi: never**: No semicolons (project style)
- **quotes: single**: Single quotes only
- **no-console: warn**: Warns on console usage
- **no-explicit-any: error**: Never use `any` type
- **explicit-function-return-type: error**: Always specify return types

**Required Package**: `jiti` is needed to run TypeScript ESLint config files.

**Alternatives Considered**:

- **TSLint**: Deprecated in favor of ESLint
- **Standard**: Less customizable
- **Biome**: Too new, smaller ecosystem

### Prettier ^3.7.3

**What**: Opinionated code formatter

**Why**:

- **Consistency**: Everyone's code looks the same
- **No Debates**: Removes formatting discussions
- **Automatic**: Format on save
- **Multi-Language**: JavaScript, TypeScript, JSON, Markdown, etc.
- **IDE Integration**: Works with all major editors

**Configuration** (`.prettierrc`):

```json
{
  "semi": false,
  "singleQuote": true,
  "trailingComma": "all",
  "tabWidth": 2,
  "printWidth": 80,
  "arrowParens": "always",
  "endOfLine": "lf"
}
```

**Why These Settings**:

- **semi: false**: No semicolons (matches ESLint rule)
- **singleQuote: true**: Single quotes (matches ESLint rule)
- **trailingComma: all**: Add trailing commas everywhere
- **printWidth: 80**: Max line length 80 characters
- **endOfLine: lf**: Unix-style line endings

**Alternatives Considered**:

- **Manual formatting**: Inconsistent and wastes time
- **EditorConfig only**: Not enough control
- **Biome**: Promising but less mature

### EditorConfig

**What**: Maintains consistent coding styles between different editors

**Why**:

- **Cross-Editor**: Works across all IDEs
- **Basic Standards**: Character encoding, line endings
- **Complementary**: Works alongside Prettier
- **Simple**: Minimal configuration

**Configuration** (`.editorconfig`):

```ini
root = true

[*]
charset = utf-8
end_of_line = lf
insert_final_newline = true
trim_trailing_whitespace = true

[*.md]
trim_trailing_whitespace = false
```

**What We DON'T Configure**:

- Indentation (handled by Prettier)
- Quote style (handled by Prettier)
- Max line length (handled by Prettier)

## 🔧 Git Hooks & Commit Standards

### Husky ^9.1.7

**What**: Git hooks made easy

**Why**:

- **Automation**: Run checks before commits/pushes
- **Quality Gates**: Prevent bad code from being committed
- **Team Standards**: Enforce standards automatically
- **Easy Setup**: Simple configuration
- **Cross-Platform**: Works on all operating systems

**Hooks We Use**:

- **pre-commit**: Run lint-staged
- **commit-msg**: Run commitlint
- **pre-push**: Run tests

**Setup**: Runs automatically via `prepare` script after `npm install`.

**Alternatives Considered**:

- **Manual git hooks**: Hard to share with team
- **pre-commit (Python tool)**: Extra dependency
- **lefthook**: Less popular

### lint-staged ^16.2.7

**What**: Run linters on staged git files

**Why**:

- **Performance**: Only lint changed files
- **Speed**: Fast pre-commit checks
- **Focus**: Doesn't lint entire codebase
- **Flexible**: Run any command on staged files

**Configuration** (`.lintstagedrc`):

```json
{
  "*.{js,ts}": ["eslint --fix", "prettier --write"]
}
```

**Alternatives Considered**:

- **Lint all files**: Too slow
- **Manual checking**: Easy to forget
- **Git hooks without lint-staged**: Reinventing the wheel

### commitlint ^20.1.0

**What**: Lint commit messages

**Why**:

- **Standards**: Enforce conventional commits
- **Automation**: Enable semantic versioning
- **Clarity**: Clear commit history
- **Tooling**: Works with changelog generators

**Configuration** (`commitlint.config.js`):

```javascript
export default { extends: ['@commitlint/config-conventional'] }
```

**Alternatives Considered**:

- **Manual review**: Not scalable
- **Custom scripts**: Maintaining our own solution
- **No enforcement**: Leads to messy history

## 🧪 Testing

### Jest ^30.2.0

**What**: Delightful JavaScript testing framework

**Why**:

- **All-in-One**: Test runner, assertions, mocking
- **TypeScript Support**: Works great with ts-jest
- **Fast**: Runs tests in parallel
- **Snapshot Testing**: Easy to test complex outputs
- **Coverage**: Built-in code coverage
- **Community**: Huge ecosystem and support

**Configuration** (`jest.config.ts`):

```typescript
import type { Config } from 'jest'

const config: Config = {
  preset: 'ts-jest',
  testEnvironment: 'node',
  roots: ['<rootDir>/tests'],
  testMatch: ['**/*.test.ts', '**/*.spec.ts'],
  moduleNameMapper: {
    '^@/(.*)$': '<rootDir>/src/$1',
  },
  setupFilesAfterEnv: ['<rootDir>/tests/setup.ts'],
  collectCoverageFrom: [
    'src/**/*.ts',
    '!src/**/*.types.ts',
    '!src/**/index.ts',
  ],
  coverageDirectory: 'coverage',
  coverageReporters: ['text', 'lcov', 'html', 'json-summary'],
  coverageThreshold: {
    global: {
      branches: 100,
      functions: 100,
      lines: 100,
      statements: 100,
    },
  },
  verbose: true,
  clearMocks: true,
  resetMocks: true,
  restoreMocks: true,
}

export default config
```

**Key Settings**:

- **preset: ts-jest**: TypeScript support
- **moduleNameMapper**: Support for `@/*` path alias
- **coverageThreshold: 100%**: Full coverage required
- **coverageReporters**: Multiple formats including json-summary for badges

**Alternatives Considered**:

- **Mocha + Chai + Sinon**: Multiple packages to maintain
- **Vitest**: Great but newer, smaller ecosystem
- **AVA**: Less popular, minimal advantages
- **Node Test Runner**: Too basic

### ts-jest ^29.4.5

**What**: TypeScript preprocessor for Jest

**Why**:

- **TypeScript Support**: Run .ts files directly in Jest
- **Type Checking**: Optionally check types during tests
- **Source Maps**: Accurate error locations
- **Fast**: Incremental compilation

**Alternatives Considered**:

- **Compile first**: Slower, extra step
- **babel-jest**: Less accurate type checking
- **swc-jest**: Faster but less mature

### @types/jest ^30.x.x

**What**: TypeScript definitions for Jest

**Why**:

- **IntelliSense**: Autocomplete for Jest APIs
- **Type Safety**: Catch errors in test code
- **Documentation**: Inline docs for Jest functions

## 🛠️ Build & Development

### tsx ^4.20.6

**What**: TypeScript Execute - run TypeScript files directly

**Why**:

- **Development**: Hot reload during development
- **Fast**: Uses esbuild for speed
- **Simple**: No configuration needed
- **Watch Mode**: Automatic reload on file changes

**Usage**:

```bash
# Single run
npm run dev     # tsx src/app/main.ts

# Watch mode
npm run dev:watch  # tsx watch src/app/main.ts
```

**Alternatives Considered**:

- **ts-node**: Slower, more configuration
- **nodemon + ts-node**: Two packages instead of one
- **tsc + node**: Slow compile step

### rimraf ^6.1.2

**What**: Cross-platform `rm -rf`

**Why**:

- **Cross-Platform**: Works on Windows, Mac, Linux
- **Reliable**: Safely delete directories
- **Simple**: One command to clean build folders

**Usage**: `npm run clean` removes `dist/` and `coverage/`

**Alternatives Considered**:

- **fs.rm**: Node.js built-in but needs scripting
- **del-cli**: Similar but less popular
- **Manual scripts**: Platform-specific issues

### npm-check-updates ^19.1.2

**What**: Upgrade package.json dependencies to latest versions

**Why**:

- **Discovery**: Find outdated packages
- **Interactive**: Choose what to update
- **Safe**: Review changes before applying
- **Comprehensive**: Check all dependencies at once

**Usage**: `npm run check` opens interactive upgrade UI

**Alternatives Considered**:

- **npm outdated**: Less interactive
- **npm update**: Only updates within semver range
- **Manual checking**: Time consuming

## 🚀 CI/CD

### GitHub Actions

**What**: CI/CD platform built into GitHub

**Why**:

- **Integrated**: No external service needed
- **Free**: Generous free tier for public/private repos
- **Powerful**: Can do anything Linux can do
- **Marketplace**: Thousands of pre-built actions
- **Matrix Builds**: Test on multiple Node versions/OS

**Workflows**:

1. **validate.yml**: Lint, format, typecheck, build
2. **test.yml**: Run tests with coverage, upload to Codecov

**Alternatives Considered**:

- **Jenkins**: Too complex to set up
- **Travis CI**: Pricing changes, less popular
- **CircleCI**: Extra service to manage
- **GitLab CI**: Would require moving from GitHub

## 🔮 Future Considerations

### Bun

**Status**: Watching closely, will consider migrating when mature

**Why We're Interested**:

- **Speed**: Significantly faster than npm
- **All-in-One**: Package manager, bundler, runtime
- **Native TypeScript**: No transpilation needed
- **Performance**: Fast startup times

**Why Not Now**:

- Still in rapid development
- Smaller ecosystem
- Some compatibility issues
- Need more production validation

### Biome

**Status**: Monitoring as potential ESLint + Prettier replacement

**Why We're Interested**:

- **Fast**: Written in Rust
- **All-in-One**: Linting + formatting
- **Compatible**: Drop-in replacement

**Why Not Now**:

- Newer tool, smaller community
- Less plugins and extensions
- ESLint + Prettier work great

## 📊 Decision Matrix

When evaluating libraries, we consider:

| Criterion          | Weight | Description                    |
| ------------------ | ------ | ------------------------------ |
| **Maturity**       | High   | Battle-tested in production    |
| **Community**      | High   | Active development and support |
| **Performance**    | Medium | Fast enough for good DX        |
| **DX**             | High   | Great developer experience     |
| **Compatibility**  | High   | Works with our stack           |
| **Maintenance**    | Medium | Actively maintained            |
| **Learning Curve** | Medium | Easy to learn                  |
| **Cost**           | Low    | Free tier available            |

## 🎓 Learning Resources

- [TypeScript](https://www.typescriptlang.org/docs/)
- [ESLint](https://eslint.org/docs/latest/)
- [Prettier](https://prettier.io/docs/en/)
- [Jest](https://jestjs.io/docs/getting-started)
- [Husky](https://typicode.github.io/husky/)
- [Conventional Commits](https://www.conventionalcommits.org/)

---

**Next**: Check out the [Configuration Guide](configuration.md) to understand how these libraries are configured.

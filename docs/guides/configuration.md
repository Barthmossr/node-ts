# Configuration Guide

Comprehensive guide to all configuration files in this template.

## 📋 Table of Contents

- [package.json](#packagejson)
- [TypeScript Configuration](#typescript-configuration)
- [ESLint Configuration](#eslint-configuration)
- [Prettier Configuration](#prettier-configuration)
- [Jest Configuration](#jest-configuration)
- [Git Configuration](#git-configuration)
- [Editor Configuration](#editor-configuration)
- [Node Version](#node-version)
- [Environment Variables](#environment-variables)

## 📦 package.json

The heart of your Node.js project.

### Basic Metadata

```json
{
  "name": "node-ts",
  "version": "1.0.0",
  "description": "A production-ready Node.js TypeScript template",
  "main": "dist/app/main.js",
  "author": "Barthmossr",
  "license": "MIT",
  "private": false,
  "repository": {
    "type": "git",
    "url": "https://github.com/Barthmossr/node-ts.git"
  },
  "keywords": ["nodejs", "typescript", "template", "boilerplate"]
}
```

**Fields Explained**:

- **name**: Package name (kebab-case recommended)
- **version**: Semantic version (major.minor.patch)
- **description**: Brief description of the project
- **main**: Entry point for the built application
- **author**: Your name or organization
- **license**: License type (MIT in our case)
- **private**: Set to `true` to prevent accidental publishing
- **repository**: Git repository URL
- **keywords**: Help others find your package

### Scripts

```json
{
  "scripts": {
    "dev": "tsx watch src/app/main.ts",
    "build": "tsc",
    "start": "node dist/app/main.js",
    "test": "jest",
    "test:unit": "jest tests/unit",
    "test:integration": "jest tests/integration",
    "test:e2e": "jest tests/e2e",
    "test:watch": "jest --watch",
    "test:coverage": "jest --coverage",
    "lint": "eslint . --ext .ts",
    "lint:fix": "eslint . --ext .ts --fix",
    "format": "prettier --write \"**/*.{ts,js,json,md}\"",
    "format:check": "prettier --check \"**/*.{ts,js,json,md}\"",
    "type-check": "tsc --noEmit",
    "clean": "rimraf dist coverage",
    "validate": "npm run lint && npm run format:check && npm run type-check && npm test",
    "prepare": "husky install"
  }
}
```

**Scripts Explained**:

- **dev**: Development mode with hot reload
- **build**: Compile TypeScript to JavaScript
- **start**: Run the built application
- **test**: Run all tests
- **test:unit/integration/e2e**: Run specific test types
- **test:watch**: Run tests in watch mode
- **test:coverage**: Generate coverage report
- **lint**: Check code with ESLint
- **lint:fix**: Auto-fix linting issues
- **format**: Format code with Prettier
- **format:check**: Check if code is formatted
- **type-check**: Check TypeScript types without building
- **clean**: Remove build artifacts
- **validate**: Run all checks (CI uses this)
- **prepare**: Set up Husky hooks (runs after npm install)

### Dependencies vs DevDependencies

```json
{
  "dependencies": {
    // Runtime dependencies - needed in production
  },
  "devDependencies": {
    // Development dependencies - only needed during development
    "@types/jest": "^29.x.x",
    "@types/node": "^24.x.x",
    "@typescript-eslint/eslint-plugin": "^6.x.x",
    "@typescript-eslint/parser": "^6.x.x",
    "eslint": "^8.x.x",
    "eslint-config-prettier": "^9.x.x",
    "husky": "^8.x.x",
    "jest": "^29.x.x",
    "lint-staged": "^15.x.x",
    "prettier": "^3.x.x",
    "rimraf": "^5.x.x",
    "ts-jest": "^29.x.x",
    "tsx": "^4.x.x",
    "typescript": "^5.x.x"
  }
}
```

**Important**: Since this is a template with no application logic yet, all dependencies are dev dependencies. When you add your application code, runtime dependencies will go in `dependencies`.

## 📘 TypeScript Configuration

### tsconfig.json

Main TypeScript configuration:

```json
{
  "compilerOptions": {
    // Language and Environment
    "target": "ES2022", // Target JavaScript version
    "lib": ["ES2022"], // Include standard library features
    "module": "commonjs", // Module system (CommonJS for Node.js)

    // Emit
    "outDir": "./dist", // Output directory for compiled files
    "rootDir": "./src", // Root directory of source files
    "sourceMap": true, // Generate .map files for debugging
    "declaration": true, // Generate .d.ts declaration files
    "declarationMap": true, // Generate .d.ts.map files
    "removeComments": true, // Remove comments in output

    // Modules
    "moduleResolution": "node", // Module resolution strategy
    "esModuleInterop": true, // Enable CommonJS/ES module interop
    "allowSyntheticDefaultImports": true, // Allow default imports from modules
    "resolveJsonModule": true, // Allow importing .json files

    // Type Checking
    "strict": true, // Enable all strict type-checking options
    "noImplicitAny": true, // Error on expressions with implied 'any'
    "strictNullChecks": true, // Strict null checking
    "strictFunctionTypes": true, // Strict function types
    "strictBindCallApply": true, // Strict bind/call/apply
    "strictPropertyInitialization": true, // Strict property initialization
    "noImplicitThis": true, // Error on 'this' with implied 'any'
    "alwaysStrict": true, // Parse in strict mode

    // Additional Checks
    "noUnusedLocals": true, // Error on unused local variables
    "noUnusedParameters": true, // Error on unused parameters
    "noImplicitReturns": true, // Error on missing return statements
    "noFallthroughCasesInSwitch": true, // Error on fallthrough cases in switch

    // Interop Constraints
    "forceConsistentCasingInFileNames": true, // Ensure consistent file name casing
    "skipLibCheck": true // Skip type checking of declaration files
  },
  "include": ["src/**/*"], // Files to include
  "exclude": ["node_modules", "dist", "tests"] // Files to exclude
}
```

**Why These Settings**:

- **target: ES2022**: Modern JavaScript with good Node.js support
- **strict: true**: Catch more errors at compile time
- **sourceMap: true**: Debug TypeScript in production
- **declaration: true**: Generate types for library consumers
- **noUnusedLocals/Parameters**: Prevent dead code
- **skipLibCheck**: Faster compilation

### tsconfig.build.json (Optional)

For production builds with stricter settings:

```json
{
  "extends": "./tsconfig.json",
  "compilerOptions": {
    "sourceMap": false, // No source maps in production
    "declaration": false, // No declaration files needed
    "removeComments": true // Remove all comments
  },
  "exclude": ["node_modules", "dist", "tests", "**/*.test.ts"]
}
```

**Usage**: `tsc --project tsconfig.build.json`

## 🎨 ESLint Configuration

### .eslintrc.json

```json
{
  "root": true,
  "parser": "@typescript-eslint/parser",
  "parserOptions": {
    "ecmaVersion": 2022,
    "sourceType": "module",
    "project": "./tsconfig.json"
  },
  "env": {
    "node": true,
    "es2022": true,
    "jest": true
  },
  "extends": [
    "eslint:recommended",
    "plugin:@typescript-eslint/recommended",
    "plugin:@typescript-eslint/recommended-requiring-type-checking",
    "prettier"
  ],
  "plugins": ["@typescript-eslint"],
  "rules": {
    // TypeScript
    "@typescript-eslint/no-unused-vars": [
      "error",
      { "argsIgnorePattern": "^_" }
    ],
    "@typescript-eslint/explicit-function-return-type": "warn",
    "@typescript-eslint/no-explicit-any": "error",
    "@typescript-eslint/no-non-null-assertion": "warn",

    // General
    "no-console": ["warn", { "allow": ["warn", "error"] }],
    "no-debugger": "error",
    "prefer-const": "error",
    "no-var": "error"
  },
  "ignorePatterns": ["dist", "coverage", "node_modules"]
}
```

**Key Rules Explained**:

- **no-unused-vars**: Prevent unused variables (allow `_` prefix for intentionally unused)
- **explicit-function-return-type**: Enforce explicit return types (warn level)
- **no-explicit-any**: Prevent use of `any` type
- **no-console**: Warn on console.log (allow warn/error)
- **prefer-const**: Use const when variable isn't reassigned

### .eslintignore

```
node_modules
dist
coverage
*.config.js
```

## 💅 Prettier Configuration

### .prettierrc.json

```json
{
  "semi": true,
  "trailingComma": "es5",
  "singleQuote": true,
  "printWidth": 100,
  "tabWidth": 2,
  "useTabs": false,
  "arrowParens": "always",
  "endOfLine": "lf"
}
```

**Settings Explained**:

- **semi**: Add semicolons (safer, prevents ASI issues)
- **trailingComma**: Add trailing commas in ES5 (objects, arrays)
- **singleQuote**: Use single quotes (community standard)
- **printWidth**: Max line length 100 characters
- **tabWidth**: 2 spaces for indentation
- **useTabs**: Use spaces, not tabs
- **arrowParens**: Always use parentheses in arrow functions
- **endOfLine**: Use LF line endings (Unix-style)

### .prettierignore

```
node_modules
dist
coverage
package-lock.json
*.md
```

**Note**: We actually format `.md` files, so remove `*.md` if you want markdown formatting.

## 🧪 Jest Configuration

### jest.config.js

```javascript
module.exports = {
  // Use ts-jest preset
  preset: "ts-jest",

  // Test environment
  testEnvironment: "node",

  // Root directories for tests
  roots: ["<rootDir>/tests"],

  // Test file patterns
  testMatch: ["**/*.test.ts", "**/*.spec.ts"],

  // Module paths
  moduleFileExtensions: ["ts", "tsx", "js", "jsx", "json"],

  // Coverage
  collectCoverageFrom: [
    "src/**/*.ts",
    "!src/**/*.d.ts",
    "!src/**/*.interface.ts",
    "!src/**/*.type.ts",
  ],

  coverageDirectory: "coverage",

  coverageThresholds: {
    global: {
      branches: 80,
      functions: 80,
      lines: 80,
      statements: 80,
    },
  },

  // Transform
  transform: {
    "^.+\\.ts$": "ts-jest",
  },

  // Setup files
  setupFilesAfterEnv: ["<rootDir>/tests/setup.ts"],

  // Clear mocks between tests
  clearMocks: true,
  resetMocks: true,
  restoreMocks: true,
}
```

**Settings Explained**:

- **preset**: Use ts-jest for TypeScript support
- **testEnvironment**: Node.js environment (not browser)
- **testMatch**: Pattern for test files
- **collectCoverageFrom**: What to include in coverage
- **coverageThresholds**: Minimum coverage requirements
- **clearMocks**: Reset mocks between tests

### Separate Configs (Optional)

You can create separate configs for each test type:

**jest.unit.config.js**:

```javascript
module.exports = {
  ...require("./jest.config"),
  testMatch: ["**/tests/unit/**/*.test.ts"],
}
```

**Usage**: `jest --config jest.unit.config.js`

## 🔧 Git Configuration

### .gitignore

```
# Dependencies
node_modules/

# Build output
dist/
build/
*.tsbuildinfo

# Testing
coverage/
.nyc_output/

# Environment variables
.env
.env.local
.env.*.local

# Editor directories and files
.vscode/*
!.vscode/extensions.json
!.vscode/settings.json
.idea/
*.swp
*.swo
*~
.DS_Store

# Logs
logs/
*.log
npm-debug.log*
yarn-debug.log*
yarn-error.log*

# Runtime
pids/
*.pid
*.seed
*.pid.lock

# Misc
.cache/
.temp/
```

### .gitattributes

```
# Auto detect text files and perform LF normalization
* text=auto

# Force LF for source code
*.ts text eol=lf
*.js text eol=lf
*.json text eol=lf
*.md text eol=lf
*.yml text eol=lf
*.yaml text eol=lf

# Binary files
*.png binary
*.jpg binary
*.jpeg binary
*.gif binary
*.ico binary
*.pdf binary
```

**Why**: Ensures consistent line endings across different operating systems.

## 📝 Editor Configuration

### .editorconfig

```ini
# EditorConfig is awesome: https://EditorConfig.org

# Top-most EditorConfig file
root = true

# Unix-style newlines with a newline ending every file
[*]
charset = utf-8
end_of_line = lf
insert_final_newline = true
trim_trailing_whitespace = true

# Markdown files (preserve trailing spaces for line breaks)
[*.md]
trim_trailing_whitespace = false
```

**What We DON'T Set**:

- **indent_style**: Let Prettier handle it
- **indent_size**: Let Prettier handle it
- **max_line_length**: Let Prettier handle it

**Why**: EditorConfig handles basic text file settings, Prettier handles all formatting.

### .vscode/settings.json (Recommended)

```json
{
  "editor.defaultFormatter": "esbenp.prettier-vscode",
  "editor.formatOnSave": true,
  "editor.codeActionsOnSave": {
    "source.fixAll.eslint": true
  },
  "typescript.tsdk": "node_modules/typescript/lib",
  "typescript.enablePromptUseWorkspaceTsdk": true,
  "files.eol": "\n",
  "files.insertFinalNewline": true,
  "files.trimTrailingWhitespace": true
}
```

**Requires Extensions**:

- ESLint
- Prettier - Code formatter

### .vscode/extensions.json (Recommended)

```json
{
  "recommendations": [
    "dbaeumer.vscode-eslint",
    "esbenp.prettier-vscode",
    "editorconfig.editorconfig",
    "firsttris.vscode-jest-runner",
    "eamodio.gitlens"
  ]
}
```

## 📌 Node Version

### .nvmrc

```
24.11.1
```

**Usage with nvm**:

```bash
nvm use
```

### .node-version

```
24.11.1
```

**Usage**: Some tools automatically detect this file.

**Why Both**: Different tools support different files. Include both for maximum compatibility.

## 🌍 Environment Variables

### .env (Not in git)

```bash
# Node environment
NODE_ENV=development

# Application
APP_PORT=3000
APP_HOST=localhost

# Database (example)
DATABASE_URL=postgresql://localhost:5432/mydb

# API Keys (example)
API_KEY=your-api-key-here
```

**Important**: Never commit `.env` to git! It's in `.gitignore`.

### .env.example (In git)

```bash
# Node environment
NODE_ENV=development

# Application
APP_PORT=3000
APP_HOST=localhost

# Database (example)
DATABASE_URL=

# API Keys (example)
API_KEY=
```

**Purpose**: Shows what environment variables are needed without exposing secrets.

### Loading Environment Variables

```typescript
// src/app/config/env.ts
import dotenv from "dotenv"

// Load environment variables
dotenv.config()

export const config = {
  nodeEnv: process.env.NODE_ENV || "development",
  port: parseInt(process.env.APP_PORT || "3000", 10),
  host: process.env.APP_HOST || "localhost",
}
```

## 🔗 Related Guides

- [Development Guide](development.md) - Development workflow
- [Libraries](libraries.md) - Why we chose these tools
- [Project Overview](project-overview.md) - Understanding the project

---

**Questions?** Open an issue on [GitHub](https://github.com/Barthmossr/node-ts/issues).

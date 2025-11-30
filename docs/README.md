# Documentation

Welcome to the **Node ts** documentation! This directory contains comprehensive guides to help you understand, use, and contribute to this template.

## 📚 Documentation Structure

This documentation is organized into several guides, each focusing on a specific aspect of the template.

## 🗺️ Documentation Index

### Getting Started

Start here if you're new to this template:

1. **[Project Overview](guides/project-overview.md)** 📖
   - Understand the philosophy and goals of this template
   - Learn about architectural decisions
   - See why this template is designed the way it is
   - Future plans for specialized templates

### Development

Essential guides for day-to-day development:

2. **[Development Guide](guides/development.md)** 🛠️
   - Setup your development environment
   - Learn the development workflow
   - Run tests and build the project
   - Troubleshooting common issues

3. **[Configuration Guide](guides/configuration.md)** ⚙️
   - Detailed explanation of all configuration files
   - package.json, tsconfig.json, ESLint, Prettier, Jest
   - Environment variables and editor settings
   - Customize the template for your needs

### Tools & Libraries

Understanding the tools we use:

4. **[Libraries](guides/libraries.md)** 📦
   - Why each library was chosen
   - Alternatives we considered
   - Configuration explanations
   - Future considerations (Bun, Biome)

### Contributing

If you want to contribute:

5. **[Contributing Guidelines](./CONTRIBUTING.md)** 🤝
   - Branch strategy and workflow
   - Commit message standards
   - Pull request process
   - Code review guidelines

## 🎯 Quick Navigation

### By Role

**I'm a new developer using this template:**

1. Read [Project Overview](guides/project-overview.md)
2. Follow [Development Guide](guides/development.md)
3. Refer to [Configuration Guide](guides/configuration.md) as needed

**I'm contributing to this template:**

1. Read [Contributing Guidelines](CONTRIBUTING.md)
2. Understand [Project Overview](guides/project-overview.md)
3. Follow [Development Guide](guides/development.md)

**I'm customizing the template:**

1. Understand [Project Overview](guides/project-overview.md)
2. Review [Libraries](guides/libraries.md)
3. Modify [Configuration Guide](guides/configuration.md) settings

### By Topic

| Topic                       | Document                                       |
| --------------------------- | ---------------------------------------------- |
| **Why decisions were made** | [Project Overview](guides/project-overview.md) |
| **Setup and workflow**      | [Development Guide](guides/development.md)     |
| **Configuration files**     | [Configuration Guide](guides/configuration.md) |
| **Tool choices**            | [Libraries](guides/libraries.md)               |
| **Branch strategy**         | [Contributing Guidelines](CONTRIBUTING.md)     |
| **Commit standards**        | [Contributing Guidelines](CONTRIBUTING.md)     |
| **Testing strategy**        | [Development Guide](guides/development.md)     |
| **CI/CD pipelines**         | [Development Guide](guides/development.md)     |

## 📖 Reading Order

We recommend reading the documentation in this order:

```
1. Project Overview          (understand the "why")
   ↓
2. Development Guide          (learn the "how")
   ↓
3. Libraries                  (understand the tools)
   ↓
4. Configuration Guide        (customize settings)
   ↓
5. Contributing Guidelines    (contribute back)
```

## 🎓 Key Concepts

Before diving into the guides, familiarize yourself with these key concepts:

### Conventional Commits

All commits follow the [Conventional Commits](https://www.conventionalcommits.org/) standard.

**Example**: `feat: add user authentication`

**Learn more**: [Contributing Guidelines](CONTRIBUTING.md#commit-standards)

### Git Flow Branch Strategy

- `main` - Production/deployment branch
- `develop` - Development branch
- Feature branches - `feat/`, `fix/`, `docs/`, etc.

**Learn more**: [Contributing Guidelines](CONTRIBUTING.md#branch-strategy)

### Test Coverage

100% test coverage is required. Tests mirror the `src/` structure in `tests/`.

**Learn more**: [Development Guide](guides/development.md#testing-guide)

### Code Style

- No semicolons
- Single quotes
- No `any` type
- Explicit function return types

**Learn more**: [Configuration Guide](guides/configuration.md#eslint-configuration)

## 🔍 Finding What You Need

### Search by Question

**"How do I set up my development environment?"**
→ [Development Guide - Initial Setup](guides/development.md#initial-setup)

**"Why did we choose TypeScript?"**
→ [Libraries - TypeScript](guides/libraries.md#typescript-593)

**"What does tsconfig.json do?"**
→ [Configuration Guide - TypeScript Configuration](guides/configuration.md#typescript-configuration)

**"How do I write tests?"**
→ [Development Guide - Testing Guide](guides/development.md#testing-guide)

**"What are the branch naming rules?"**
→ [Contributing Guidelines - Branch Strategy](CONTRIBUTING.md#branch-strategy)

**"How do I configure ESLint?"**
→ [Configuration Guide - ESLint Configuration](guides/configuration.md#eslint-configuration)

**"What scripts are available?"**
→ [Development Guide - Project Scripts](guides/development.md#project-scripts)

## 🛠️ Common Tasks

Quick links to common tasks:

| Task                     | Guide                                          | Section                  |
| ------------------------ | ---------------------------------------------- | ------------------------ |
| Install and setup        | [Development Guide](guides/development.md)     | Initial Setup            |
| Run tests                | [Development Guide](guides/development.md)     | Testing Guide            |
| Build for production     | [Development Guide](guides/development.md)     | Building for Production  |
| Create a PR              | [Contributing Guidelines](CONTRIBUTING.md)     | Pull Request Process     |
| Add a new library        | [Libraries](guides/libraries.md)               | Decision Matrix          |
| Update TypeScript config | [Configuration Guide](guides/configuration.md) | TypeScript Configuration |
| Check dependencies       | [Development Guide](guides/development.md)     | Project Scripts          |

## 📝 Documentation Standards

Our documentation follows these principles:

1. **Clear and Concise** - Get to the point quickly
2. **Examples Included** - Show, don't just tell
3. **Why and How** - Explain reasoning, not just steps
4. **Up-to-Date** - Regularly updated with the codebase
5. **Accessible** - Easy to navigate and search

## 🤝 Contributing to Documentation

Found an error? Have a suggestion? Want to improve the docs?

1. Check [Contributing Guidelines](CONTRIBUTING.md)
2. Create a branch: `docs/improve-documentation`
3. Make your changes
4. Submit a PR to `develop` branch

**Documentation is code** - treat it with the same care!

## ❓ Getting Help

If you can't find what you need in the documentation:

1. **Search the docs** - Use your browser's search (Ctrl/Cmd + F)
2. **Check existing issues** - Someone might have asked already
3. **Open an issue** - Use the `question` or `documentation` label
4. **Improve the docs** - Submit a PR with what you learned

## 📚 External Resources

Additional learning resources:

- [Node.js Documentation](https://nodejs.org/docs/latest/api/)
- [TypeScript Handbook](https://www.typescriptlang.org/docs/handbook/intro.html)
- [Jest Documentation](https://jestjs.io/docs/getting-started)
- [ESLint Documentation](https://eslint.org/docs/latest/)
- [ESLint Flat Config](https://eslint.org/docs/latest/use/configure/configuration-files-new)
- [Prettier Documentation](https://prettier.io/docs/en/)
- [Conventional Commits](https://www.conventionalcommits.org/)
- [Husky](https://typicode.github.io/husky/)

## 📞 Contact

- **Issues**: [GitHub Issues](https://github.com/Barthmossr/node-ts/issues)
- **Discussions**: [GitHub Discussions](https://github.com/Barthmossr/node-ts/discussions)
- **Maintainer**: [@Barthmossr](https://github.com/Barthmossr)

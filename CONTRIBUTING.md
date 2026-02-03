# Contributing to Arvion

First off, thank you for considering contributing to Arvion! 🎉

This document provides guidelines and steps for contributing. Following these guidelines helps communicate that you respect the time of the developers managing and developing this open source project.

## Table of Contents

- [Code of Conduct](#code-of-conduct)
- [How Can I Contribute?](#how-can-i-contribute)
  - [Reporting Bugs](#reporting-bugs)
  - [Suggesting Features](#suggesting-features)
  - [Pull Requests](#pull-requests)
- [Development Setup](#development-setup)
- [Style Guidelines](#style-guidelines)
- [Commit Messages](#commit-messages)

---

## Code of Conduct

This project and everyone participating in it is governed by our [Code of Conduct](CODE_OF_CONDUCT.md). By participating, you are expected to uphold this code.

---

## How Can I Contribute?

### Reporting Bugs

Before creating bug reports, please check existing issues to avoid duplicates. When you create a bug report, include as many details as possible:

**Bug Report Template:**

```markdown
**Describe the bug**
A clear description of what the bug is.

**To Reproduce**
Steps to reproduce the behavior:
1. Go to '...'
2. Click on '...'
3. See error

**Expected behavior**
What you expected to happen.

**Screenshots**
If applicable, add screenshots.

**Environment:**
- OS: [e.g., Windows 11]
- Flutter version: [e.g., 3.16.0]
- Dart version: [e.g., 3.2.0]
```

### Suggesting Features

Feature suggestions are welcome! Please provide:

- **Clear description** of the feature
- **Use case** - why is this feature needed?
- **Possible implementation** - if you have ideas

### Pull Requests

1. **Fork** the repository
2. **Create** your feature branch:
   ```bash
   git checkout -b feature/your-feature-name
   ```
3. **Make** your changes
4. **Test** thoroughly
5. **Commit** with a descriptive message (see [Commit Messages](#commit-messages))
6. **Push** to your fork:
   ```bash
   git push origin feature/your-feature-name
   ```
7. **Open** a Pull Request

---

## Development Setup

### Prerequisites

- Flutter SDK 3.0+
- Dart SDK 3.0+
- Visual Studio 2022 with C++ workload (for Windows)
- Git

### Setup Steps

1. **Clone your fork:**
   ```bash
   git clone https://github.com/YOUR_USERNAME/arvion.git
   cd arvion
   ```

2. **Add upstream remote:**
   ```bash
   git remote add upstream https://github.com/ORIGINAL_OWNER/arvion.git
   ```

3. **Install dependencies:**
   ```bash
   flutter pub get
   ```

4. **Run the app:**
   ```bash
   flutter run -d windows
   ```

5. **Run tests:**
   ```bash
   flutter test
   ```

### Project Structure

```
lib/
├── core/           # Theme, constants, utilities
├── data/           # Models, database, repositories
├── features/       # Feature modules (dashboard, tasks, etc.)
├── providers/      # Riverpod state management
└── widgets/        # Shared UI components
```

---

## Style Guidelines

### Dart/Flutter

We follow the [Effective Dart](https://dart.dev/guides/language/effective-dart) style guide with these additions:

- **Line length:** 80 characters max
- **Formatting:** Run `dart format .` before committing
- **Analysis:** Run `flutter analyze` and fix all issues

### Code Organization

- Keep files focused and small (< 300 lines preferred)
- One widget/class per file
- Use descriptive names

### Example

```dart
// Good ✓
class TaskRepository {
  Future<List<Task>> getAllActive() async {
    return _tasks.filter().isArchivedEqualTo(false).findAll();
  }
}

// Bad ✗
class Repo {
  Future<List<Task>> get() async {
    return _t.filter().isArchivedEqualTo(false).findAll();
  }
}
```

---

## Commit Messages

We follow [Conventional Commits](https://www.conventionalcommits.org/):

```
<type>(<scope>): <description>

[optional body]

[optional footer]
```

### Types

| Type | Description |
|------|-------------|
| `feat` | New feature |
| `fix` | Bug fix |
| `docs` | Documentation only |
| `style` | Formatting, no code change |
| `refactor` | Code change that neither fixes a bug nor adds a feature |
| `perf` | Performance improvement |
| `test` | Adding tests |
| `chore` | Build process or auxiliary tool changes |

### Examples

```bash
feat(heatmap): add multi-color support for task contributions

fix(dashboard): resolve pixel overflow on small windows

docs(readme): add installation instructions
```

---

## Questions?

Feel free to open an issue with the `question` label or reach out to the maintainers.

Thank you for contributing! 💚

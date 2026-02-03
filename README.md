# 🟩 Arvion

> A contribution graph for your life — Desktop-first productivity OS

[![Flutter](https://img.shields.io/badge/Flutter-3.10+-02569B?logo=flutter)](https://flutter.dev)
[![Desktop](https://img.shields.io/badge/Platform-Windows%20%7C%20macOS%20%7C%20Linux-brightgreen)](https://flutter.dev/multi-platform/desktop)

## Overview

Arvion transforms personal productivity into a developer-like experience. Your life tasks become **repositories**, your actions become **commits**, and your progress is visualized through a beautiful **contribution heatmap**.

### Design DNA

| Element | Value |
|---------|-------|
| 🟢 Primary | `#00D26A` (Growth Green) |
| 🔵 Secondary | `#0969DA` (GitHub Blue) |
| ⬛ Background | `#000000` (OLED Black) |
| Font | Inter + JetBrains Mono |

## Features

- **🗓️ Contribution Heatmap** — GitHub-style grid with compile-in animation
- **📋 Task Manager** — Track life goals as repositories
- **🎯 Protocols** — Set targets with weekly goals and deadlines  
- **📊 Dashboard** — Real-time stats and daily summaries
- **⌨️ Command Palette** — Quick actions with `Ctrl+K`
- **🌙 OLED Dark Mode** — Pure black for battery and eyes

## Getting Started

### Prerequisites

- Flutter 3.10+
- Windows/macOS/Linux with desktop support enabled

### Installation

```bash
# Clone the repository
git clone https://github.com/Anandb71/Arvion.git
cd Arvion

# Get dependencies
flutter pub get

# Generate Isar models
dart run build_runner build --delete-conflicting-outputs

# Run on desktop
flutter run -d windows  # or macos, linux
```

## Project Structure

```
lib/
├── app.dart                 # Main app shell
├── main.dart                # Entry point
├── core/
│   ├── theme/               # Colors, typography, theme
│   └── constants/           # App constants
├── data/
│   ├── models/              # Task, Commit, Protocol
│   ├── repositories/        # Data access layer
│   └── database/            # Isar configuration
├── providers/               # Riverpod state management
├── features/
│   ├── dashboard/           # Main dashboard + heatmap
│   ├── tasks/               # Task management
│   ├── protocols/           # Goal protocols
│   └── settings/            # App settings
└── widgets/                 # Shared UI components
```

## Tech Stack

- **Framework**: Flutter (Desktop + Web)
- **State**: Riverpod
- **Database**: Isar
- **Fonts**: Google Fonts (Inter, JetBrains Mono)

## Keyboard Shortcuts

| Shortcut | Action |
|----------|--------|
| `Ctrl+K` | Command Palette |
| `Ctrl+N` | New Task |
| `Ctrl+Enter` | Quick Commit |

## License

MIT License — see [LICENSE](LICENSE) for details

---

<p align="center">
  <sub>Built with 💚 for productivity enthusiasts</sub>
</p>

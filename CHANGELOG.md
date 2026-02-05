# Changelog

All notable changes to Arvion will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.0] - 2026-02-05

### Added
- **Dashboard** with GitHub-style contribution heatmap
- **Task Management**: Create, edit, delete tasks with color coding
- **Quick Commit**: Log progress with intensity levels (1-5)
- **Per-Task Graphs**: Individual heatmaps for each task
- **AI Assistant**: Gemini-powered with full CRUD capabilities
- **Screen Time Tracking**: Auto-monitors app usage with hourly breakdown
- **Auto-Commit**: App usage verification for automatic commits
- **Start on Startup**: Launch Arvion with Windows
- **Data Export**: JSON backup and CSV history export
- **Command Palette**: Ctrl+K for quick navigation

### Security
- API keys stored securely using Windows Credential Manager (flutter_secure_storage)
- All data stored locally (no cloud sync yet)

### Technical
- Flutter 3.x with Riverpod state management
- Isar embedded NoSQL database
- Win32 APIs for screen time and startup
- Custom high-performance heatmap painter (60-120 FPS)

## [0.1.0] - 2026-02-03

### Added
- Initial development release
- Core architecture and project structure
- Basic dashboard layout
- Database models for Tasks and Commits

---

## Version Format

- **Major** (X.0.0): Breaking changes
- **Minor** (0.X.0): New features, backward compatible
- **Patch** (0.0.X): Bug fixes, backward compatible

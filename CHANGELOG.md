# Changelog

All notable changes to Arvion will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- Initial public release
- Dashboard with GitHub-style contribution heatmap
- Task creation and management with color coding
- Quick commit functionality with intensity levels (1-5)
- Per-task contribution graphs with expandable view
- Multi-color heatmap cells for days with multiple task commits
- Real-time updates using stream-based providers
- Command palette (Ctrl+K) for quick navigation
- Minimum window size enforcement (800x600)
- Dark theme with glassmorphism effects

### Technical
- Flutter 3.x with Riverpod state management
- Isar embedded database for local storage
- Custom high-performance heatmap painter (60-120 FPS)
- Responsive layout with LayoutBuilder

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

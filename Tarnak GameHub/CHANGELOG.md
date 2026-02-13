# Changelog

All notable changes to Tarnak Game Hub will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v1.0.0.html).

## [Unreleased]

### Added
- Initial release of Tarnak Game Hub v1.0.0
- Complete rebranding from Project GLD

## [1.0.0] - 2026-02-13

### Added - Major Features

#### 🎹 Per-Game Key Binding System
- 4 preset configurations (WASD→ESDF, Arrows→WASD, IJKL→WASD, Numpad→Arrows)
- Automatic key binding application when game starts
- Automatic restoration when game closes
- Custom key binding profiles
- Lua scripting interface for key bindings

#### 💬 Global Chat (T-Chat)
- In-game overlay chat system
- Accessible via Ctrl+Shift+T in all games
- Game context awareness
- Message history and persistence
- Transparent overlay UI with ImGui

#### ⚡ System Optimizer
- FPS Boost mode with high performance power plan
- CPU optimization with process priority management
- RAM optimization with working set trimming
- Comprehensive temp file cleaner:
  - Windows Temp files
  - Browser cache (Chrome, Firefox, Edge)
  - System cache and prefetch
  - Game-specific caches
- 3 optimization profiles (Gaming Mode, Maximum Performance, Balanced)

#### ⏱️ Focus Mode / Game Timer
- Daily game time limits
- Allowed time windows (start/end hours)
- Break reminders and notifications
- Schedule presets (Weekday, Weekend, Custom)
- Per-game configuration

#### 🎁 Free Games Aggregator
- Steam free games tracking
- Epic Games Store free games tracking
- Unified list with filtering
- New free game notifications
- Steam account integration (filter owned games)
- Auto-refresh functionality

#### 🌐 Translation System
- 4 translation engines:
  - Google Translate
  - DeepL
  - Microsoft Translator
  - LibreTranslate
- 30+ supported languages
- Right-click context menu integration
- In-game translation overlay
- Translation history and cache
- Language auto-detection

#### 🚀 Auto-Launch Programs
- Launch programs alongside games
- Configurable delays
- Wait for exit options
- Auto-terminate when game closes
- Per-game configuration

#### 🖥️ Desktop Shortcuts
- Create shortcuts for individual games
- Create shortcuts for game groups
- Batch shortcut creation
- Custom icons and arguments

#### 📁 Game Groups
- Organize games into categories
- Color-coded group labels
- Drag-and-drop organization
- Quick group operations
- Persistent group storage

#### 🎨 Global Overlay
- Tabbed interface with 7 sections:
  - Chat
  - Game Info
  - Optimizer
  - Timer
  - Key Bindings
  - System Info
- Toggle with Ctrl+Alt+O
- Customizable opacity and position
- Always on top in games

### Added - Technical Features
- Modern C++17 codebase
- CMake build system
- Windows installer with Inno Setup
- Multi-language support (13 languages)
- Lua scripting API
- ImGui-based UI with 25+ themes
- DirectX 11 rendering
- Multi-threaded architecture
- Comprehensive logging system
- Configuration management

### Added - Documentation
- Complete Turkish documentation
- English documentation
- Lua API reference
- User guide
- Developer guide
- Contributing guidelines

### Security
- Secure API key storage
- Safe DLL injection methods
- Sandboxed Lua execution
- Protected configuration files

### Performance
- Optimized rendering pipeline
- Efficient memory management
- Background task processing
- Smart caching system

## [1.0.0] - Legacy (Project GLD)

### Note
This changelog starts from v1.0.0 as Tarnak Game Hub. Previous versions were released as Project GLD.

---

## Release Template

### Added
- New features

### Changed
- Changes in existing functionality

### Deprecated
- Soon-to-be removed features

### Removed
- Now removed features

### Fixed
- Bug fixes

### Security
- Security improvements

## Contributors

Thank you to all contributors who helped make this release possible!

- [@TARIKTR1099](https://github.com/TARIKTR1099) - Lead Developer

---

For older releases, see the [releases page](https://github.com/TARIKTR1099/TarnakGameHub/releases).

# Tarnak Game Hub Documentation

Welcome to the Tarnak Game Hub documentation! This comprehensive guide will help you understand, use, and contribute to the project.

## 📚 Table of Contents

### For Users
- [User Guide](UserGuide.md) - Complete user manual
- [FAQ](FAQ.md) - Frequently asked questions
- [Troubleshooting](Troubleshooting.md) - Common issues and solutions
- [Keyboard Shortcuts](Shortcuts.md) - All available shortcuts

### For Developers
- [Developer Guide](DeveloperGuide.md) - How to contribute
- [Lua API Reference](LuaAPI.md) - Scripting documentation
- [Architecture Overview](Architecture.md) - System design
- [Building from Source](Building.md) - Compilation guide

### For Translators
- [Translation Guide](TranslationGuide.md) - How to add languages
- [Localization Reference](Localization.md) - Technical details

## 🎯 Quick Links

- [Installation Guide](#installation)
- [First Steps](#first-steps)
- [Configuration](#configuration)

## 📥 Installation

### Windows (Recommended)

1. Download the latest installer from [Releases](https://github.com/TARIKTR1099/TarnakGameHub/releases)
2. Run `TarnakGameHub-Setup-v1.0.0.exe`
3. Follow the installation wizard
4. Launch Tarnak Game Hub from the Start Menu or Desktop

### Portable Version

1. Download the portable ZIP from [Releases](https://github.com/TARIKTR1099/TarnakGameHub/releases)
2. Extract to your preferred location
3. Run `TarnakGameHub.exe`

### System Requirements

- **OS:** Windows 10/11 (64-bit)
- **CPU:** Intel Core i3 or equivalent
- **RAM:** 4 GB minimum, 8 GB recommended
- **Storage:** 500 MB free space
- **GPU:** DirectX 11 compatible
- **Internet:** Required for some features (optional)

## 🚀 First Steps

### Initial Setup

1. **Launch the application**
   - Double-click the desktop icon or find it in the Start Menu

2. **Configure settings**
   - Open Settings (gear icon)
   - Set your preferred language
   - Configure download location
   - Set up your Steam/Epic accounts (optional)

3. **Add your first game**
   - Click "Add Game" button
   - Browse to your game executable
   - Or let Tarnak scan your computer for games

4. **Try the features**
   - Test the overlay (Ctrl+Alt+O)
   - Try the system optimizer
   - Check out free games

### Tutorial Videos

- [Getting Started](videos/getting-started.md)
- [Key Binding Tutorial](videos/key-binding.md)
- [System Optimization Guide](videos/optimization.md)

## ⚙️ Configuration

### Configuration Files

All configuration is stored in:
- `%LOCALAPPDATA%\TarnakGameHub\` (Installed version)
- `.\config\` (Portable version)

### Key Configuration Files

| File | Purpose |
|------|---------|
| `settings.json` | General application settings |
| `keybindings.json` | Key binding configurations |
| `profiles.json` | Optimization profiles |
| `groups.json` | Game groups |

### Environment Variables

- `TARNAK_GAMEHUB_CONFIG` - Override config directory
- `TARNAK_GAMEHUB_LOG_LEVEL` - Set logging level (DEBUG, INFO, WARNING, ERROR)
- `TARNAK_GAMEHUB_NO_UPDATE` - Disable auto-update check

## 🎮 Features Overview

### Core Features

1. **Game Library Management**
   - Import games from Steam, Epic, GOG, etc.
   - Organize with groups and tags
   - Track playtime
   - Manage save files

2. **System Optimization**
   - FPS boost
   - CPU/RAM optimization
   - Temp file cleaning
   - Process management

3. **Key Binding System**
   - Per-game key remapping
   - Preset configurations
   - Automatic apply/restore

4. **Global Overlay**
   - In-game access to all features
   - Chat, timer, optimizer
   - Customizable UI

### Advanced Features

- Lua scripting support
- Discord Rich Presence
- Achievement tracking
- Cloud save sync
- Auto-update

## 🤝 Getting Help

### Support Channels

1. **GitHub Issues** - Bug reports and feature requests
2. **Discussions** - General questions and community
3. **Discord** - Real-time chat (coming soon)

### Before Asking for Help

1. Check the [FAQ](FAQ.md)
2. Search existing [issues](../../issues)
3. Try the [Troubleshooting Guide](Troubleshooting.md)

## 📝 Contributing to Documentation

We welcome documentation improvements! See [CONTRIBUTING.md](../CONTRIBUTING.md) for guidelines.

### Documentation Structure

```
docs/
├── README.md           # This file
├── UserGuide.md        # Main user guide
├── DeveloperGuide.md   # Developer documentation
├── LuaAPI.md          # Lua scripting reference
├── FAQ.md             # Frequently asked questions
├── Troubleshooting.md # Problem solving
├── Shortcuts.md       # Keyboard shortcuts
├── Architecture.md    # System architecture
├── Building.md        # Build instructions
├── TranslationGuide.md # Translation info
├── Localization.md    # Localization details
└── videos/            # Video tutorials
```

## 📄 License

This documentation is licensed under the same terms as the project - [Apache License 2.0](../LICENSE).

---

**Last Updated:** February 2026  
**Version:** 1.0.0

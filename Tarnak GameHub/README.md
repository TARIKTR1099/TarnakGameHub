# Tarnak Game Hub

[![Version](https://img.shields.io/badge/version-1.0.0-blue.svg)](https://github.com/TARIKTR1099/TarnakGameHub/releases)
[![License](https://img.shields.io/badge/license-Apache%202.0-green.svg)](LICENSE)
[![Platform](https://img.shields.io/badge/platform-Windows-0078D6.svg)](https://github.com/TARIKTR1099/TarnakGameHub)

<p align="center">
  <img src="assets/logo.png" alt="Tarnak Game Hub Logo" width="200"/>
</p>

**Tarnak Game Hub** is an advanced game management and optimization platform built for Windows. It provides a comprehensive suite of tools to enhance your gaming experience.

[🇹🇷 Türkçe Dokümantasyon](README_TR.md) | [📖 Full Documentation](docs/README.md)

## 🎮 Features

### Core Features

- 🎹 **Per-Game Key Binding** - Remap keys for specific games with automatic apply/restore
- 💬 **Global Chat (T-Chat)** - In-game overlay chat accessible with Ctrl+Shift+T
- ⚡ **System Optimizer** - FPS boost, CPU/RAM optimization, and temp file cleaner
- ⏱️ **Focus Mode** - Game time limits, scheduling, and break reminders
- 🎁 **Free Games Tracker** - Monitor free games from Steam and Epic Games Store
- 🌐 **Translation System** - Multi-engine translation with 30+ languages
- 🚀 **Auto-Launch Programs** - Launch additional software with games
- 🖥️ **Desktop Shortcuts** - Create shortcuts for games and groups
- 📁 **Game Groups** - Organize your library into categories
- 🎨 **Global Overlay** - Tabbed in-game overlay (Ctrl+Alt+O)

### Advanced Features

- 🎮 **Discord RPC Integration** - Rich presence support
- 🏆 **Achievement System** - Track your gaming achievements
- ☁️ **Cloud Save Sync** - Backup saves to cloud storage
- 📊 **Performance Monitoring** - Real-time FPS, CPU, RAM tracking
- 🎯 **Game Boost Profiles** - Automatic optimization per game
- 🔧 **Mod/Trainer Support** - Built-in DLL injection
- 📥 **Download Manager** - Integrated download management
- 🎨 **Theme Editor** - Customize the UI with 25+ themes
- 🌍 **Multi-Language** - Support for 13 languages

## 🚀 Installation

### Download Pre-built Binary

Download the latest release from [Releases](https://github.com/TARIKTR1099/TarnakGameHub/releases) page.

### Build from Source

#### Prerequisites

- Windows 10/11
- Visual Studio 2022 (or later)
- CMake 3.16+
- Git

#### Build Steps

```bash
# Clone the repository
git clone https://github.com/TARIKTR1099/TarnakGameHub.git
cd TarnakGameHub

# Create build directory
mkdir build
cd build

# Generate project files
cmake .. -G "Visual Studio 17 2022" -A x64

# Build
cmake --build . --config Release

# Create installer
cpack -C Release
```

## 📖 Usage

### Quick Start

1. Launch `TarnakGameHub.exe`
2. Add your games to the library
3. Configure settings per game
4. Launch and enjoy!

### Keyboard Shortcuts

| Shortcut | Action |
|----------|--------|
| `Ctrl + Alt + O` | Toggle Global Overlay |
| `Ctrl + Shift + T` | Open T-Chat |
| `Ctrl + Alt + F` | Toggle Focus Mode |
| `Ctrl + Shift + R` | Quick System Optimize |
| `Ctrl + Shift + U` | Update Free Games List |

### Lua Scripting

Tarnak Game Hub supports Lua scripting for automation:

```lua
-- Example: Custom game launch hook
client.add_callback("on_gamelaunch", function(gameInfo)
    print("Launching: " .. gameInfo.name)
    -- Your custom code here
end)
```

See [Lua API Documentation](docs/LuaAPI.md) for more details.

## 🏗️ Project Structure

```
TarnakGameHub/
├── assets/               # Images, icons, fonts
├── docs/                 # Documentation
├── include/              # C++ header files
│   ├── core/            # Core functionality
│   ├── features/        # Feature implementations
│   └── ui/              # UI components
├── scripts/             # Lua scripts
│   ├── core/           # Core scripts
│   ├── features/       # Feature scripts
│   └── utils/          # Utility scripts
├── src/                 # C++ source files
├── tests/              # Unit tests
├── themes/             # UI themes
├── third_party/        # External libraries
├── translations/       # Language files
├── tools/             # Build tools
├── CMakeLists.txt     # CMake configuration
├── LICENSE            # Apache 2.0 License
└── README.md          # This file
```

## 🛠️ Development

### IDE Setup

1. Open the project in Visual Studio 2022
2. Select `TarnakGameHub` as startup project
3. Build and run!

### Contributing

We welcome contributions! Please see [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📝 Documentation

- [📖 Full Documentation](docs/README.md)
- [🎮 User Guide](docs/UserGuide.md)
- [💻 Developer Guide](docs/DeveloperGuide.md)
- [🔌 Lua API Reference](docs/LuaAPI.md)
- [🇹🇷 Turkish Documentation](README_TR.md)

## 🐛 Bug Reports

If you find a bug, please open an issue on [GitHub Issues](https://github.com/TARIKTR1099/TarnakGameHub/issues) with:

- Clear description of the bug
- Steps to reproduce
- Expected vs actual behavior
- Screenshots (if applicable)
- System information

## 💡 Feature Requests

Have an idea? We'd love to hear it! Open a [Feature Request](https://github.com/TARIKTR1099/TarnakGameHub/issues/new?template=feature_request.md).

## 📜 License

This project is licensed under the Apache License 2.0 - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- [Dear ImGui](https://github.com/ocornut/imgui) - Immediate mode GUI library
- [Lua](https://www.lua.org/) - Scripting engine
- [nlohmann/json](https://github.com/nlohmann/json) - JSON library
- [sol2](https://github.com/ThePhD/sol2) - Lua bindings for C++
- All contributors and testers

## 📞 Contact

- **GitHub:** [@TARIKTR1099](https://github.com/TARIKTR1099)
- **LinkedIn:** [Tarık Eler](https://www.linkedin.com/in/tar%C4%B1k-eler-238698394/)
- **Email:** tarnakdev@gmail.com

## 🗺️ Roadmap

- [ ] Cross-platform support (Linux, macOS)
- [ ] Mobile companion app
- [ ] Steam Workshop integration
- [ ] AI-powered game recommendations
- [ ] VR support
- [ ] Community marketplace

---

<p align="center">
  Made with ❤️ by <strong>Tarnak Development Team</strong>
</p>

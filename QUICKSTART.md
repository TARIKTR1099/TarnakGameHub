# 🚀 Tarnak Game Hub - Quick Start Guide

## 📦 What's Inside

This is the **Tarnak Game Hub v1.0.0** project - A comprehensive game management and optimization platform.

## 🏗️ Project Structure

```
Tarnak GameHub/
├── 📄 CMakeLists.txt          # Build configuration
├── 📄 README.md               # Documentation
├── 📂 include/                # C++ headers
├── 📂 src/                    # C++ source files
├── 📂 scripts/                # Lua scripts
├── 📂 assets/                 # Images, icons, fonts
├── 📂 resources/              # Windows resources
├── 📂 docs/                   # Documentation
├── 📂 installer/              # Setup files
├── 📂 tests/                  # Unit tests
├── 📂 themes/                 # UI themes
└── 📂 translations/           # Language files
```

## 🎯 Main Features

1. **Tuş Atama Sistemi** - Per-game key binding with presets
2. **Global Chat (T-Chat)** - In-game overlay chat (Ctrl+Shift+T)
3. **Sistem Optimizasyonu** - FPS/CPU/RAM boost + temp cleaner
4. **Oyun Zamanlayıcı** - Focus mode with time limits
5. **Ücretsiz Oyunlar** - Steam + Epic free games tracker
6. **Çeviri Sistemi** - Multi-engine translation (30+ languages)
7. **Auto-Launch** - Launch programs with games
8. **Masaüstü Kısayolları** - Desktop shortcuts for games
9. **Oyun Grupları** - Organize games into groups
10. **Global Overlay** - Tabbed in-game overlay (Ctrl+Alt+O)

## 🛠️ Building

### Prerequisites
- Windows 10/11
- Visual Studio 2022
- CMake 3.16+

### Quick Build
```bash
cd "Tarnak GameHub"
mkdir build && cd build
cmake .. -G "Visual Studio 17 2022" -A x64
cmake --build . --config Release
```

### Create Installer
```bash
# With CPack
cpack -C Release

# OR with Inno Setup
"C:\Program Files (x86)\Inno Setup 6\ISCC.exe" ..\installer\setup.iss
```

## 📂 Key Files

### Lua Scripts (`scripts/`)
- `TarnakHub-Initializer.lua` - Main initialization
- `KeyBinding-Script.lua` - Key binding management
- `SystemOptimizer-Script.lua` - System optimization
- `FreeGames-Monitor.lua` - Free games tracking
- `Translation-Helper.lua` - Translation services

### C++ Headers (`include/`)
- `TarnakHub.h` - Main hub with all features
- `core/Application.h` - Main application
- `core/HotkeyManager.h` - Global hotkeys
- `core/Logger.h` - Logging system

### Documentation (`docs/`)
- `README.md` - Documentation homepage
- `Building.md` - Build instructions

## 🔧 Configuration

### CMake Options
- `TARNAK_BUILD_TESTS=ON/OFF` - Build unit tests
- `CMAKE_BUILD_TYPE=Release/Debug` - Build type

### Directories
- Config: `%LOCALAPPDATA%\TarnakGameHub\`
- Logs: `%LOCALAPPDATA%\TarnakGameHub\logs\`
- Cache: `%LOCALAPPDATA%\TarnakGameHub\cache\`

## 🎮 Running

After building:
```
build\bin\Release\TarnakGameHub.exe
```

Or after installation:
```
Start Menu → Tarnak Game Hub
```

## 📞 Support

- **GitHub**: https://github.com/TARIKTR1099
- **LinkedIn**: https://www.linkedin.com/in/tar%C4%B1k-eler-238698394/
- **Email**: tarnakdev@gmail.com

## 📜 License

Apache License 2.0 - See [LICENSE](LICENSE) file

---

**Version**: 1.0.0  
**Author**: Tarnak Development  
**Date**: February 2026

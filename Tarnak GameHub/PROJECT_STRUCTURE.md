# Tarnak Game Hub - Project Structure

This document describes the complete project structure of Tarnak Game Hub.

## 📁 Root Directory

```
Tarnak GameHub/
├── 📄 CMakeLists.txt          # Main CMake configuration
├── 📄 README.md               # English documentation
├── 📄 README_TR.md           # Turkish documentation
├── 📄 CHANGELOG.md           # Version history
├── 📄 LICENSE                # Apache 2.0 License
├── 📄 CONTRIBUTING.md        # Contribution guidelines
├── 📄 .gitignore             # Git ignore rules
│
├── 📂 .github/               # GitHub configuration
│   ├── 📂 workflows/
│   │   └── 📄 build.yml      # CI/CD pipeline
│   └── 📂 ISSUE_TEMPLATE/
│       └── 📄 bug_report.md  # Issue template
│
├── 📂 docs/                  # Documentation
│   ├── 📄 README.md          # Docs homepage
│   └── 📄 Building.md        # Build instructions
│
├── 📂 include/               # C++ header files
│   ├── 📄 pch.h              # Precompiled header
│   ├── 📄 TarnakHub.h        # Main hub header
│   ├── 📂 core/
│   │   ├── 📄 Application.h
│   │   ├── 📄 HotkeyManager.h
│   │   └── 📄 Logger.h
│   ├── 📂 features/
│   └── 📂 ui/
│
├── 📂 src/                   # C++ source files
│   ├── 📄 Main.cpp           # Entry point
│   ├── 📂 core/
│   │   └── 📄 HotkeyManager.cpp
│   ├── 📂 features/
│   └── 📂 ui/
│
├── 📂 scripts/               # Lua scripts
│   ├── 📄 TarnakHub-Initializer.lua
│   ├── 📄 KeyBinding-Script.lua
│   ├── 📄 SystemOptimizer-Script.lua
│   ├── 📄 FreeGames-Monitor.lua
│   └── 📄 Translation-Helper.lua
│
├── 📂 assets/                # Static assets
│   ├── 📂 icons/
│   ├── 📂 fonts/
│   └── 📂 images/
│
├── 📂 resources/             # Windows resources
│   ├── 📄 app.rc             # Resource file
│   └── 📄 app.manifest       # Windows manifest
│
├── 📂 tests/                 # Unit tests
│   └── 📄 TestFramework.h
│
├── 📂 installer/             # Installer files
│   └── 📄 setup.iss          # Inno Setup script
│
├── 📂 themes/                # UI themes (JSON)
│
└── 📂 translations/          # Language files (JSON)
```

## 🎯 Key Components

### Core System (`include/core/`, `src/core/`)
- **Application**: Main application class, message loop
- **HotkeyManager**: Global hotkey registration and management
- **Logger**: Logging system with multiple levels

### Features (`include/features/`, `src/features/`)
- Key Binding System
- System Optimizer
- Focus Mode / Game Timer
- Free Games Aggregator
- Translation System
- Global Chat (T-Chat)
- Game Launcher
- Game Groups
- Desktop Shortcuts
- Overlay Manager

### UI (`include/ui/`, `src/ui/`)
- ImGui-based interface
- Main window
- Settings panels
- Overlay rendering

### Scripts (`scripts/`)
Lua scripts for extending functionality:
- **TarnakHub-Initializer.lua**: Main initialization
- **KeyBinding-Script.lua**: Key binding management
- **SystemOptimizer-Script.lua**: System optimization
- **FreeGames-Monitor.lua**: Free games tracking
- **Translation-Helper.lua**: Translation services

### Assets (`assets/`)
Static resources:
- Icons (`.ico`, `.png`)
- Fonts (`.ttf`, `.otf`)
- Images (`.png`, `.jpg`)

### Resources (`resources/`)
Windows-specific resources:
- Version information
- Application icon
- Windows manifest (DPI awareness, etc.)

### Installer (`installer/`)
- Inno Setup configuration
- Build scripts

### Documentation (`docs/`)
- User guides
- Developer documentation
- Build instructions
- API references

## 🔧 Build System

### CMake Configuration
- **CMakeLists.txt**: Main build configuration
- C++17 standard
- Precompiled headers support
- Automatic asset copying
- CPack integration

### CI/CD (`.github/workflows/`)
- **build.yml**: GitHub Actions workflow
- Automated builds
- Testing
- Release creation

## 📝 Development Guidelines

### Adding New Features

1. **Header file**: Create in `include/features/`
2. **Implementation**: Create in `src/features/`
3. **Lua script** (optional): Create in `scripts/`
4. **Documentation**: Update `docs/`
5. **Tests**: Add to `tests/`

### File Naming Conventions

- **C++ Classes**: PascalCase (e.g., `HotkeyManager.h`)
- **Lua Scripts**: PascalCase with hyphens (e.g., `KeyBinding-Script.lua`)
- **Documentation**: UPPERCASE (e.g., `README.md`)
- **Resources**: lowercase (e.g., `app.ico`)

### Directory Structure Rules

1. Each major feature gets its own subdirectory in `include/` and `src/`
2. Lua scripts are flat in `scripts/` (use prefixes for organization)
3. Assets are categorized by type in `assets/`
4. Tests mirror the `src/` structure

## 🚀 Building

See [docs/Building.md](docs/Building.md) for detailed build instructions.

Quick start:
```bash
mkdir build && cd build
cmake .. -G "Visual Studio 17 2022" -A x64
cmake --build . --config Release
```

## 📦 Distribution

### Files to Include
- `TarnakGameHub.exe`
- `assets/` (all contents)
- `scripts/` (all contents)
- `themes/` (all contents)
- `translations/` (all contents)
- `LICENSE`
- `README.md`

### Installer
Run `installer/setup.iss` with Inno Setup to create `TarnakGameHub-Setup-v1.0.0.exe`.

## 🆘 Support

For questions about the project structure:
- Check [docs/README.md](docs/README.md)
- Open an issue on GitHub
- Contact: tarnakdev@gmail.com

---

**Last Updated**: February 2026  
**Version**: 1.0.0

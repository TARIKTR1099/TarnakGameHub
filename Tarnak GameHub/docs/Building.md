# Building Tarnak Game Hub from Source

This guide explains how to build Tarnak Game Hub from source code.

## 📋 Prerequisites

### Required Software

1. **Visual Studio 2022** (Community, Professional, or Enterprise)
   - Download: https://visualstudio.microsoft.com/downloads/
   - Workloads needed:
     - Desktop development with C++
   - Individual components:
     - MSVC v143 - VS 2022 C++ x64/x86 build tools
     - Windows 10/11 SDK
     - C++ CMake tools for Windows

2. **CMake 3.16 or later**
   - Download: https://cmake.org/download/
   - Or install via Visual Studio Installer

3. **Git**
   - Download: https://git-scm.com/download/win

### Optional Software

- **Inno Setup 6** - For creating the installer
  - Download: https://jrsoftware.org/isdl.php
- **NSIS** - Alternative installer (if using CPack)
  - Download: https://nsis.sourceforge.io/Download

## 🔧 Build Instructions

### 1. Clone the Repository

```bash
git clone --recursive https://github.com/TARIKTR1099/TarnakGameHub.git
cd TarnakGameHub
```

If you already cloned without submodules:
```bash
git submodule update --init --recursive
```

### 2. Generate Build Files

#### Using CMake GUI

1. Open CMake GUI
2. Set source directory: `C:\path\to\TarnakGameHub`
3. Set build directory: `C:\path\to\TarnakGameHub\build`
4. Click "Configure"
5. Select "Visual Studio 17 2022" as generator
6. Select "x64" platform
7. Click "Generate"

#### Using Command Line

```bash
mkdir build
cd build

cmake .. -G "Visual Studio 17 2022" -A x64
```

### 3. Build the Project

#### Using Visual Studio

1. Open `TarnakGameHub.sln` in the build directory
2. Select "Release" configuration
3. Build → Build Solution (Ctrl+Shift+B)

#### Using Command Line

```bash
cmake --build . --config Release --parallel 4
```

### 4. Run Tests (Optional)

```bash
ctest -C Release --output-on-failure
```

### 5. Create Package

```bash
cpack -C Release
```

This creates:
- `TarnakGameHub-1.0.0-win64.exe` - Installer
- `TarnakGameHub-1.0.0-win64.zip` - Portable version

## 🔨 Build Configurations

### Debug Build

```bash
cmake .. -G "Visual Studio 17 2022" -A x64 -DCMAKE_BUILD_TYPE=Debug
cmake --build . --config Debug
```

### Release with Debug Info

```bash
cmake .. -G "Visual Studio 17 2022" -A x64 -DCMAKE_BUILD_TYPE=RelWithDebInfo
cmake --build . --config RelWithDebInfo
```

### Static Linking

```bash
cmake .. -G "Visual Studio 17 2022" -A x64 -DTARNAK_STATIC_LINK=ON
```

## 📦 Creating the Installer

### Using Inno Setup

1. Install Inno Setup
2. Build the project in Release mode
3. Run Inno Setup Compiler:
   ```
   "C:\Program Files (x86)\Inno Setup 6\ISCC.exe" installer\setup.iss
   ```
4. Find the installer at `installer\output\TarnakGameHub-Setup-v1.0.0.exe`

### Using CPack (NSIS)

```bash
cpack -G NSIS -C Release
```

## 🐛 Troubleshooting

### Common Issues

#### "CMake Error: Could not find CMAKE_ROOT"

**Solution:** Add CMake to PATH or reinstall with PATH option enabled.

#### "MSBuild not found"

**Solution:** Run from "Developer Command Prompt for VS 2022" or add MSBuild to PATH:
```
C:\Program Files\Microsoft Visual Studio\2022\Community\MSBuild\Current\Bin
```

#### "Cannot open include file: 'windows.h'"

**Solution:** Install Windows SDK through Visual Studio Installer.

#### "LNK2019: unresolved external symbol"

**Solution:** Make sure all submodules are initialized:
```bash
git submodule update --init --recursive
```

#### "Failed to find DirectX"

**Solution:** Install DirectX SDK or Windows SDK with DirectX components.

### Clean Build

If you encounter persistent issues:

```bash
cd build
rm -rf *
cmake .. -G "Visual Studio 17 2022" -A x64
cmake --build . --config Release
```

## 🎯 Advanced Options

### CMake Options

| Option | Description | Default |
|--------|-------------|---------|
| `TARNAK_BUILD_TESTS` | Build unit tests | ON |
| `TARNAK_BUILD_DOCS` | Build documentation | OFF |
| `TARNAK_STATIC_LINK` | Static link runtime | OFF |
| `TARNAK_USE_LTO` | Enable Link Time Optimization | ON (Release) |

Example:
```bash
cmake .. -G "Visual Studio 17 2022" -A x64 -DTARNAK_BUILD_TESTS=OFF -DTARNAK_STATIC_LINK=ON
```

### Custom Install Directory

```bash
cmake .. -G "Visual Studio 17 2022" -A x64 -DCMAKE_INSTALL_PREFIX=C:/Custom/Path
cmake --build . --config Release
cmake --install . --config Release
```

## 🚀 Continuous Integration

The project includes GitHub Actions workflows for automated building:

- `.github/workflows/build.yml` - Windows builds
- `.github/workflows/release.yml` - Release automation

See these files for the exact build steps used in CI.

## 📚 Additional Resources

- [Developer Guide](DeveloperGuide.md)
- [Architecture Overview](Architecture.md)
- [Contributing Guidelines](../CONTRIBUTING.md)

## ❓ Getting Help

If you encounter issues:

1. Check the [Troubleshooting Guide](Troubleshooting.md)
2. Search [existing issues](../../issues)
3. Create a new issue with:
   - Build log
   - CMake output
   - System information
   - Steps to reproduce

## 📝 Build Script (PowerShell)

For convenience, save this as `build.ps1`:

```powershell
param(
    [ValidateSet("Debug", "Release", "RelWithDebInfo")]
    [string]$Configuration = "Release",
    
    [switch]$Clean,
    [switch]$BuildInstaller,
    [switch]$RunTests
)

$ErrorActionPreference = "Stop"

if ($Clean -and (Test-Path "build")) {
    Remove-Item -Recurse -Force "build"
}

if (-not (Test-Path "build")) {
    New-Item -ItemType Directory -Name "build" | Out-Null
}

Set-Location build

cmake .. -G "Visual Studio 17 2022" -A x64 -DCMAKE_BUILD_TYPE=$Configuration
if ($LASTEXITCODE -ne 0) { throw "CMake configuration failed" }

cmake --build . --config $Configuration --parallel 4
if ($LASTEXITCODE -ne 0) { throw "Build failed" }

if ($RunTests) {
    ctest -C $Configuration --output-on-failure
}

if ($BuildInstaller) {
    cpack -C $Configuration
}

Set-Location ..
Write-Host "Build completed successfully!" -ForegroundColor Green
```

Usage:
```powershell
.\build.ps1 -Configuration Release -BuildInstaller -RunTests
```

---

**Note:** The first build may take 10-30 minutes depending on your hardware as it compiles all dependencies and the application.

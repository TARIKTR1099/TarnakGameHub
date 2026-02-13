@echo off
chcp 65001 >nul
echo ==========================================
echo   Tarnak Game Hub Setup Build Script
echo   Version 1.0.0
echo ==========================================
echo.

REM Check if running from correct directory
if not exist "CMakeLists.txt" (
    echo Error: Please run this script from the Tarnak GameHub root directory!
    echo Current directory: %CD%
    pause
    exit /b 1
)

REM Create build directory
if not exist "build" (
    echo Creating build directory...
    mkdir build
)

cd build

REM Configure with CMake
echo.
echo [1/5] Configuring project with CMake...
cmake .. -G "Visual Studio 17 2022" -A x64 -DCMAKE_BUILD_TYPE=Release
if errorlevel 1 (
    echo Error: CMake configuration failed!
    pause
    exit /b 1
)

REM Build the project
echo.
echo [2/5] Building project...
cmake --build . --config Release --parallel 4
if errorlevel 1 (
    echo Error: Build failed!
    pause
    exit /b 1
)

REM Run tests (optional)
echo.
echo [3/5] Running tests...
ctest -C Release --output-on-failure
if errorlevel 1 (
    echo Warning: Some tests failed, continuing...
)

REM Create installer with CPack
echo.
echo [4/5] Creating installer with CPack...
cpack -C Release
if errorlevel 1 (
    echo Warning: CPack failed, trying Inno Setup...
)

REM Create installer with Inno Setup if available
echo.
echo [5/5] Creating installer with Inno Setup...
if exist "C:\Program Files (x86)\Inno Setup 6\ISCC.exe" (
    "C:\Program Files (x86)\Inno Setup 6\ISCC.exe" ..\installer\setup.iss
    if errorlevel 1 (
        echo Warning: Inno Setup compilation failed!
    ) else (
        echo Success: Inno Setup installer created!
    )
) else (
    echo Warning: Inno Setup not found at default location.
    echo Please install Inno Setup 6 to create the installer.
)

echo.
echo ==========================================
echo   Build Complete!
echo ==========================================
echo.
echo Output files:
echo   - Executable: build\bin\Release\TarnakGameHub.exe
echo   - Installer:  build\TarnakGameHub-1.0.0-win64.exe
echo   - Installer:  installer\output\TarnakGameHub-Setup-1.0.0.exe
echo.
pause

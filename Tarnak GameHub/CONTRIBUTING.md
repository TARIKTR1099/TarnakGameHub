# Contributing to Tarnak Game Hub

First off, thank you for considering contributing to Tarnak Game Hub! It's people like you that make this project a great tool for the gaming community.

## 🚀 Quick Links

- [Code of Conduct](CODE_OF_CONDUCT.md)
- [Issue Tracker](../../issues)
- [Pull Requests](../../pulls)
- [Discussions](../../discussions)

## 📋 Table of Contents

- [Getting Started](#getting-started)
- [How Can I Contribute?](#how-can-i-contribute)
- [Development Setup](#development-setup)
- [Coding Standards](#coding-standards)
- [Commit Guidelines](#commit-guidelines)
- [Pull Request Process](#pull-request-process)

## 🏁 Getting Started

### Prerequisites

- Windows 10/11
- Visual Studio 2022 (with C++ workload)
- CMake 3.16+
- Git

### Fork and Clone

1. Fork the repository on GitHub
2. Clone your fork locally:
```bash
git clone https://github.com/YOUR_USERNAME/TarnakGameHub.git
cd TarnakGameHub
```

3. Add upstream remote:
```bash
git remote add upstream https://github.com/TARIKTR1099/TarnakGameHub.git
```

## 💡 How Can I Contribute?

### Reporting Bugs

Before creating bug reports, please check the [existing issues](../../issues) to avoid duplicates.

When creating a bug report, please include:
- **Clear title and description**
- **Steps to reproduce** the issue
- **Expected behavior** vs **actual behavior**
- **Screenshots** (if applicable)
- **System information**:
  - Windows version
  - Tarnak Game Hub version
  - Hardware specs (if relevant)
- **Logs** (located in `%LOCALAPPDATA%\TarnakGameHub\logs`)

### Suggesting Features

Feature requests are welcome! Please provide:
- Clear use case
- Detailed description
- Possible implementation approach (if you have ideas)
- Mockups or diagrams (optional but helpful)

### Contributing Code

#### Finding Issues to Work On

- Check [good first issue](../../labels/good%20first%20issue) labels
- Look for [help wanted](../../labels/help%20wanted) issues
- Comment on an issue before starting work to avoid conflicts

#### Development Workflow

1. **Create a branch**
```bash
git checkout -b feature/your-feature-name
# or
git checkout -b fix/issue-description
```

2. **Make your changes**
   - Follow coding standards
   - Add tests if applicable
   - Update documentation

3. **Test your changes**
```bash
mkdir build && cd build
cmake .. -G "Visual Studio 17 2022" -A x64
cmake --build . --config Release
```

4. **Commit your changes**
```bash
git add .
git commit -m "feat: add amazing feature"
```

5. **Push and create PR**
```bash
git push origin feature/your-feature-name
```

## 🛠️ Development Setup

### Building the Project

See [README.md](README.md#build-from-source) for detailed build instructions.

### Project Structure

```
TarnakGameHub/
├── include/          # Header files
│   ├── core/        # Core functionality
│   ├── features/    # Feature implementations
│   └── ui/          # UI components
├── src/             # Source files
│   ├── core/
│   ├── features/
│   └── ui/
├── scripts/         # Lua scripts
├── tests/          # Unit tests
└── docs/           # Documentation
```

### Lua Script Development

To add new Lua scripts:
1. Create script in `scripts/` directory
2. Follow existing script structure
3. Add documentation comments
4. Test thoroughly
5. Update [Lua API docs](docs/LuaAPI.md)

## 📐 Coding Standards

### C++ Guidelines

#### Style
- Use **PascalCase** for class names: `GameLauncher`
- Use **camelCase** for functions and variables: `launchGame`, `playerCount`
- Use **UPPER_SNAKE_CASE** for macros: `MAX_PLAYERS`
- Use **m_** prefix for member variables: `m_gameName`

#### Code Format
```cpp
// Good
class GameManager
{
public:
    void LaunchGame(const std::string& gameName);
    
private:
    std::string m_currentGame;
    int m_playerCount{0};
};

// Bad
class gameManager {
    void launchgame(string name);
    string currentgame;
};
```

#### Best Practices
- Use smart pointers instead of raw pointers
- Prefer `const` correctness
- Use `auto` where it improves readability
- Add `noexcept` where appropriate
- Document public APIs with comments

### Lua Guidelines

#### Style
- Use **PascalCase** for module names: `KeyBindingManager`
- Use **camelCase** for functions: `loadBindings`
- Use **snake_case** for variables: `game_name`

#### Example
```lua
-- Good
local GameLauncher = {}

function GameLauncher.LaunchGame(gameName)
    local exePath = GetExecutablePath(gameName)
    if exePath then
        exec(exePath)
    end
end

-- Bad
local gamelauncher = {}
function gamelauncher.launchgame(name)
    path = getpath(name)
    exec(path)
end
```

## 📝 Commit Guidelines

### Commit Message Format
```
type(scope): subject

body (optional)

footer (optional)
```

### Types
- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation only
- `style`: Code style changes (formatting, semicolons, etc)
- `refactor`: Code refactoring
- `perf`: Performance improvements
- `test`: Adding or updating tests
- `chore`: Build process or auxiliary tool changes

### Examples
```
feat(keybinding): add WASD to ESDF preset

Add new preset for ergonomic key binding that moves WASD to ESDF
position for better pinky finger access.

Closes #123
```

```
fix(optimizer): resolve memory leak in temp cleaner

Fixed memory leak caused by not releasing COM objects in
CleanTempFiles() function.

Fixes #456
```

## 🔄 Pull Request Process

1. **Update documentation** if needed
2. **Add tests** for new features
3. **Ensure all tests pass**
4. **Update CHANGELOG.md** with your changes
5. **Fill out the PR template** completely
6. **Link related issues** using keywords (Fixes #123, Closes #456)
7. **Wait for review** - be patient and responsive to feedback

### PR Checklist

- [ ] Code follows style guidelines
- [ ] Self-review completed
- [ ] Comments added for complex code
- [ ] Documentation updated
- [ ] Tests added/updated and passing
- [ ] CHANGELOG.md updated
- [ ] No merge conflicts
- [ ] PR description is clear and complete

## 🎯 Areas for Contribution

### High Priority
- Performance optimizations
- Bug fixes
- Documentation improvements
- Test coverage

### Feature Areas
- UI/UX improvements
- New Lua API functions
- Additional game sources
- Theme creation
- Translation updates

### Good First Issues
- Documentation fixes
- Code comments
- Small bug fixes
- Adding new themes

## ❓ Questions?

- Join our [Discussions](../../discussions)
- Contact us on [Discord](https://discord.gg/tarnak) (placeholder)
- Email: tarnakdev@gmail.com

## 🏆 Recognition

Contributors will be:
- Listed in [CONTRIBUTORS.md](CONTRIBUTORS.md)
- Mentioned in release notes
- Given credit in the application

Thank you for contributing to Tarnak Game Hub! 🎮

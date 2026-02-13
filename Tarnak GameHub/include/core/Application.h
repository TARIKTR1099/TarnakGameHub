#pragma once

#include "../pch.h"
#include <string>
#include <memory>
#include <atomic>

namespace Tarnak {

// Forward declarations
class Window;
class Renderer;
class UIManager;
class HotkeyManager;

/**
 * Main application class
 */
class Application
{
public:
    static void Create(HINSTANCE hInstance);
    static void Destroy();
    static Application& Get();
    
    // Non-copyable
    Application(const Application&) = delete;
    Application& operator=(const Application&) = delete;
    
    // Main loop
    int Run();
    void Shutdown();
    
    // Getters
    HINSTANCE GetHInstance() const { return m_hInstance; }
    bool IsRunning() const { return m_running; }
    
    // Subsystems
    Window* GetWindow() const { return m_window.get(); }
    Renderer* GetRenderer() const { return m_renderer.get(); }
    UIManager* GetUIManager() const { return m_uiManager.get(); }
    HotkeyManager* GetHotkeyManager() const { return m_hotkeyManager.get(); }

private:
    Application(HINSTANCE hInstance);
    ~Application();
    
    bool Initialize();
    void ProcessMessages();
    void Update();
    void Render();
    
    HINSTANCE m_hInstance = nullptr;
    std::atomic<bool> m_running{false};
    
    std::unique_ptr<Window> m_window;
    std::unique_ptr<Renderer> m_renderer;
    std::unique_ptr<UIManager> m_uiManager;
    std::unique_ptr<HotkeyManager> m_hotkeyManager;
    
    static Application* s_instance;
};

} // namespace Tarnak

#pragma once

#include "../pch.h"
#include <string>
#include <vector>
#include <functional>
#include <map>
#include <mutex>

namespace Tarnak {

/**
 * Manages global hotkeys for the application
 */
class HotkeyManager
{
public:
    using HotkeyCallback = std::function<void(int)>;
    
    static HotkeyManager& Instance();
    
    // Non-copyable
    HotkeyManager(const HotkeyManager&) = delete;
    HotkeyManager& operator=(const HotkeyManager&) = delete;
    
    // Initialize and shutdown
    bool Initialize();
    void Shutdown();
    
    // Hotkey registration
    bool RegisterHotkey(int id, UINT modifiers, UINT vk, HotkeyCallback callback);
    bool UnregisterHotkey(int id);
    void UnregisterAll();
    
    // Process hotkey messages (call from message loop)
    void ProcessHotkey(int id);
    
    // Check if hotkey is registered
    bool IsRegistered(int id) const;
    
    // Get registered hotkeys count
    size_t GetRegisteredCount() const;

private:
    HotkeyManager() = default;
    ~HotkeyManager();
    
    std::map<int, HotkeyCallback> m_callbacks;
    mutable std::mutex m_mutex;
    bool m_initialized = false;
};

// Global hotkey IDs
namespace HotkeyIds
{
    constexpr int OVERLAY_TOGGLE = 1001;
    constexpr int CHAT_TOGGLE = 1002;
    constexpr int FOCUS_MODE_TOGGLE = 1003;
    constexpr int QUICK_OPTIMIZE = 1004;
    constexpr int UPDATE_FREE_GAMES = 1005;
}

// Default hotkey combinations
namespace DefaultHotkeys
{
    constexpr UINT OVERLAY_MODIFIERS = MOD_CONTROL | MOD_ALT;
    constexpr UINT OVERLAY_KEY = 0x4F; // 'O'
    
    constexpr UINT CHAT_MODIFIERS = MOD_CONTROL | MOD_SHIFT;
    constexpr UINT CHAT_KEY = 0x54; // 'T'
    
    constexpr UINT FOCUS_MODIFIERS = MOD_CONTROL | MOD_ALT;
    constexpr UINT FOCUS_KEY = 0x46; // 'F'
    
    constexpr UINT OPTIMIZE_MODIFIERS = MOD_CONTROL | MOD_SHIFT;
    constexpr UINT OPTIMIZE_KEY = 0x52; // 'R'
    
    constexpr UINT UPDATE_GAMES_MODIFIERS = MOD_CONTROL | MOD_SHIFT;
    constexpr UINT UPDATE_GAMES_KEY = 0x55; // 'U'
}

} // namespace Tarnak

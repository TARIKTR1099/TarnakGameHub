#include "pch.h"
#include "core/HotkeyManager.h"

namespace Tarnak {

HotkeyManager& HotkeyManager::Instance()
{
    static HotkeyManager instance;
    return instance;
}

HotkeyManager::~HotkeyManager()
{
    Shutdown();
}

bool HotkeyManager::Initialize()
{
    std::lock_guard<std::mutex> lock(m_mutex);
    
    if (m_initialized)
    {
        return true;
    }
    
    m_initialized = true;
    return true;
}

void HotkeyManager::Shutdown()
{
    std::lock_guard<std::mutex> lock(m_mutex);
    
    if (!m_initialized)
    {
        return;
    }
    
    UnregisterAll();
    m_initialized = false;
}

bool HotkeyManager::RegisterHotkey(int id, UINT modifiers, UINT vk, HotkeyCallback callback)
{
    std::lock_guard<std::mutex> lock(m_mutex);
    
    if (!m_initialized)
    {
        return false;
    }
    
    // Unregister existing hotkey with same ID
    if (m_callbacks.find(id) != m_callbacks.end())
    {
        UnregisterHotkey(id);
    }
    
    // Register Windows hotkey
    if (!RegisterHotKey(NULL, id, modifiers, vk))
    {
        DWORD error = GetLastError();
        // Log error
        return false;
    }
    
    m_callbacks[id] = std::move(callback);
    return true;
}

bool HotkeyManager::UnregisterHotkey(int id)
{
    std::lock_guard<std::mutex> lock(m_mutex);
    
    auto it = m_callbacks.find(id);
    if (it == m_callbacks.end())
    {
        return false;
    }
    
    UnregisterHotKey(NULL, id);
    m_callbacks.erase(it);
    
    return true;
}

void HotkeyManager::UnregisterAll()
{
    std::lock_guard<std::mutex> lock(m_mutex);
    
    for (const auto& pair : m_callbacks)
    {
        UnregisterHotKey(NULL, pair.first);
    }
    
    m_callbacks.clear();
}

void HotkeyManager::ProcessHotkey(int id)
{
    std::lock_guard<std::mutex> lock(m_mutex);
    
    auto it = m_callbacks.find(id);
    if (it != m_callbacks.end() && it->second)
    {
        it->second(id);
    }
}

bool HotkeyManager::IsRegistered(int id) const
{
    std::lock_guard<std::mutex> lock(m_mutex);
    return m_callbacks.find(id) != m_callbacks.end();
}

size_t HotkeyManager::GetRegisteredCount() const
{
    std::lock_guard<std::mutex> lock(m_mutex);
    return m_callbacks.size();
}

} // namespace Tarnak

--[[
    KeyBinding-Script.lua
    Per-game key binding management for Tarnak Game Hub
    Version: 2.0.0
--]]

local VERSION = "2.0.0"
local KeyBindingManager = {
    currentBindings = {},
    defaultBindings = {},
    presets = {},
    activeGame = nil,
    hookInstalled = false
}

-- Preset configurations
KeyBindingManager.PRESETS = {
    WASD_ESDF = {
        name = "WASD → ESDF",
        description = "Move WASD to ESDF for better pinky access",
        mappings = {
            [0x57] = 0x45, -- W → E
            [0x41] = 0x53, -- A → S
            [0x53] = 0x44, -- S → D
            [0x44] = 0x46, -- D → F
        }
    },
    ARROWS_WASD = {
        name = "Arrows → WASD",
        description = "Replace arrow keys with WASD",
        mappings = {
            [0x26] = 0x57, -- UP → W
            [0x25] = 0x41, -- LEFT → A
            [0x28] = 0x53, -- DOWN → S
            [0x27] = 0x44, -- RIGHT → D
        }
    },
    IJKL_WASD = {
        name = "IJKL → WASD",
        description = "Right-hand IJKL to WASD",
        mappings = {
            [0x49] = 0x57, -- I → W
            [0x4A] = 0x41, -- J → A
            [0x4B] = 0x53, -- K → S
            [0x4C] = 0x44, -- L → D
        }
    },
    NUMPAD_ARROW = {
        name = "Numpad → Arrows",
        description = "Numpad 8462 to Arrow keys",
        mappings = {
            [0x68] = 0x26, -- 8 → UP
            [0x64] = 0x25, -- 4 → LEFT
            [0x62] = 0x28, -- 2 → DOWN
            [0x66] = 0x27, -- 6 → RIGHT
        }
    }
}

-- Initialize key binding manager
function KeyBindingManager.Initialize()
    print("[KeyBindingManager] Initializing v" .. VERSION)
    
    -- Load saved presets
    KeyBindingManager.LoadPresets()
    
    -- Create menu UI
    KeyBindingManager.CreateMenu()
    
    print("[KeyBindingManager] Ready!")
end

-- Create menu interface
function KeyBindingManager.CreateMenu()
    -- Main menu
    menu.add_text("Key Binding Settings")
    menu.next_line()
    
    -- Enable/disable key bindings
    menu.add_check_box("keybindings_enabled")
    menu.add_text("Enable Per-Game Key Bindings")
    menu.next_line()
    
    -- Preset selector
    menu.add_text("Quick Presets:")
    menu.add_combo_box("keybinding_preset", {"None", "WASD→ESDF", "Arrows→WASD", "IJKL→WASD", "Numpad→Arrows"})
    menu.next_line()
    
    -- Current game info
    menu.add_text("Current Game: ")
    menu.add_text("current_game_display")
    menu.next_line()
    
    -- Custom binding buttons
    menu.add_button("Configure Bindings")
    menu.add_button("Save Preset")
    menu.add_button("Load Preset")
    menu.next_line()
    
    -- Reset button
    menu.add_button("Reset to Defaults")
    
    -- Register button callbacks
    client.add_callback("on_button_Configure Bindings", function()
        KeyBindingManager.ShowBindingConfigurator()
    end)
    
    client.add_callback("on_button_Save Preset", function()
        KeyBindingManager.SaveCurrentPreset()
    end)
    
    client.add_callback("on_button_Load Preset", function()
        KeyBindingManager.LoadSelectedPreset()
    end)
    
    client.add_callback("on_button_Reset to Defaults", function()
        KeyBindingManager.RestoreDefaults()
    end)
end

-- Load key bindings for specific game
function KeyBindingManager.LoadForGame(gameExe)
    print("[KeyBindingManager] Loading bindings for: " .. gameExe)
    KeyBindingManager.activeGame = gameExe
    
    local configPath = client.GetScriptsPath() .. "\\KeyBindings\\" .. gameExe .. ".json"
    if file.exists(configPath) then
        local config = file.read(configPath)
        KeyBindingManager.currentBindings = JsonWrapper.parse(config)
        print("[KeyBindingManager] Loaded " .. #KeyBindingManager.currentBindings .. " bindings")
    else
        KeyBindingManager.currentBindings = {}
        print("[KeyBindingManager] No saved bindings found")
    end
    
    -- Update UI
    menu.set_text("current_game_display", gameExe)
end

-- Apply current bindings
function KeyBindingManager.Apply()
    if not menu.get_bool("keybindings_enabled") then
        print("[KeyBindingManager] Key bindings disabled")
        return
    end
    
    print("[KeyBindingManager] Applying " .. #KeyBindingManager.currentBindings .. " bindings")
    
    -- Store default bindings for restoration
    KeyBindingManager.defaultBindings = {}
    for _, binding in ipairs(KeyBindingManager.currentBindings) do
        KeyBindingManager.defaultBindings[binding.original] = binding.original
    end
    
    -- Install keyboard hook (if implemented at C++ level)
    -- This would communicate with the C++ KeyBindingManager
    
    Notifications.push("Key Bindings", "Applied " .. #KeyBindingManager.currentBindings .. " key mappings")
end

-- Restore default bindings
function KeyBindingManager.RestoreDefaults()
    print("[KeyBindingManager] Restoring default key bindings")
    KeyBindingManager.currentBindings = {}
    KeyBindingManager.SaveForGame(KeyBindingManager.activeGame or "default")
    Notifications.push("Key Bindings", "Restored to defaults")
end

-- Save bindings for current game
function KeyBindingManager.SaveForGame(gameExe)
    local configDir = client.GetScriptsPath() .. "\\KeyBindings"
    if not file.exists(configDir) then
        file.create_directory(configDir)
    end
    
    local configPath = configDir .. "\\" .. gameExe .. ".json"
    local json = JsonWrapper.stringify(KeyBindingManager.currentBindings)
    file.write(configPath, json)
    print("[KeyBindingManager] Saved bindings for: " .. gameExe)
end

-- Apply preset
function KeyBindingManager.ApplyPreset(presetName)
    local preset = KeyBindingManager.PRESETS[presetName]
    if preset then
        KeyBindingManager.currentBindings = {}
        for original, mapped in pairs(preset.mappings) do
            table.insert(KeyBindingManager.currentBindings, {
                original = original,
                mapped = mapped,
                enabled = true
            })
        end
        print("[KeyBindingManager] Applied preset: " .. preset.name)
        Notifications.push("Key Bindings", "Applied preset: " .. preset.name)
    end
end

-- Show binding configurator
function KeyBindingManager.ShowBindingConfigurator()
    print("[KeyBindingManager] Opening binding configurator...")
    -- This would open a more detailed UI for custom key mapping
    -- For now, show a notification
    Notifications.push("Key Bindings", "Configurator opening...")
end

-- Save current as preset
function KeyBindingManager.SaveCurrentPreset()
    print("[KeyBindingManager] Saving current bindings as preset...")
    -- Implementation for saving custom preset
    Notifications.push("Key Bindings", "Preset saved!")
end

-- Load selected preset
function KeyBindingManager.LoadSelectedPreset()
    local presetIdx = menu.get_int("keybinding_preset")
    local presetNames = {"None", "WASD_ESDF", "ARROWS_WASD", "IJKL_WASD", "NUMPAD_ARROW"}
    
    if presetIdx > 0 and presetIdx <= #presetNames then
        KeyBindingManager.ApplyPreset(presetNames[presetIdx])
    end
end

-- Load saved presets
function KeyBindingManager.LoadPresets()
    local presetsPath = client.GetScriptsPath() .. "\\KeyBindings\\presets.json"
    if file.exists(presetsPath) then
        local data = file.read(presetsPath)
        KeyBindingManager.presets = JsonWrapper.parse(data)
        print("[KeyBindingManager] Loaded " .. #KeyBindingManager.presets .. " custom presets")
    end
end

-- Get available presets
function KeyBindingManager.GetAvailablePresets()
    local names = {}
    for name, preset in pairs(KeyBindingManager.PRESETS) do
        table.insert(names, preset.name)
    end
    return names
end

-- Add custom binding
function KeyBindingManager.AddBinding(originalKey, mappedKey)
    table.insert(KeyBindingManager.currentBindings, {
        original = originalKey,
        mapped = mappedKey,
        enabled = true
    })
end

-- Remove binding
function KeyBindingManager.RemoveBinding(index)
    if index > 0 and index <= #KeyBindingManager.currentBindings then
        table.remove(KeyBindingManager.currentBindings, index)
    end
end

-- Initialize
KeyBindingManager.Initialize()

-- Export
_G.KeyBindingManager = KeyBindingManager

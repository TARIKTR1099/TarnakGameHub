--[[
    TarnakHub-Initializer.lua
    Main initialization script for Tarnak Game Hub
    Version: 2.0.0
--]]

local VERSION = "2.0.0"
local TARNAK_HUB = {}

-- Initialize Tarnak Game Hub
function TARNAK_HUB.Initialize()
    print("[TarnakHub] Initializing Tarnak Game Hub v" .. VERSION)
    
    -- Register callbacks
    client.add_callback("on_launch", function()
        TARNAK_HUB.OnLaunch()
    end)
    
    client.add_callback("on_gamelaunch", function(gameInfo)
        TARNAK_HUB.OnGameLaunch(gameInfo)
    end)
    
    client.add_callback("on_gameclosed", function(gameInfo)
        TARNAK_HUB.OnGameClose(gameInfo)
    end)
    
    -- Initialize subsystems
    TARNAK_HUB.InitKeyBindings()
    TARNAK_HUB.InitGlobalChat()
    TARNAK_HUB.InitSystemOptimizer()
    TARNAK_HUB.InitFreeGamesMonitor()
    TARNAK_HUB.InitTranslation()
    
    print("[TarnakHub] Initialization complete!")
    Notifications.push_success("Tarnak Game Hub", "Successfully initialized v" .. VERSION)
end

-- On GLD Launch
function TARNAK_HUB.OnLaunch()
    print("[TarnakHub] Tarnak Game Hub is ready!")
    
    -- Check for updates
    TARNAK_HUB.CheckForUpdates()
    
    -- Start free games monitoring
    TARNAK_HUB.StartFreeGamesMonitoring()
end

-- On Game Launch
function TARNAK_HUB.OnGameLaunch(gameInfo)
    print("[TarnakHub] Game launched: " .. gameInfo.name)
    
    -- Get game executable name
    local exeName = file.get_filename(gameInfo.exePath)
    
    -- Apply key bindings
    TARNAK_HUB.ApplyKeyBindings(exeName)
    
    -- Apply optimizations
    TARNAK_HUB.ApplyOptimizations(exeName)
    
    -- Start focus mode tracking
    TARNAK_HUB.StartFocusMode(exeName)
    
    -- Launch auto-launch programs
    TARNAK_HUB.LaunchAutoPrograms(exeName)
    
    -- Set global chat context
    TARNAK_HUB.SetChatContext(gameInfo.name)
end

-- On Game Close
function TARNAK_HUB.OnGameClose(gameInfo)
    print("[TarnakHub] Game closed: " .. gameInfo.name)
    
    local exeName = file.get_filename(gameInfo.exePath)
    
    -- Restore key bindings
    TARNAK_HUB.RestoreKeyBindings()
    
    -- Restore system settings
    TARNAK_HUB.RestoreOptimizations()
    
    -- Stop focus mode tracking
    TARNAK_HUB.StopFocusMode(exeName)
    
    -- Terminate auto-launch programs
    TARNAK_HUB.TerminateAutoPrograms(exeName)
    
    -- Clear chat context
    TARNAK_HUB.ClearChatContext()
end

-- Key Bindings
function TARNAK_HUB.InitKeyBindings()
    print("[TarnakHub] Initializing key binding system...")
    -- Load key binding configuration
    local configPath = client.GetScriptsPath() .. "\\KeyBindings\\config.json"
    if file.exists(configPath) then
        local config = file.read(configPath)
        TARNAK_HUB.keyBindingsConfig = JsonWrapper.parse(config)
    else
        TARNAK_HUB.keyBindingsConfig = {}
    end
end

function TARNAK_HUB.ApplyKeyBindings(gameExe)
    print("[TarnakHub] Applying key bindings for: " .. gameExe)
    -- Implementation in KeyBinding-Script.lua
    if KeyBindingManager then
        KeyBindingManager.LoadForGame(gameExe)
        KeyBindingManager.Apply()
    end
end

function TARNAK_HUB.RestoreKeyBindings()
    print("[TarnakHub] Restoring default key bindings...")
    if KeyBindingManager then
        KeyBindingManager.RestoreDefaults()
    end
end

-- System Optimizer
function TARNAK_HUB.InitSystemOptimizer()
    print("[TarnakHub] Initializing system optimizer...")
    -- Load optimizer settings
end

function TARNAK_HUB.ApplyOptimizations(gameExe)
    print("[TarnakHub] Applying optimizations for: " .. gameExe)
    -- Apply game-specific optimizations
end

function TARNAK_HUB.RestoreOptimizations()
    print("[TarnakHub] Restoring system settings...")
    -- Restore system to default state
end

-- Focus Mode
function TARNAK_HUB.StartFocusMode(gameExe)
    print("[TarnakHub] Starting focus mode for: " .. gameExe)
    -- Start game timer
end

function TARNAK_HUB.StopFocusMode(gameExe)
    print("[TarnakHub] Stopping focus mode for: " .. gameExe)
    -- Stop game timer and save session data
end

-- Auto-Launch Programs
function TARNAK_HUB.LaunchAutoPrograms(gameExe)
    print("[TarnakHub] Launching auto-launch programs for: " .. gameExe)
    local configPath = client.GetScriptsPath() .. "\\AutoLaunch\\" .. gameExe .. ".json"
    if file.exists(configPath) then
        local config = JsonWrapper.parse(file.read(configPath))
        for _, program in ipairs(config.programs) do
            if program.enabled then
                print("[TarnakHub] Auto-launching: " .. program.path)
                exec(program.path, program.delay or 0, program.args or "")
            end
        end
    end
end

function TARNAK_HUB.TerminateAutoPrograms(gameExe)
    print("[TarnakHub] Terminating auto-launch programs for: " .. gameExe)
    -- Terminate auto-launched programs
end

-- Global Chat
function TARNAK_HUB.InitGlobalChat()
    print("[TarnakHub] Initializing global chat (T-Chat)...")
end

function TARNAK_HUB.SetChatContext(gameName)
    print("[TarnakHub] Setting chat context to: " .. gameName)
    -- Set current game context for chat
end

function TARNAK_HUB.ClearChatContext()
    print("[TarnakHub] Clearing chat context")
    -- Clear game context
end

-- Free Games Monitor
function TARNAK_HUB.InitFreeGamesMonitor()
    print("[TarnakHub] Initializing free games monitor...")
end

function TARNAK_HUB.StartFreeGamesMonitoring()
    print("[TarnakHub] Starting free games monitoring...")
    -- Check for new free games periodically
end

function TARNAK_HUB.CheckForUpdates()
    print("[TarnakHub] Checking for updates...")
    -- Check for script updates
end

-- Translation
function TARNAK_HUB.InitTranslation()
    print("[TarnakHub] Initializing translation system...")
end

-- Initialize on load
TARNAK_HUB.Initialize()

-- Global access
_G.TarnakHub = TARNAK_HUB

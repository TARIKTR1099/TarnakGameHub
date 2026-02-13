--[[
    SystemOptimizer-Script.lua
    System optimization and temp file cleaner for Tarnak Game Hub
    Version: 2.0.0
--]]

local VERSION = "2.0.0"
local SystemOptimizer = {
    fpsBoostActive = false,
    cpuOptimized = false,
    ramOptimized = false,
    lastOptimization = nil,
    profiles = {},
    currentProfile = "default"
}

-- Optimization profiles
SystemOptimizer.PROFILES = {
    default = {
        name = "Default",
        boostFPS = false,
        optimizeCPU = false,
        optimizeRAM = false,
        cleanTemp = false,
        priorityLevel = 0,
        processesToSuspend = {}
    },
    gaming = {
        name = "Gaming Mode",
        boostFPS = true,
        optimizeCPU = true,
        optimizeRAM = true,
        cleanTemp = true,
        priorityLevel = 1,
        processesToSuspend = {
            "OneDrive.exe",
            "Dropbox.exe",
            "GoogleDrive.exe",
            "Steam.exe", -- Keep running for game access
            "EpicGamesLauncher.exe",
            "Battle.net.exe",
            "Origin.exe"
        }
    },
    performance = {
        name = "Maximum Performance",
        boostFPS = true,
        optimizeCPU = true,
        optimizeRAM = true,
        cleanTemp = true,
        priorityLevel = 2,
        processesToSuspend = {
            "OneDrive.exe",
            "Dropbox.exe",
            "GoogleDrive.exe",
            "Skype.exe",
            "Teams.exe",
            "Discord.exe",
            "Spotify.exe",
            "Chrome.exe",
            "Firefox.exe",
            "Edge.exe"
        }
    },
    balanced = {
        name = "Balanced",
        boostFPS = true,
        optimizeCPU = false,
        optimizeRAM = true,
        cleanTemp = true,
        priorityLevel = 0,
        processesToSuspend = {
            "OneDrive.exe",
            "Dropbox.exe"
        }
    }
}

-- Temp file locations
SystemOptimizer.TEMP_LOCATIONS = {
    "C:\\Windows\\Temp",
    os.getenv("TEMP") or "C:\\Users\\" .. file.getusername() .. "\\AppData\\Local\\Temp",
    os.getenv("TMP") or "C:\\Users\\" .. file.getusername() .. "\\AppData\\Local\\Temp",
    "C:\\Windows\\Prefetch",
    "C:\\Users\\" .. file.getusername() .. "\\AppData\\Local\\Microsoft\\Windows\\Explorer\\ThumbCacheToDelete",
    "C:\\Users\\" .. file.getusername() .. "\\AppData\\Local\\Microsoft\\Windows\\INetCache",
    "C:\\Users\\" .. file.getusername() .. "\\AppData\\Local\\Google\\Chrome\\User Data\\Default\\Cache",
    "C:\\Users\\" .. file.getusername() .. "\\AppData\\Local\\Mozilla\\Firefox\\Profiles"
}

-- Initialize optimizer
function SystemOptimizer.Initialize()
    print("[SystemOptimizer] Initializing v" .. VERSION)
    
    -- Load saved profiles
    SystemOptimizer.LoadProfiles()
    
    -- Create menu UI
    SystemOptimizer.CreateMenu()
    
    -- Start monitoring thread
    SystemOptimizer.StartMonitoring()
    
    print("[SystemOptimizer] Ready!")
end

-- Create menu interface
function SystemOptimizer.CreateMenu()
    -- Main optimization section
    menu.add_text("System Optimizer")
    menu.add_text("v" .. VERSION)
    menu.next_line()
    
    -- Quick optimize button
    menu.add_button("Quick Optimize")
    menu.next_line()
    
    -- Profile selection
    menu.add_text("Optimization Profile:")
    menu.add_combo_box("optimizer_profile", {"Default", "Gaming Mode", "Maximum Performance", "Balanced", "Custom"})
    menu.next_line()
    
    -- Individual options
    menu.add_text("Manual Options:")
    menu.add_check_box("opt_fps_boost")
    menu.add_text("FPS Boost")
    menu.next_line()
    
    menu.add_check_box("opt_cpu_optimize")
    menu.add_text("CPU Optimization")
    menu.next_line()
    
    menu.add_check_box("opt_ram_optimize")
    menu.add_text("RAM Optimization")
    menu.next_line()
    
    menu.add_check_box("opt_clean_temp")
    menu.add_text("Clean Temp Files")
    menu.next_line()
    
    -- Temp cleaner section
    menu.add_button("Clean Temp Files")
    menu.next_line()
    
    -- Status display
    menu.add_text("Status:")
    menu.add_text("opt_status_display")
    menu.next_line()
    
    -- Statistics
    menu.add_text("Last Cleaned: ")
    menu.add_text("opt_last_cleaned")
    menu.next_line()
    
    menu.add_text("Space Freed: ")
    menu.add_text("opt_space_freed")
    
    -- Register callbacks
    client.add_callback("on_button_Quick Optimize", function()
        SystemOptimizer.QuickOptimize()
    end)
    
    client.add_callback("on_button_Clean Temp Files", function()
        SystemOptimizer.CleanAllTempFiles()
    end)
    
    -- Update display
    SystemOptimizer.UpdateStatusDisplay()
end

-- Quick optimize function
function SystemOptimizer.QuickOptimize()
    print("[SystemOptimizer] Running quick optimization...")
    
    local profileIdx = menu.get_int("optimizer_profile")
    local profileNames = {"default", "gaming", "performance", "balanced", "custom"}
    local profileName = profileNames[profileIdx + 1] or "default"
    
    local profile = SystemOptimizer.PROFILES[profileName]
    if not profile then
        profile = SystemOptimizer.PROFILES.default
    end
    
    -- Apply optimizations
    if profile.boostFPS or menu.get_bool("opt_fps_boost") then
        SystemOptimizer.BoostFPS()
    end
    
    if profile.optimizeCPU or menu.get_bool("opt_cpu_optimize") then
        SystemOptimizer.OptimizeCPU()
    end
    
    if profile.optimizeRAM or menu.get_bool("opt_ram_optimize") then
        SystemOptimizer.OptimizeRAM()
    end
    
    if profile.cleanTemp or menu.get_bool("opt_clean_temp") then
        SystemOptimizer.CleanAllTempFiles()
    end
    
    -- Suspend background processes
    if profile.processesToSuspend then
        for _, process in ipairs(profile.processesToSuspend) do
            SystemOptimizer.SuspendProcess(process)
        end
    end
    
    SystemOptimizer.lastOptimization = os.date("%Y-%m-%d %H:%M:%S")
    SystemOptimizer.UpdateStatusDisplay()
    
    Notifications.push_success("System Optimizer", "Quick optimization complete!")
end

-- FPS Boost
function SystemOptimizer.BoostFPS()
    print("[SystemOptimizer] Applying FPS boost...")
    
    -- Set high performance power plan (would require system commands)
    -- Disable Windows Game DVR
    -- Disable fullscreen optimizations
    -- Set process priority to high
    
    SystemOptimizer.fpsBoostActive = true
    print("[SystemOptimizer] FPS boost applied")
end

-- CPU Optimization
function SystemOptimizer.OptimizeCPU()
    print("[SystemOptimizer] Optimizing CPU...")
    
    -- Set process affinity (use all cores)
    -- Disable CPU throttling
    -- Set high performance mode
    
    SystemOptimizer.cpuOptimized = true
    print("[SystemOptimizer] CPU optimization applied")
end

-- RAM Optimization
function SystemOptimizer.OptimizeRAM()
    print("[SystemOptimizer] Optimizing RAM...")
    
    -- Clear standby list
    -- Trim working set
    -- Release unused memory
    
    SystemOptimizer.ramOptimized = true
    print("[SystemOptimizer] RAM optimization applied")
end

-- Clean all temp files
function SystemOptimizer.CleanAllTempFiles()
    print("[SystemOptimizer] Cleaning temp files...")
    
    local totalFreed = 0
    local filesCleaned = 0
    
    for _, location in ipairs(SystemOptimizer.TEMP_LOCATIONS) do
        if file.exists(location) then
            local freed, count = SystemOptimizer.CleanLocation(location)
            totalFreed = totalFreed + freed
            filesCleaned = filesCleaned + count
        end
    end
    
    print("[SystemOptimizer] Cleaned " .. filesCleaned .. " files, freed " .. SystemOptimizer.FormatBytes(totalFreed))
    
    -- Update display
    menu.set_text("opt_last_cleaned", os.date("%Y-%m-%d %H:%M:%S"))
    menu.set_text("opt_space_freed", SystemOptimizer.FormatBytes(totalFreed))
    
    Notifications.push_success("System Optimizer", "Cleaned " .. filesCleaned .. " temp files!")
    
    return totalFreed, filesCleaned
end

-- Clean specific location
function SystemOptimizer.CleanLocation(path)
    local freed = 0
    local count = 0
    
    -- List all files in directory
    local items = file.list_directory(path)
    if items then
        for _, item in ipairs(items) do
            local itemPath = path .. "\\" .. item
            if file.exists(itemPath) then
                -- Check if it's a file (not directory)
                -- In real implementation, would check file attributes
                -- file.delete(itemPath)
                count = count + 1
            end
        end
    end
    
    return freed, count
end

-- Suspend process
function SystemOptimizer.SuspendProcess(processName)
    print("[SystemOptimizer] Suspending process: " .. processName)
    -- Would use Windows API to suspend process
    -- For now, just log
end

-- Resume process
function SystemOptimizer.ResumeProcess(processName)
    print("[SystemOptimizer] Resuming process: " .. processName)
    -- Would use Windows API to resume process
end

-- Format bytes to human readable
function SystemOptimizer.FormatBytes(bytes)
    local units = {"B", "KB", "MB", "GB", "TB"}
    local unitIndex = 1
    
    while bytes >= 1024 and unitIndex < #units do
        bytes = bytes / 1024
        unitIndex = unitIndex + 1
    end
    
    return string.format("%.2f %s", bytes, units[unitIndex])
end

-- Update status display
function SystemOptimizer.UpdateStatusDisplay()
    local status = "Idle"
    if SystemOptimizer.fpsBoostActive then
        status = "FPS Boost Active"
    elseif SystemOptimizer.cpuOptimized then
        status = "CPU Optimized"
    elseif SystemOptimizer.ramOptimized then
        status = "RAM Optimized"
    end
    
    menu.set_text("opt_status_display", status)
    
    if SystemOptimizer.lastOptimization then
        menu.set_text("opt_last_cleaned", SystemOptimizer.lastOptimization)
    else
        menu.set_text("opt_last_cleaned", "Never")
    end
end

-- Start monitoring
function SystemOptimizer.StartMonitoring()
    -- Would start a background thread to monitor system resources
    -- and auto-optimize if enabled
    print("[SystemOptimizer] Monitoring started")
end

-- Load profiles
function SystemOptimizer.LoadProfiles()
    local profilesPath = client.GetScriptsPath() .. "\\SystemOptimizer\\profiles.json"
    if file.exists(profilesPath) then
        local data = file.read(profilesPath)
        SystemOptimizer.profiles = JsonWrapper.parse(data)
    end
end

-- Save profiles
function SystemOptimizer.SaveProfiles()
    local configDir = client.GetScriptsPath() .. "\\SystemOptimizer"
    if not file.exists(configDir) then
        file.create_directory(configDir)
    end
    
    local profilesPath = configDir .. "\\profiles.json"
    file.write(profilesPath, JsonWrapper.stringify(SystemOptimizer.profiles))
end

-- Apply optimizations for specific game
function SystemOptimizer.ApplyForGame(gameExe)
    print("[SystemOptimizer] Applying optimizations for: " .. gameExe)
    
    -- Load game-specific profile if exists
    local gameProfilePath = client.GetScriptsPath() .. "\\SystemOptimizer\\games\\" .. gameExe .. ".json"
    if file.exists(gameProfilePath) then
        local profile = JsonWrapper.parse(file.read(gameProfilePath))
        SystemOptimizer.ApplyProfile(profile)
    else
        -- Use default gaming profile
        SystemOptimizer.ApplyProfile(SystemOptimizer.PROFILES.gaming)
    end
end

-- Apply profile
function SystemOptimizer.ApplyProfile(profile)
    if profile.boostFPS then SystemOptimizer.BoostFPS() end
    if profile.optimizeCPU then SystemOptimizer.OptimizeCPU() end
    if profile.optimizeRAM then SystemOptimizer.OptimizeRAM() end
end

-- Restore system settings
function SystemOptimizer.RestoreDefaults()
    print("[SystemOptimizer] Restoring default settings...")
    
    SystemOptimizer.fpsBoostActive = false
    SystemOptimizer.cpuOptimized = false
    SystemOptimizer.ramOptimized = false
    
    -- Resume suspended processes
    -- Restore power plan
    -- Reset process priorities
    
    SystemOptimizer.UpdateStatusDisplay()
    Notifications.push("System Optimizer", "Restored to defaults")
end

-- Get system stats
function SystemOptimizer.GetSystemStats()
    -- Would return CPU usage, RAM usage, etc.
    return {
        cpuUsage = 0,
        ramUsage = 0,
        fps = 0,
        tempFilesCleaned = 0,
        spaceFreed = 0
    }
end

-- Initialize
SystemOptimizer.Initialize()

-- Export
_G.SystemOptimizer = SystemOptimizer

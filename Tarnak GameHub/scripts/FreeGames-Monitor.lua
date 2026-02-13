--[[
    FreeGames-Monitor.lua
    Steam + Epic free games monitor for Tarnak Game Hub
    Version: 2.0.0
--]]

local VERSION = "2.0.0"
local FreeGamesMonitor = {
    steamGames = {},
    epicGames = {},
    allGames = {},
    lastUpdate = nil,
    autoRefreshEnabled = true,
    refreshInterval = 60, -- minutes
    notificationsEnabled = true,
    steamApiKey = "",
    steamUserId = ""
}

-- API Endpoints
FreeGamesMonitor.API_ENDPOINTS = {
    steam = "https://store.steampowered.com/api/featuredcategories",
    epic = "https://store-site-backend-static.ak.epicgames.com/freeGamesPromotions",
    steamStore = "https://store.steampowered.com/app/"
}

-- Initialize monitor
function FreeGamesMonitor.Initialize()
    print("[FreeGamesMonitor] Initializing v" .. VERSION)
    
    -- Load saved data
    FreeGamesMonitor.LoadData()
    
    -- Create menu UI
    FreeGamesMonitor.CreateMenu()
    
    -- Start auto-refresh
    if FreeGamesMonitor.autoRefreshEnabled then
        FreeGamesMonitor.StartAutoRefresh()
    end
    
    print("[FreeGamesMonitor] Ready!")
    
    -- Do initial fetch
    FreeGamesMonitor.FetchAll()
end

-- Create menu interface
function FreeGamesMonitor.CreateMenu()
    -- Main section
    menu.add_text("Free Games Monitor")
    menu.add_text("Steam + Epic Games")
    menu.next_line()
    
    -- Refresh button
    menu.add_button("Refresh Now")
    menu.next_line()
    
    -- Auto-refresh toggle
    menu.add_check_box("freegames_autorefresh")
    menu.add_text("Auto-refresh every hour")
    menu.next_line()
    
    -- Notifications toggle
    menu.add_check_box("freegames_notifications")
    menu.add_text("Notify about new free games")
    menu.next_line()
    
    -- Filter options
    menu.add_text("Filter by Store:")
    menu.add_combo_box("freegames_filter", {"All", "Steam Only", "Epic Only"})
    menu.next_line()
    
    -- Show games button
    menu.add_button("Show Free Games")
    menu.next_line()
    
    -- Settings section
    menu.add_text("Steam Integration (Optional):")
    menu.add_input_text("steam_api_key")
    menu.add_text("API Key")
    menu.next_line()
    
    menu.add_input_text("steam_user_id")
    menu.add_text("Steam User ID")
    menu.next_line()
    
    menu.add_button("Save Steam Settings")
    menu.next_line()
    
    -- Statistics
    menu.add_text("Last Updated: ")
    menu.add_text("freegames_last_update")
    menu.next_line()
    
    menu.add_text("Total Free Games: ")
    menu.add_text("freegames_total_count")
    
    -- Register callbacks
    client.add_callback("on_button_Refresh Now", function()
        FreeGamesMonitor.FetchAll()
    end)
    
    client.add_callback("on_button_Show Free Games", function()
        FreeGamesMonitor.ShowGamesWindow()
    end)
    
    client.add_callback("on_button_Save Steam Settings", function()
        FreeGamesMonitor.SaveSteamSettings()
    end)
    
    -- Update display
    FreeGamesMonitor.UpdateDisplay()
end

-- Fetch all free games
function FreeGamesMonitor.FetchAll()
    print("[FreeGamesMonitor] Fetching free games...")
    Notifications.push("Free Games", "Fetching latest free games...")
    
    -- Fetch Steam
    FreeGamesMonitor.FetchSteamGames()
    
    -- Fetch Epic
    FreeGamesMonitor.FetchEpicGames()
    
    -- Combine lists
    FreeGamesMonitor.CombineGames()
    
    -- Update timestamp
    FreeGamesMonitor.lastUpdate = os.date("%Y-%m-%d %H:%M:%S")
    FreeGamesMonitor.SaveData()
    FreeGamesMonitor.UpdateDisplay()
    
    print("[FreeGamesMonitor] Found " .. #FreeGamesMonitor.allGames .. " free games")
    Notifications.push_success("Free Games", "Found " .. #FreeGamesMonitor.allGames .. " free games!")
    
    -- Check for new games
    FreeGamesMonitor.CheckForNewGames()
end

-- Fetch Steam free games
function FreeGamesMonitor.FetchSteamGames()
    print("[FreeGamesMonitor] Fetching Steam free games...")
    
    local headers = {
        ["User-Agent"] = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36"
    }
    
    local response = http.get(FreeGamesMonitor.API_ENDPOINTS.steam, headers)
    if response then
        local data = JsonWrapper.parse(response)
        FreeGamesMonitor.ParseSteamData(data)
    else
        print("[FreeGamesMonitor] Failed to fetch Steam games")
    end
end

-- Parse Steam data
function FreeGamesMonitor.ParseSteamData(data)
    FreeGamesMonitor.steamGames = {}
    
    if data and data.specials and data.specials.items then
        for _, item in ipairs(data.specials.items) do
            -- Check if it's free (100% discount)
            if item.discount_percent == 100 then
                table.insert(FreeGamesMonitor.steamGames, {
                    title = item.name,
                    description = item.name,
                    store = "Steam",
                    storeUrl = FreeGamesMonitor.API_ENDPOINTS.steamStore .. item.id,
                    imageUrl = item.large_capsule_image or item.small_capsule_image,
                    startDate = os.date("%Y-%m-%d"),
                    endDate = "Unknown",
                    originalPrice = item.original_price and (item.original_price / 100) or "Free",
                    discountPercent = "100%",
                    appId = tostring(item.id)
                })
            end
        end
    end
    
    print("[FreeGamesMonitor] Found " .. #FreeGamesMonitor.steamGames .. " Steam free games")
end

-- Fetch Epic free games
function FreeGamesMonitor.FetchEpicGames()
    print("[FreeGamesMonitor] Fetching Epic free games...")
    
    local headers = {
        ["User-Agent"] = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36"
    }
    
    local response = http.get(FreeGamesMonitor.API_ENDPOINTS.epic, headers)
    if response then
        local data = JsonWrapper.parse(response)
        FreeGamesMonitor.ParseEpicData(data)
    else
        print("[FreeGamesMonitor] Failed to fetch Epic games")
    end
end

-- Parse Epic data
function FreeGamesMonitor.ParseEpicData(data)
    FreeGamesMonitor.epicGames = {}
    
    if data and data.data and data.data.Catalog and data.data.Catalog.searchStore then
        local elements = data.data.Catalog.searchStore.elements
        if elements then
            for _, item in ipairs(elements) do
                if item.promotions and item.promotions.promotionalOffers then
                    local offers = item.promotions.promotionalOffers
                    if #offers > 0 then
                        local promotional = offers[1].promotionalOffers
                        if promotional and #promotional > 0 then
                            local offer = promotional[1]
                            table.insert(FreeGamesMonitor.epicGames, {
                                title = item.title,
                                description = item.description or item.title,
                                store = "Epic",
                                storeUrl = "https://www.epicgames.com/store/en-US/p/" .. item.productSlug,
                                imageUrl = item.keyImages and item.keyImages[1] and item.keyImages[1].url or "",
                                startDate = offer.startDate or "Unknown",
                                endDate = offer.endDate or "Unknown",
                                originalPrice = item.price and item.price.totalPrice and (item.price.totalPrice.originalPrice / 100) or "Free",
                                discountPercent = "100%",
                                appId = item.id
                            })
                        end
                    end
                end
            end
        end
    end
    
    print("[FreeGamesMonitor] Found " .. #FreeGamesMonitor.epicGames .. " Epic free games")
end

-- Combine games lists
function FreeGamesMonitor.CombineGames()
    FreeGamesMonitor.allGames = {}
    
    for _, game in ipairs(FreeGamesMonitor.steamGames) do
        table.insert(FreeGamesMonitor.allGames, game)
    end
    
    for _, game in ipairs(FreeGamesMonitor.epicGames) do
        table.insert(FreeGamesMonitor.allGames, game)
    end
    
    -- Sort by end date (ending soon first)
    table.sort(FreeGamesMonitor.allGames, function(a, b)
        return a.endDate < b.endDate
    end)
end

-- Show games window
function FreeGamesMonitor.ShowGamesWindow()
    print("[FreeGamesMonitor] Showing games window...")
    
    -- Would open a detailed window showing all free games
    -- For now, show in notification
    local filterIdx = menu.get_int("freegames_filter")
    local stores = {"All", "Steam", "Epic"}
    local filter = stores[filterIdx + 1] or "All"
    
    local count = 0
    for _, game in ipairs(FreeGamesMonitor.allGames) do
        if filter == "All" or game.store == filter then
            count = count + 1
        end
    end
    
    Notifications.push("Free Games", filter .. ": " .. count .. " games available!")
end

-- Check for new games
function FreeGamesMonitor.CheckForNewGames()
    if not FreeGamesMonitor.notificationsEnabled then return end
    
    local newGames = {}
    -- Compare with previous list to find new additions
    -- For now, just notify about games ending soon
    
    for _, game in ipairs(FreeGamesMonitor.allGames) do
        if FreeGamesMonitor.IsEndingSoon(game.endDate) then
            table.insert(newGames, game)
        end
    end
    
    if #newGames > 0 then
        Notifications.push_warning("Free Games", #newGames .. " games ending soon!")
    end
end

-- Check if game is ending soon
function FreeGamesMonitor.IsEndingSoon(endDate)
    if endDate == "Unknown" then return false end
    
    -- Parse end date
    local year, month, day = endDate:match("(%d+)-(%d+)-(%d+)")
    if year then
        local endTime = os.time({year = year, month = month, day = day})
        local now = os.time()
        local hoursRemaining = (endTime - now) / 3600
        
        return hoursRemaining > 0 and hoursRemaining < 24
    end
    
    return false
end

-- Update display
function FreeGamesMonitor.UpdateDisplay()
    if FreeGamesMonitor.lastUpdate then
        menu.set_text("freegames_last_update", FreeGamesMonitor.lastUpdate)
    else
        menu.set_text("freegames_last_update", "Never")
    end
    
    menu.set_text("freegames_total_count", tostring(#FreeGamesMonitor.allGames))
    menu.set_bool("freegames_autorefresh", FreeGamesMonitor.autoRefreshEnabled)
    menu.set_bool("freegames_notifications", FreeGamesMonitor.notificationsEnabled)
end

-- Start auto-refresh
function FreeGamesMonitor.StartAutoRefresh()
    print("[FreeGamesMonitor] Starting auto-refresh...")
    -- Would start a background timer
end

-- Save data
function FreeGamesMonitor.SaveData()
    local configDir = client.GetScriptsPath() .. "\\FreeGamesMonitor"
    if not file.exists(configDir) then
        file.create_directory(configDir)
    end
    
    local data = {
        steamGames = FreeGamesMonitor.steamGames,
        epicGames = FreeGamesMonitor.epicGames,
        lastUpdate = FreeGamesMonitor.lastUpdate,
        autoRefreshEnabled = FreeGamesMonitor.autoRefreshEnabled,
        notificationsEnabled = FreeGamesMonitor.notificationsEnabled,
        steamApiKey = FreeGamesMonitor.steamApiKey,
        steamUserId = FreeGamesMonitor.steamUserId
    }
    
    file.write(configDir .. "\\data.json", JsonWrapper.stringify(data))
end

-- Load data
function FreeGamesMonitor.LoadData()
    local dataPath = client.GetScriptsPath() .. "\\FreeGamesMonitor\\data.json"
    if file.exists(dataPath) then
        local data = JsonWrapper.parse(file.read(dataPath))
        FreeGamesMonitor.steamGames = data.steamGames or {}
        FreeGamesMonitor.epicGames = data.epicGames or {}
        FreeGamesMonitor.lastUpdate = data.lastUpdate
        FreeGamesMonitor.autoRefreshEnabled = data.autoRefreshEnabled ~= false
        FreeGamesMonitor.notificationsEnabled = data.notificationsEnabled ~= false
        FreeGamesMonitor.steamApiKey = data.steamApiKey or ""
        FreeGamesMonitor.steamUserId = data.steamUserId or ""
    end
end

-- Save Steam settings
function FreeGamesMonitor.SaveSteamSettings()
    FreeGamesMonitor.steamApiKey = menu.get_text("steam_api_key")
    FreeGamesMonitor.steamUserId = menu.get_text("steam_user_id")
    FreeGamesMonitor.SaveData()
    Notifications.push_success("Free Games", "Steam settings saved!")
end

-- Get owned games from Steam
function FreeGamesMonitor.FetchOwnedGames()
    if FreeGamesMonitor.steamApiKey == "" or FreeGamesMonitor.steamUserId == "" then
        print("[FreeGamesMonitor] Steam API key or User ID not set")
        return
    end
    
    local url = "https://api.steampowered.com/IPlayerService/GetOwnedGames/v1/?key=" .. 
                FreeGamesMonitor.steamApiKey .. "&steamid=" .. FreeGamesMonitor.steamUserId .. "&include_appinfo=1"
    
    local response = http.get(url, {})
    if response then
        local data = JsonWrapper.parse(response)
        -- Parse owned games
        print("[FreeGamesMonitor] Fetched owned games from Steam")
    end
end

-- Filter owned games
function FreeGamesMonitor.FilterOwnedGames()
    local unowned = {}
    for _, game in ipairs(FreeGamesMonitor.allGames) do
        if not FreeGamesMonitor.IsGameOwned(game.appId) then
            table.insert(unowned, game)
        end
    end
    return unowned
end

-- Check if game is owned
function FreeGamesMonitor.IsGameOwned(appId)
    -- Would check against owned games list
    return false
end

-- Get games by store
function FreeGamesMonitor.GetGamesByStore(store)
    local games = {}
    for _, game in ipairs(FreeGamesMonitor.allGames) do
        if game.store == store then
            table.insert(games, game)
        end
    end
    return games
end

-- Search games
function FreeGamesMonitor.SearchGames(query)
    local results = {}
    query = query:lower()
    for _, game in ipairs(FreeGamesMonitor.allGames) do
        if game.title:lower():find(query) then
            table.insert(results, game)
        end
    end
    return results
end

-- Initialize
FreeGamesMonitor.Initialize()

-- Export
_G.FreeGamesMonitor = FreeGamesMonitor

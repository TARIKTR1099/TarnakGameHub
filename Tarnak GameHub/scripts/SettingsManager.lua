--[[
    SettingsManager.lua
    Tarnak Game Hub Ayar Yöneticisi
    Version: 1.0.0
--]]

local SettingsManager = {
    settings = {},
    configPath = "",
    defaults = {
        -- Genel Ayarlar
        language = "tr-TR",
        theme = "Default",
        startWithWindows = false,
        minimizeToTray = true,
        
        -- Güncelleme Ayarları
        checkUpdates = true,
        autoDownloadUpdates = false,
        updateChannel = "stable", -- stable, beta, dev
        
        -- Bildirim Ayarları
        showNotifications = true,
        notificationDuration = 5,
        soundEnabled = true,
        
        -- Performans Ayarları
        hardwareAcceleration = true,
        maxConcurrentDownloads = 3,
        cacheSize = 100, -- MB
        
        -- Otomatik Başlatma
        autoOptimizeOnGameStart = true,
        autoApplyKeyBindings = true,
        autoLaunchPrograms = true,
        
        -- Overlay Ayarları
        overlayEnabled = true,
        overlayOpacity = 0.9,
        overlayHotkey = "CTRL+ALT+O",
        
        -- Chat Ayarları
        chatEnabled = true,
        chatHotkey = "CTRL+SHIFT+T",
        chatOpacity = 0.85,
        
        -- Gizlilik
        analyticsEnabled = false,
        crashReporting = true,
        
        -- Gelişmiş
        debugMode = false,
        logLevel = "INFO",
        developerMode = false
    }
}

-- Ayarları yükle
function SettingsManager.Load()
    SettingsManager.configPath = client.GetScriptsPath() .. "\\Settings\\config.json"
    
    if file.exists(SettingsManager.configPath) then
        local content = file.read(SettingsManager.configPath)
        local success, loaded = pcall(JsonWrapper.parse, content)
        
        if success then
            -- Varsayılanlarla birleştir
            for key, value in pairs(SettingsManager.defaults) do
                if loaded[key] ~= nil then
                    SettingsManager.settings[key] = loaded[key]
                else
                    SettingsManager.settings[key] = value
                end
            end
            print("[SettingsManager] Ayarlar yüklendi")
        else
            print("[SettingsManager] Ayar dosyası bozuk, varsayılanlar kullanılıyor")
            SettingsManager.settings = SettingsManager.defaults
            SettingsManager.Save()
        end
    else
        print("[SettingsManager] Ayar dosyası bulunamadı, varsayılanlar oluşturuluyor")
        SettingsManager.settings = SettingsManager.defaults
        SettingsManager.Save()
    end
end

-- Ayarları kaydet
function SettingsManager.Save()
    local configDir = client.GetScriptsPath() .. "\\Settings"
    if not file.exists(configDir) then
        file.create_directory(configDir)
    end
    
    local success = file.write(SettingsManager.configPath, JsonWrapper.stringify(SettingsManager.settings))
    if success then
        print("[SettingsManager] Ayarlar kaydedildi")
    else
        print("[SettingsManager] Ayarlar kaydedilemedi!")
    end
end

-- Ayar getir
function SettingsManager.Get(key)
    return SettingsManager.settings[key]
end

-- Ayar ayarla
function SettingsManager.Set(key, value)
    local oldValue = SettingsManager.settings[key]
    SettingsManager.settings[key] = value
    
    -- Değişiklik callback'i çağır
    if oldValue ~= value then
        SettingsManager.OnSettingChanged(key, value, oldValue)
    end
    
    -- Otomatik kaydet
    SettingsManager.Save()
end

-- Varsayılanlara sıfırla
function SettingsManager.ResetToDefaults()
    SettingsManager.settings = {}
    for key, value in pairs(SettingsManager.defaults) do
        SettingsManager.settings[key] = value
    end
    SettingsManager.Save()
    print("[SettingsManager] Varsayılan ayarlara sıfırlandı")
end

-- Ayar değişikliği olayı
function SettingsManager.OnSettingChanged(key, newValue, oldValue)
    print(string.format("[SettingsManager] Ayar değişti: %s = %s (önceki: %s)", 
        tostring(key), tostring(newValue), tostring(oldValue)))
    
    -- Dil değişikliği
    if key == "language" then
        Notifications.push("Ayarlar", "Dil değişti: " .. newValue)
    end
    
    -- Tema değişikliği
    if key == "theme" then
        Notifications.push("Ayarlar", "Tema değişti: " .. newValue)
    end
    
    -- Bildirim değişikliği
    if key == "showNotifications" and not newValue then
        print("[SettingsManager] Bildirimler devre dışı")
    end
end

-- Tüm ayarları dışa aktar
function SettingsManager.Export()
    local exportPath = client.GetScriptsPath() .. "\\Settings\\backup.json"
    file.write(exportPath, JsonWrapper.stringify(SettingsManager.settings))
    return exportPath
end

-- Ayarları içe aktar
function SettingsManager.Import(importPath)
    if not file.exists(importPath) then
        return false
    end
    
    local content = file.read(importPath)
    local success, imported = pcall(JsonWrapper.parse, content)
    
    if success then
        SettingsManager.settings = imported
        SettingsManager.Save()
        return true
    end
    
    return false
end

-- Gelişmiş ayarlar menüsü
function SettingsManager.CreateAdvancedMenu()
    menu.add_text("Gelişmiş Ayarlar")
    menu.next_line()
    
    -- Debug modu
    menu.add_check_box("setting_debug_mode")
    menu.add_text("Debug Modu")
    menu.next_line()
    
    -- Log seviyesi
    menu.add_text("Log Seviyesi:")
    menu.add_combo_box("setting_log_level", {"DEBUG", "INFO", "WARNING", "ERROR"})
    menu.next_line()
    
    -- Geliştirici modu
    menu.add_check_box("setting_dev_mode")
    menu.add_text("Geliştirici Modu")
    menu.next_line()
    
    -- Ayarları yönet
    menu.add_button("Ayarları Yedekle")
    menu.add_button("Ayarları Geri Yükle")
    menu.add_button("Varsayılanlara Sıfırla")
    
    -- Callback'ler
    client.add_callback("on_button_Ayarları Yedekle", function()
        local path = SettingsManager.Export()
        Notifications.push_success("Ayarlar", "Yedekleme oluşturuldu: " .. path)
    end)
    
    client.add_callback("on_button_Varsayılanlara Sıfırla", function()
        SettingsManager.ResetToDefaults()
        Notifications.push_success("Ayarlar", "Varsayılan ayarlara sıfırlandı")
    end)
end

-- Başlat
function SettingsManager.Initialize()
    SettingsManager.Load()
    SettingsManager.CreateAdvancedMenu()
    print("[SettingsManager] Başlatıldı")
end

-- Başlat
SettingsManager.Initialize()

-- Export
_G.SettingsManager = SettingsManager

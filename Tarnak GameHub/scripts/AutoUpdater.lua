--[[
    AutoUpdater.lua
    Otomatik Güncelleme Sistemi
    Version: 1.0.0
--]]

local AutoUpdater = {
    version = "1.0.0",
    repoOwner = "TARIKTR1099",
    repoName = "TarnakGameHub",
    checkInterval = 86400, -- 24 saat (saniye)
    lastCheck = 0,
    updateAvailable = false,
    latestVersion = nil,
    downloadUrl = nil,
    changelog = nil
}

-- GitHub API'den son sürümü kontrol et
function AutoUpdater.CheckForUpdates(force)
    local currentTime = os.time()
    
    -- Zorla kontrol et veya süre dolmuşsa kontrol et
    if not force and (currentTime - AutoUpdater.lastCheck) < AutoUpdater.checkInterval then
        return false
    end
    
    print("[AutoUpdater] Güncellemeler kontrol ediliyor...")
    
    -- GitHub API URL
    local apiUrl = string.format(
        "https://api.github.com/repos/%s/%s/releases/latest",
        AutoUpdater.repoOwner,
        AutoUpdater.repoName
    )
    
    -- HTTP isteği yap
    local headers = {
        ["User-Agent"] = "TarnakGameHub/" .. AutoUpdater.version,
        ["Accept"] = "application/vnd.github.v3+json"
    }
    
    local response = http.get(apiUrl, headers)
    
    if not response then
        print("[AutoUpdater] Güncelleme kontrolü başarısız: İnternet bağlantısı yok")
        return false
    end
    
    -- JSON parse et
    local success, data = pcall(JsonWrapper.parse, response)
    if not success then
        print("[AutoUpdater] JSON parse hatası")
        return false
    end
    
    -- Versiyon kontrolü
    if data and data.tag_name then
        local latestVersion = data.tag_name:gsub("v", "")
        AutoUpdater.latestVersion = latestVersion
        AutoUpdater.lastCheck = currentTime
        
        -- Versiyon karşılaştırma
        if AutoUpdater.CompareVersions(latestVersion, AutoUpdater.version) > 0 then
            AutoUpdater.updateAvailable = true
            AutoUpdater.downloadUrl = data.html_url
            AutoUpdater.changelog = data.body or "Yenilikler hakkında bilgi yok"
            
            print("[AutoUpdater] Yeni sürüm mevcut: " .. latestVersion)
            
            -- Kullanıcıya bildir
            AutoUpdater.NotifyUpdate()
            
            return true
        else
            print("[AutoUpdater] En son sürümü kullanıyorsunuz: " .. AutoUpdater.version)
            AutoUpdater.updateAvailable = false
        end
    end
    
    return false
end

-- Versiyon karşılaştırma (1: v1 > v2, -1: v1 < v2, 0: eşit)
function AutoUpdater.CompareVersions(v1, v2)
    local function splitVersion(v)
        local parts = {}
        for part in v:gmatch("%d+") do
            table.insert(parts, tonumber(part))
        end
        return parts
    end
    
    local parts1 = splitVersion(v1)
    local parts2 = splitVersion(v2)
    
    for i = 1, math.max(#parts1, #parts2) do
        local num1 = parts1[i] or 0
        local num2 = parts2[i] or 0
        
        if num1 > num2 then return 1 end
        if num1 < num2 then return -1 end
    end
    
    return 0
end

-- Güncelleme bildirimi
function AutoUpdater.NotifyUpdate()
    if not AutoUpdater.updateAvailable then return end
    
    local message = string.format(
        "Yeni sürüm mevcut!\n" ..
        "Mevcut: %s\n" ..
        "Yeni: %s\n\n" ..
        "Şimdi indirmek ister misiniz?",
        AutoUpdater.version,
        AutoUpdater.latestVersion
    )
    
    -- Bildirim göster
    Notifications.push_warning(
        "Güncelleme Mevcut",
        "Tarnak Game Hub v" .. AutoUpdater.latestVersion .. " indirilebilir!"
    )
    
    -- Menüye bildirim ekle
    menu.set_text("update_status", "Yeni sürüm: v" .. AutoUpdater.latestVersion)
    menu.set_bool("update_available", true)
end

-- Güncellemeyi indir ve kur
function AutoUpdater.DownloadAndInstall()
    if not AutoUpdater.updateAvailable then
        Notifications.push("Güncelleme", "Güncelleme mevcut değil")
        return false
    end
    
    -- GitHub release sayfasını aç
    if AutoUpdater.downloadUrl then
        exec("cmd", 0, "/c start " .. AutoUpdater.downloadUrl)
        Notifications.push_success(
            "Güncelleme", 
            "İndirme sayfası açıldı. Lütfen yeni sürümü indirip kurun."
        )
        return true
    end
    
    return false
end

-- Ayarlardan güncelleme kontrolü
function AutoUpdater.ShouldCheckUpdates()
    local settings = AutoUpdater.LoadSettings()
    return settings.checkUpdates ~= false
end

-- Ayarları yükle
function AutoUpdater.LoadSettings()
    local configPath = client.GetScriptsPath() .. "\\AutoUpdater\\settings.json"
    if file.exists(configPath) then
        local content = file.read(configPath)
        return JsonWrapper.parse(content)
    end
    return {
        checkUpdates = true,
        autoDownload = false,
        checkInterval = 86400
    }
end

-- Ayarları kaydet
function AutoUpdater.SaveSettings(settings)
    local configDir = client.GetScriptsPath() .. "\\AutoUpdater"
    if not file.exists(configDir) then
        file.create_directory(configDir)
    end
    
    local configPath = configDir .. "\\settings.json"
    file.write(configPath, JsonWrapper.stringify(settings))
end

-- Menü oluştur
function AutoUpdater.CreateMenu()
    menu.add_text("Güncelleme Ayarları")
    menu.next_line()
    
    -- Otomatik kontrol
    menu.add_check_box("auto_check_updates")
    menu.add_text("Güncellemeleri otomatik kontrol et")
    menu.next_line()
    
    -- Kontrol sıklığı
    menu.add_text("Kontrol sıklığı:")
    menu.add_combo_box("update_interval", {"Her açılışta", "Günde bir", "Haftada bir", "Asla"})
    menu.next_line()
    
    -- Durum göster
    menu.add_text("Durum:")
    menu.add_text("update_status")
    menu.next_line()
    
    -- Butonlar
    menu.add_button("Şimdi Kontrol Et")
    menu.add_button("Güncellemeyi İndir")
    menu.next_line()
    
    -- Mevcut versiyon
    menu.add_text("Mevcut sürüm: v" .. AutoUpdater.version)
    
    -- Callback'ler
    client.add_callback("on_button_Şimdi Kontrol Et", function()
        AutoUpdater.CheckForUpdates(true)
    end)
    
    client.add_callback("on_button_Güncellemeyi İndir", function()
        AutoUpdater.DownloadAndInstall()
    end)
    
    -- Varsayılan değerleri ayarla
    local settings = AutoUpdater.LoadSettings()
    menu.set_bool("auto_check_updates", settings.checkUpdates)
    menu.set_text("update_status", "Son kontrol: " .. os.date("%Y-%m-%d %H:%M", AutoUpdater.lastCheck))
end

-- Başlangıçta çalıştır
function AutoUpdater.Initialize()
    print("[AutoUpdater] v" .. AutoUpdater.version .. " başlatıldı")
    
    -- Menü oluştur
    AutoUpdater.CreateMenu()
    
    -- Otomatik kontrol
    if AutoUpdater.ShouldCheckUpdates() then
        -- 10 saniye bekle ve kontrol et (başlangıçta hemen kontrol etme)
        client.SetTimeout(function()
            AutoUpdater.CheckForUpdates()
        end, 10000)
    end
end

-- Başlat
AutoUpdater.Initialize()

-- Export
_G.AutoUpdater = AutoUpdater

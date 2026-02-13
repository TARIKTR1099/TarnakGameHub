--[[
    Translation-Helper.lua
    Multi-engine translation system for Tarnak Game Hub
    Version: 2.0.0
--]]

local VERSION = "2.0.0"
local TranslationHelper = {
    config = {
        engine = "google",
        sourceLang = "auto",
        targetLang = "tr",
        showInOverlay = true,
        contextMenuEnabled = true
    },
    history = {},
    cache = {},
    engines = {}
}

-- Translation engines
TranslationHelper.ENGINES = {
    google = {
        name = "Google Translate",
        enabled = true,
        url = "https://translate.googleapis.com/translate_a/single",
        supports = {"tr", "en", "de", "fr", "es", "it", "ru", "ja", "ko", "zh", "ar", "pl", "nl", "pt", "sv", "da", "fi", "no", "cs", "hu", "ro", "sk", "uk", "vi", "th", "id", "ms", "hi", "bn", "ta", "te", "ur", "fa", "he", "el", "bg", "sr", "hr", "sl", "et", "lv", "lt", "mk", "sq", "hy", "ka", "az", "uz", "kk", "ky", "mn", "ne", "si", "my", "km", "lo", "jw", "su", "tl", "ceb", "ha", "yo", "ig", "zu", "sw", "am", "so", "mg", "ny", "sn", "st", "xh"}
    },
    deepl = {
        name = "DeepL",
        enabled = false,
        apiKey = "",
        url = "https://api-free.deepl.com/v2/translate",
        supports = {"tr", "en", "de", "fr", "es", "it", "nl", "pl", "pt", "ru", "ja", "zh", "bg", "cs", "da", "el", "et", "fi", "hu", "id", "ko", "lv", "lt", "ro", "sk", "sl", "sv", "uk"}
    },
    microsoft = {
        name = "Microsoft Translator",
        enabled = false,
        apiKey = "",
        url = "https://api.cognitive.microsofttranslator.com/translate",
        supports = {"tr", "en", "de", "fr", "es", "it", "ru", "ja", "ko", "zh", "ar", "pl", "nl", "pt", "sv", "da", "fi", "no", "cs", "hu", "ro", "sk", "uk", "vi", "th", "id", "ms", "hi"}
    },
    libre = {
        name = "LibreTranslate",
        enabled = false,
        url = "https://libretranslate.de/translate",
        supports = {"tr", "en", "de", "fr", "es", "it", "ru", "ja", "ko", "zh", "ar", "pl", "nl", "pt", "sv"}
    }
}

-- Language codes and names
TranslationHelper.LANGUAGES = {
    {code = "auto", name = "Auto Detect"},
    {code = "tr", name = "Turkish"},
    {code = "en", name = "English"},
    {code = "de", name = "German"},
    {code = "fr", name = "French"},
    {code = "es", name = "Spanish"},
    {code = "it", name = "Italian"},
    {code = "ru", name = "Russian"},
    {code = "ja", name = "Japanese"},
    {code = "ko", name = "Korean"},
    {code = "zh", name = "Chinese"},
    {code = "ar", name = "Arabic"},
    {code = "pl", name = "Polish"},
    {code = "nl", name = "Dutch"},
    {code = "pt", name = "Portuguese"},
    {code = "sv", name = "Swedish"},
    {code = "da", name = "Danish"},
    {code = "fi", name = "Finnish"},
    {code = "no", name = "Norwegian"},
    {code = "cs", name = "Czech"},
    {code = "hu", name = "Hungarian"},
    {code = "ro", name = "Romanian"},
    {code = "el", name = "Greek"},
    {code = "he", name = "Hebrew"},
    {code = "hi", name = "Hindi"},
    {code = "id", name = "Indonesian"},
    {code = "th", name = "Thai"},
    {code = "vi", name = "Vietnamese"}
}

-- Initialize translation helper
function TranslationHelper.Initialize()
    print("[TranslationHelper] Initializing v" .. VERSION)
    
    -- Load configuration
    TranslationHelper.LoadConfig()
    
    -- Create menu UI
    TranslationHelper.CreateMenu()
    
    -- Register context menu
    if TranslationHelper.config.contextMenuEnabled then
        TranslationHelper.RegisterContextMenu()
    end
    
    print("[TranslationHelper] Ready! Languages: " .. #TranslationHelper.LANGUAGES)
end

-- Create menu interface
function TranslationHelper.CreateMenu()
    -- Main section
    menu.add_text("Translation Helper")
    menu.add_text("v" .. VERSION)
    menu.next_line()
    
    -- Translation engine selection
    menu.add_text("Translation Engine:")
    menu.add_combo_box("translation_engine", {"Google Translate", "DeepL", "Microsoft", "LibreTranslate"})
    menu.next_line()
    
    -- Source language
    menu.add_text("Source Language:")
    menu.add_combo_box("translation_source", TranslationHelper.GetLanguageNames())
    menu.next_line()
    
    -- Target language
    menu.add_text("Target Language:")
    menu.add_combo_box("translation_target", TranslationHelper.GetLanguageNames())
    menu.next_line()
    
    -- Quick translate section
    menu.add_text("Quick Translate:")
    menu.add_input_text("translation_input")
    menu.next_line()
    
    menu.add_button("Translate")
    menu.add_button("Clear")
    menu.next_line()
    
    -- Result display
    menu.add_text("Translation:")
    menu.add_text("translation_result")
    menu.next_line()
    
    -- Options
    menu.add_check_box("translation_overlay")
    menu.add_text("Show in overlay")
    menu.next_line()
    
    menu.add_check_box("translation_context_menu")
    menu.add_text("Enable right-click translate")
    menu.next_line()
    
    -- API keys for premium engines
    menu.add_text("API Keys (for premium engines):")
    menu.add_input_text("deepl_api_key")
    menu.add_text("DeepL API Key")
    menu.next_line()
    
    menu.add_input_text("microsoft_api_key")
    menu.add_text("Microsoft API Key")
    menu.next_line()
    
    menu.add_button("Save API Keys")
    menu.next_line()
    
    -- History
    menu.add_button("View History")
    menu.add_button("Clear History")
    
    -- Register callbacks
    client.add_callback("on_button_Translate", function()
        TranslationHelper.QuickTranslate()
    end)
    
    client.add_callback("on_button_Clear", function()
        TranslationHelper.ClearInput()
    end)
    
    client.add_callback("on_button_Save API Keys", function()
        TranslationHelper.SaveApiKeys()
    end)
    
    client.add_callback("on_button_View History", function()
        TranslationHelper.ShowHistory()
    end)
    
    client.add_callback("on_button_Clear History", function()
        TranslationHelper.ClearHistory()
    end)
    
    -- Set default values
    menu.set_int("translation_source", 0) -- Auto Detect
    menu.set_int("translation_target", 2) -- English (default)
end

-- Get language names for dropdown
function TranslationHelper.GetLanguageNames()
    local names = {}
    for _, lang in ipairs(TranslationHelper.LANGUAGES) do
        table.insert(names, lang.name)
    end
    return names
end

-- Get language code from index
function TranslationHelper.GetLanguageCode(index)
    if index >= 0 and index < #TranslationHelper.LANGUAGES then
        return TranslationHelper.LANGUAGES[index + 1].code
    end
    return "en"
end

-- Quick translate
function TranslationHelper.QuickTranslate()
    local text = menu.get_text("translation_input")
    if text == "" then
        Notifications.push_warning("Translation", "Please enter text to translate")
        return
    end
    
    local sourceIdx = menu.get_int("translation_source")
    local targetIdx = menu.get_int("translation_target")
    local sourceLang = TranslationHelper.GetLanguageCode(sourceIdx)
    local targetLang = TranslationHelper.GetLanguageCode(targetIdx)
    
    -- Get selected engine
    local engineIdx = menu.get_int("translation_engine")
    local engines = {"google", "deepl", "microsoft", "libre"}
    local engine = engines[engineIdx + 1] or "google"
    
    print("[TranslationHelper] Translating: '" .. text .. "' from " .. sourceLang .. " to " .. targetLang)
    
    -- Perform translation
    local result = TranslationHelper.Translate(text, sourceLang, targetLang, engine)
    
    if result then
        menu.set_text("translation_result", result)
        
        -- Add to history
        TranslationHelper.AddToHistory(text, result, sourceLang, targetLang, engine)
        
        -- Show notification
        Notifications.push_success("Translation", "Translation complete!")
    else
        menu.set_text("translation_result", "Translation failed")
        Notifications.push_error("Translation", "Failed to translate text")
    end
end

-- Translate function
function TranslationHelper.Translate(text, sourceLang, targetLang, engine)
    -- Check cache first
    local cacheKey = text .. "_" .. sourceLang .. "_" .. targetLang .. "_" .. engine
    if TranslationHelper.cache[cacheKey] then
        print("[TranslationHelper] Using cached translation")
        return TranslationHelper.cache[cacheKey]
    end
    
    -- Call appropriate engine
    if engine == "google" then
        return TranslationHelper.TranslateGoogle(text, sourceLang, targetLang)
    elseif engine == "deepl" then
        return TranslationHelper.TranslateDeepL(text, sourceLang, targetLang)
    elseif engine == "microsoft" then
        return TranslationHelper.TranslateMicrosoft(text, sourceLang, targetLang)
    elseif engine == "libre" then
        return TranslationHelper.TranslateLibre(text, sourceLang, targetLang)
    end
    
    return nil
end

-- Google Translate
function TranslationHelper.TranslateGoogle(text, sourceLang, targetLang)
    local encodedText = TranslationHelper.UrlEncode(text)
    local url = "https://translate.googleapis.com/translate_a/single?client=gtx&sl=" .. 
                sourceLang .. "&tl=" .. targetLang .. "&dt=t&q=" .. encodedText
    
    local headers = {
        ["User-Agent"] = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36"
    }
    
    local response = http.get(url, headers)
    if response then
        -- Parse Google Translate response
        local result = TranslationHelper.ParseGoogleResponse(response)
        return result
    end
    
    return nil
end

-- Parse Google response
function TranslationHelper.ParseGoogleResponse(response)
    -- Google returns a nested array structure
    -- This is a simplified parser
    local result = ""
    
    -- Extract translated text from response
    -- Format: [[["translated","original",...]],...]
    for translated in response:gmatch('%[%[%["([^"]+)"') do
        result = result .. translated
    end
    
    if result == "" then
        -- Try alternative pattern
        for translated in response:gmatch('"([^"]+)","[^"]+","[^"]+"') do
            result = result .. translated
        end
    end
    
    return result ~= "" and result or nil
end

-- DeepL Translate
function TranslationHelper.TranslateDeepL(text, sourceLang, targetLang)
    local apiKey = TranslationHelper.ENGINES.deepl.apiKey
    if apiKey == "" then
        print("[TranslationHelper] DeepL API key not set")
        return nil
    end
    
    local url = "https://api-free.deepl.com/v2/translate"
    local params = "auth_key=" .. apiKey .. "&text=" .. TranslationHelper.UrlEncode(text) .. 
                   "&source_lang=" .. string.upper(sourceLang) .. "&target_lang=" .. string.upper(targetLang)
    
    local headers = {
        ["Content-Type"] = "application/x-www-form-urlencoded"
    }
    
    local response = http.post(url, params, headers)
    if response then
        local data = JsonWrapper.parse(response)
        if data and data.translations and data.translations[1] then
            return data.translations[1].text
        end
    end
    
    return nil
end

-- Microsoft Translate
function TranslationHelper.TranslateMicrosoft(text, sourceLang, targetLang)
    local apiKey = TranslationHelper.ENGINES.microsoft.apiKey
    if apiKey == "" then
        print("[TranslationHelper] Microsoft API key not set")
        return nil
    end
    
    local url = "https://api.cognitive.microsofttranslator.com/translate?api-version=3.0&from=" .. 
                sourceLang .. "&to=" .. targetLang
    
    local body = '[{"Text":"' .. text .. '"}]'
    local headers = {
        ["Ocp-Apim-Subscription-Key"] = apiKey,
        ["Content-Type"] = "application/json"
    }
    
    local response = http.post(url, body, headers)
    if response then
        local data = JsonWrapper.parse(response)
        if data and data[1] and data[1].translations then
            return data[1].translations[1].text
        end
    end
    
    return nil
end

-- LibreTranslate
function TranslationHelper.TranslateLibre(text, sourceLang, targetLang)
    local url = "https://libretranslate.de/translate"
    local params = "q=" .. TranslationHelper.UrlEncode(text) .. "&source=" .. sourceLang .. "&target=" .. targetLang
    
    local headers = {
        ["Content-Type"] = "application/x-www-form-urlencoded"
    }
    
    local response = http.post(url, params, headers)
    if response then
        local data = JsonWrapper.parse(response)
        if data and data.translatedText then
            return data.translatedText
        end
    end
    
    return nil
end

-- URL encode
function TranslationHelper.UrlEncode(str)
    if str then
        str = string.gsub(str, "\n", "\r\n")
        str = string.gsub(str, "([^%w %-%_%.%~])", function(c)
            return string.format("%%%02X", string.byte(c))
        end)
        str = string.gsub(str, " ", "+")
    end
    return str
end

-- Add to history
function TranslationHelper.AddToHistory(original, translated, sourceLang, targetLang, engine)
    table.insert(TranslationHelper.history, 1, {
        original = original,
        translated = translated,
        sourceLang = sourceLang,
        targetLang = targetLang,
        engine = engine,
        timestamp = os.date("%Y-%m-%d %H:%M:%S")
    })
    
    -- Limit history size
    if #TranslationHelper.history > 100 then
        table.remove(TranslationHelper.history)
    end
    
    -- Save to cache
    local cacheKey = original .. "_" .. sourceLang .. "_" .. targetLang .. "_" .. engine
    TranslationHelper.cache[cacheKey] = translated
end

-- Show history
function TranslationHelper.ShowHistory()
    print("[TranslationHelper] Showing history...")
    -- Would open a history window
    Notifications.push("Translation", "History: " .. #TranslationHelper.history .. " entries")
end

-- Clear history
function TranslationHelper.ClearHistory()
    TranslationHelper.history = {}
    TranslationHelper.SaveConfig()
    Notifications.push("Translation", "History cleared")
end

-- Clear input
function TranslationHelper.ClearInput()
    menu.set_text("translation_input", "")
    menu.set_text("translation_result", "")
end

-- Save API keys
function TranslationHelper.SaveApiKeys()
    TranslationHelper.ENGINES.deepl.apiKey = menu.get_text("deepl_api_key")
    TranslationHelper.ENGINES.microsoft.apiKey = menu.get_text("microsoft_api_key")
    TranslationHelper.SaveConfig()
    Notifications.push_success("Translation", "API keys saved!")
end

-- Register context menu
function TranslationHelper.RegisterContextMenu()
    print("[TranslationHelper] Registering context menu...")
    -- Would integrate with right-click menu
end

-- Translate selected text (from context menu)
function TranslationHelper.TranslateSelected(text)
    if text and text ~= "" then
        local targetLang = TranslationHelper.config.targetLang
        local result = TranslationHelper.Translate(text, "auto", targetLang, TranslationHelper.config.engine)
        
        if result then
            Notifications.push("Translation", result)
        end
    end
end

-- Detect language
function TranslationHelper.DetectLanguage(text)
    -- Use Google API to detect language
    local encodedText = TranslationHelper.UrlEncode(text)
    local url = "https://translate.googleapis.com/translate_a/single?client=gtx&sl=auto&tl=en&dt=t&q=" .. encodedText
    
    local headers = {
        ["User-Agent"] = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36"
    }
    
    local response = http.get(url, headers)
    if response then
        -- Extract detected language from response
        local detected = response:match('"([^"]+)"') -- Simplified extraction
        return detected or "en"
    end
    
    return "en"
end

-- Save configuration
function TranslationHelper.SaveConfig()
    local configDir = client.GetScriptsPath() .. "\\TranslationHelper"
    if not file.exists(configDir) then
        file.create_directory(configDir)
    end
    
    local data = {
        config = TranslationHelper.config,
        engines = TranslationHelper.ENGINES,
        history = TranslationHelper.history
    }
    
    file.write(configDir .. "\\config.json", JsonWrapper.stringify(data))
end

-- Load configuration
function TranslationHelper.LoadConfig()
    local configPath = client.GetScriptsPath() .. "\\TranslationHelper\\config.json"
    if file.exists(configPath) then
        local data = JsonWrapper.parse(file.read(configPath))
        TranslationHelper.config = data.config or TranslationHelper.config
        TranslationHelper.ENGINES = data.engines or TranslationHelper.ENGINES
        TranslationHelper.history = data.history or {}
    end
end

-- Get supported languages for engine
function TranslationHelper.GetSupportedLanguages(engine)
    local engineData = TranslationHelper.ENGINES[engine]
    if engineData then
        return engineData.supports
    end
    return {}
end

-- Check if language is supported
function TranslationHelper.IsLanguageSupported(langCode, engine)
    local supported = TranslationHelper.GetSupportedLanguages(engine)
    for _, code in ipairs(supported) do
        if code == langCode then
            return true
        end
    end
    return false
end

-- Initialize
TranslationHelper.Initialize()

-- Export
_G.TranslationHelper = TranslationHelper

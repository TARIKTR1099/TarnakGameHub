#pragma once

#include "../pch.h"
#include <string>
#include <sstream>
#include <fstream>
#include <mutex>
#include <chrono>

namespace Tarnak {

/**
 * Logging system for the application
 */
class Logger
{
public:
    enum class Level
    {
        Debug,
        Info,
        Warning,
        Error,
        Fatal
    };

    static bool Initialize();
    static void Shutdown();
    
    static void SetLogLevel(Level level);
    static Level GetLogLevel();
    
    static void SetLogFile(const std::string& filepath);
    
    // Template logging functions
    template<typename... Args>
    static void Debug(std::format_string<Args...> fmt, Args&&... args)
    {
        Log(Level::Debug, std::format(fmt, std::forward<Args>(args)...));
    }
    
    template<typename... Args>
    static void Info(std::format_string<Args...> fmt, Args&&... args)
    {
        Log(Level::Info, std::format(fmt, std::forward<Args>(args)...));
    }
    
    template<typename... Args>
    static void Warning(std::format_string<Args...> fmt, Args&&... args)
    {
        Log(Level::Warning, std::format(fmt, std::forward<Args>(args)...));
    }
    
    template<typename... Args>
    static void Error(std::format_string<Args...> fmt, Args&&... args)
    {
        Log(Level::Error, std::format(fmt, std::forward<Args>(args)...));
    }
    
    template<typename... Args>
    static void Fatal(std::format_string<Args...> fmt, Args&&... args)
    {
        Log(Level::Fatal, std::format(fmt, std::forward<Args>(args)...));
    }

private:
    static void Log(Level level, const std::string& message);
    static std::string GetTimestamp();
    static std::string LevelToString(Level level);
    
    static std::ofstream s_logFile;
    static std::mutex s_mutex;
    static Level s_logLevel;
    static bool s_initialized;
};

} // namespace Tarnak

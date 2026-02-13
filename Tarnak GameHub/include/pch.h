/**
 * Precompiled Header for Tarnak Game Hub
 */

#pragma once

// Windows headers
#define WIN32_LEAN_AND_MEAN
#define NOMINMAX
#include <windows.h>
#include <wrl/client.h>
#include <shellapi.h>
#include <shlobj.h>
#include <psapi.h>
#include <versionhelpers.h>

// C++ Standard Library
#include <string>
#include <string_view>
#include <vector>
#include <array>
#include <map>
#include <unordered_map>
#include <set>
#include <unordered_set>
#include <queue>
#include <stack>
#include <deque>
#include <list>
#include <forward_list>
#include <memory>
#include <functional>
#include <algorithm>
#include <numeric>
#include <iterator>
#include <utility>
#include <tuple>
#include <variant>
#include <optional>
#include <expected>
#include <chrono>
#include <thread>
#include <mutex>
#include <shared_mutex>
#include <condition_variable>
#include <future>
#include <atomic>
#include <filesystem>
#include <fstream>
#include <sstream>
#include <iostream>
#include <iomanip>
#include <ios>
#include <streambuf>
#include <exception>
#include <stdexcept>
#include <system_error>
#include <type_traits>
#include <typeinfo>
#include <typeindex>
#include <concepts>
#include <ranges>
#include <format>
#include <regex>
#include <random>
#include <cmath>
#include <cstdint>
#include <cstddef>
#include <cstdlib>
#include <cstring>
#include <ctime>
#include <clocale>
#include <cwchar>
#include <cwctype>

// Third-party libraries (install via vcpkg or nuget)
// #include <nlohmann/json.hpp>

// DirectX (Windows SDK)
#include <d3d11.h>
#include <dxgi.h>
#include <d3dcompiler.h>

// ImGui (add to project or install via vcpkg)
// #include "imgui.h"
// #include "imgui_impl_win32.h"
// #include "imgui_impl_dx11.h"

// Application version
#define APP_NAME "Tarnak Game Hub"
#define APP_VERSION "1.0.0"
#define APP_VERSION_MAJOR 1
#define APP_VERSION_MINOR 0
#define APP_VERSION_PATCH 0
#define APP_COMPANY "Tarnak Development"
#define APP_COPYRIGHT "Copyright (c) 2026 Tarnak Development"

// Namespace alias
// namespace json = nlohmann;
namespace fs = std::filesystem;

// Utility macros
#define UNUSED(x) (void)(x)
#define STRINGIFY(x) #x
#define TOSTRING(x) STRINGIFY(x)
#define CONCAT(a, b) a ## b

// Debug macros
#ifdef _DEBUG
    #define DEBUG_LOG(msg, ...) Tarnak::Logger::Debug(msg, __VA_ARGS__)
    #define ASSERT(cond, msg) do { if (!(cond)) { Tarnak::Logger::Error("Assertion failed: {} - {}", #cond, msg); __debugbreak(); } } while(0)
#else
    #define DEBUG_LOG(msg, ...)
    #define ASSERT(cond, msg)
#endif

// Platform detection
#ifdef _WIN32
    #define PLATFORM_WINDOWS
    #ifdef _WIN64
        #define PLATFORM_WINDOWS_64
    #else
        #define PLATFORM_WINDOWS_32
    #endif
#endif

// Safe COM macros
#define SAFE_RELEASE(p) do { if (p) { (p)->Release(); (p) = nullptr; } } while(0)
#define SAFE_DELETE(p) do { delete (p); (p) = nullptr; } while(0)
#define SAFE_DELETE_ARRAY(p) do { delete[] (p); (p) = nullptr; } while(0)

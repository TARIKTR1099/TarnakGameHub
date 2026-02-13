/**
 * Tarnak Game Hub - Main Entry Point
 * Version: 2.0.0
 * 
 * Copyright (c) 2026 Tarnak Development
 */

#include "pch.h"
#include "core/Application.h"
#include "core/Logger.h"
#include "utils/WindowsHelper.h"
#include <iostream>

#ifdef _WIN32
#include <Windows.h>
#endif

using namespace Tarnak;

int WINAPI wWinMain(
    HINSTANCE hInstance,
    HINSTANCE hPrevInstance,
    LPWSTR lpCmdLine,
    int nShowCmd
)
{
    UNREFERENCED_PARAMETER(hPrevInstance);
    UNREFERENCED_PARAMETER(lpCmdLine);

    try
    {
        // Initialize COM
        HRESULT hr = CoInitializeEx(nullptr, COINIT_APARTMENTTHREADED | COINIT_DISABLE_OLE1DDE);
        if (FAILED(hr))
        {
            MessageBoxW(nullptr, L"Failed to initialize COM", L"Error", MB_OK | MB_ICONERROR);
            return 1;
        }

        // Check if already running
        HANDLE hMutex = CreateMutexW(nullptr, TRUE, L"TarnakGameHub_Mutex");
        if (GetLastError() == ERROR_ALREADY_EXISTS)
        {
            // Activate existing window
            HWND hWnd = FindWindowW(L"TarnakGameHub_WindowClass", nullptr);
            if (hWnd)
            {
                ShowWindow(hWnd, SW_RESTORE);
                SetForegroundWindow(hWnd);
            }
            
            CoUninitialize();
            return 0;
        }

        // Initialize logger
        Logger::Initialize();
        Logger::Info("Tarnak Game Hub v{} starting...", APP_VERSION);

        // Create and run application
        Application::Create(hInstance);
        
        int exitCode = Application::Get().Run();

        // Cleanup
        Application::Destroy();
        Logger::Shutdown();

        ReleaseMutex(hMutex);
        CloseHandle(hMutex);
        CoUninitialize();

        return exitCode;
    }
    catch (const std::exception& e)
    {
        Logger::Error("Fatal error: {}", e.what());
        MessageBoxA(nullptr, e.what(), "Fatal Error", MB_OK | MB_ICONERROR);
        return 1;
    }
    catch (...)
    {
        Logger::Error("Unknown fatal error");
        MessageBoxA(nullptr, "Unknown error occurred", "Fatal Error", MB_OK | MB_ICONERROR);
        return 1;
    }
}

// Console entry point for debugging
#ifdef _DEBUG
int main(int argc, char* argv[])
{
    return wWinMain(
        GetModuleHandle(nullptr),
        nullptr,
        GetCommandLineW(),
        SW_SHOWDEFAULT
    );
}
#endif

cmake_minimum_required(VERSION 3.16)
project(TarnakGameHub VERSION 1.0.0 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Branding
set(APP_NAME "Tarnak Game Hub")
set(APP_VERSION "1.0.0")
set(APP_COMPANY "Tarnak Development")
set(APP_COPYRIGHT "Copyright (c) 2026 Tarnak Development")

# Windows specific
if(WIN32)
    set(CMAKE_WIN32_EXECUTABLE TRUE)
    add_definitions(-DNOMINMAX -DWIN32_LEAN_AND_MEAN -DUNICODE -D_UNICODE)
endif()

# Find packages
find_package(Threads REQUIRED)

# Include directories
include_directories(
    ${CMAKE_SOURCE_DIR}/include
    ${CMAKE_SOURCE_DIR}/third_party
    ${CMAKE_SOURCE_DIR}/third_party/imgui
    ${CMAKE_SOURCE_DIR}/third_party/sol2
    ${CMAKE_SOURCE_DIR}/third_party/json
)

# Source files
file(GLOB_RECURSE SOURCES 
    "src/*.cpp"
    "src/*.c"
)

file(GLOB_RECURSE HEADERS
    "include/*.h"
    "include/*.hpp"
)

# ImGui sources
file(GLOB IMGUI_SOURCES
    "third_party/imgui/*.cpp"
    "third_party/imgui/backends/imgui_impl_win32.cpp"
    "third_party/imgui/backends/imgui_impl_dx11.cpp"
)

# Main executable
add_executable(${PROJECT_NAME} WIN32
    ${SOURCES}
    ${HEADERS}
    ${IMGUI_SOURCES}
    resources/app.rc
    resources/app.manifest
)

# Link libraries
target_link_libraries(${PROJECT_NAME}
    Threads::Threads
    d3d11
    dxgi
    d3dcompiler
    user32
    gdi32
    shell32
    ole32
    oleaut32
    uuid
    wininet
    urlmon
    version
    psapi
    kernel32
)

# Precompiled header
if(MSVC)
    target_precompile_headers(${PROJECT_NAME} PRIVATE include/pch.h)
endif()

# Compiler options
if(MSVC)
    target_compile_options(${PROJECT_NAME} PRIVATE
        /W4
        /WX-
        /MP
        /permissive-
        /Zc:__cplusplus
        /Zc:wchar_t
        /Zc:forScope
        /Zc:inline
        /EHsc
        /nologo
    )
    
    # Release optimizations
    target_compile_options(${PROJECT_NAME} PRIVATE
        $<$<CONFIG:Release>:/O2>
        $<$<CONFIG:Release>:/Ob2>
        $<$<CONFIG:Release>:/Oi>
        $<$<CONFIG:Release>:/Ot>
        $<$<CONFIG:Release>:/Oy>
        $<$<CONFIG:Release>:/GT>
        $<$<CONFIG:Release>:/GL>
        $<$<CONFIG:Release>:/GF>
        $<$<CONFIG:Release>:/Gy>
    )
    
    target_link_options(${PROJECT_NAME} PRIVATE
        $<$<CONFIG:Release>:/LTCG>
        $<$<CONFIG:Release>:/OPT:REF>
        $<$<CONFIG:Release>:/OPT:ICF>
    )
endif()

# Definitions
target_compile_definitions(${PROJECT_NAME} PRIVATE
    APP_NAME="${APP_NAME}"
    APP_VERSION="${APP_VERSION}"
    APP_COMPANY="${APP_COMPANY}"
    APP_COPYRIGHT="${APP_COPYRIGHT}"
    NOMINMAX
    _CRT_SECURE_NO_WARNINGS
    $<$<CONFIG:Debug>:DEBUG>
    $<$<CONFIG:Debug>:_DEBUG>
    $<$<CONFIG:Release>:NDEBUG>
)

# Output directories
set_target_properties(${PROJECT_NAME} PROPERTIES
    RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin
    RUNTIME_OUTPUT_DIRECTORY_DEBUG ${CMAKE_BINARY_DIR}/bin/Debug
    RUNTIME_OUTPUT_DIRECTORY_RELEASE ${CMAKE_BINARY_DIR}/bin/Release
    LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib
    ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib
)

# Post-build: Copy assets
add_custom_command(TARGET ${PROJECT_NAME} POST_BUILD
    COMMAND ${CMAKE_COMMAND} -E copy_directory
    ${CMAKE_SOURCE_DIR}/assets
    $<TARGET_FILE_DIR:${PROJECT_NAME}>/assets
)

# Post-build: Copy Lua scripts
add_custom_command(TARGET ${PROJECT_NAME} POST_BUILD
    COMMAND ${CMAKE_COMMAND} -E copy_directory
    ${CMAKE_SOURCE_DIR}/scripts
    $<TARGET_FILE_DIR:${PROJECT_NAME}>/scripts
)

# Post-build: Copy themes
add_custom_command(TARGET ${PROJECT_NAME} POST_BUILD
    COMMAND ${CMAKE_COMMAND} -E copy_directory
    ${CMAKE_SOURCE_DIR}/themes
    $<TARGET_FILE_DIR:${PROJECT_NAME}>/themes
)

# Post-build: Copy translations
add_custom_command(TARGET ${PROJECT_NAME} POST_BUILD
    COMMAND ${CMAKE_COMMAND} -E copy_directory
    ${CMAKE_SOURCE_DIR}/translations
    $<TARGET_FILE_DIR:${PROJECT_NAME}>/translations
)

# Installation
install(TARGETS ${PROJECT_NAME}
    RUNTIME DESTINATION .
)

install(DIRECTORY assets/ DESTINATION assets)
install(DIRECTORY scripts/ DESTINATION scripts)
install(DIRECTORY themes/ DESTINATION themes)
install(DIRECTORY translations/ DESTINATION translations)

# CPack for installer
set(CPACK_PACKAGE_NAME "${APP_NAME}")
set(CPACK_PACKAGE_VERSION "${APP_VERSION}")
set(CPACK_PACKAGE_VENDOR "${APP_COMPANY}")
set(CPACK_PACKAGE_DESCRIPTION_SUMMARY "Advanced Game Management and Optimization Platform")
set(CPACK_PACKAGE_INSTALL_DIRECTORY "${APP_NAME}")
set(CPACK_RESOURCE_FILE_LICENSE "${CMAKE_SOURCE_DIR}/LICENSE")
set(CPACK_RESOURCE_FILE_README "${CMAKE_SOURCE_DIR}/README.md")

# NSIS specific
set(CPACK_GENERATOR "NSIS")
set(CPACK_NSIS_DISPLAY_NAME "${APP_NAME}")
set(CPACK_NSIS_PACKAGE_NAME "${APP_NAME}")
set(CPACK_NSIS_HELP_LINK "https://github.com/TARIKTR1099")
set(CPACK_NSIS_URL_INFO_ABOUT "https://github.com/TARIKTR1099")
set(CPACK_NSIS_CONTACT "tarnakdev@gmail.com")
set(CPACK_NSIS_MODIFY_PATH ON)
set(CPACK_NSIS_ENABLE_UNINSTALL_BEFORE_INSTALL ON)
set(CPACK_NSIS_MUI_ICON "${CMAKE_SOURCE_DIR}/resources/app.ico")
set(CPACK_NSIS_MUI_UNIICON "${CMAKE_SOURCE_DIR}/resources/app.ico")
set(CPACK_NSIS_INSTALLED_ICON_NAME "bin\\${PROJECT_NAME}.exe")

include(CPack)

# Print configuration
message(STATUS "")
message(STATUS "${APP_NAME} ${APP_VERSION} Configuration:")
message(STATUS "  Compiler: ${CMAKE_CXX_COMPILER_ID} ${CMAKE_CXX_COMPILER_VERSION}")
message(STATUS "  Build Type: ${CMAKE_BUILD_TYPE}")
message(STATUS "  Install Prefix: ${CMAKE_INSTALL_PREFIX}")
message(STATUS "")

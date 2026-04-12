@echo off
setlocal enabledelayedexpansion
title Portable AI USB - Uninstall

:: Define ANSI Colors
for /F %%a in ('powershell -NoProfile -Command "[char]27"') do set "ESC=%%a"
set "CYAN=!ESC![36m"
set "GREEN=!ESC![32m"
set "YELLOW=!ESC![33m"
set "RED=!ESC![31m"
set "DIM=!ESC![90m"
set "RESET=!ESC![0m"
set "BOLD=!ESC![1m"

set "USB_ROOT=%~dp0"
set "ROOT_DIR=%USB_ROOT%..\\"
set "BIN_DIR=%USB_ROOT%bin"
set "DATA_DIR=%ROOT_DIR%data"

echo.
echo !CYAN!=========================================================!RESET!
echo   !BOLD!Portable AI USB - Uninstall!RESET!
echo !CYAN!=========================================================!RESET!
echo.
echo   This tool will remove installed components from the USB.
echo.

:: Show what exists
set "HAS_BIN=0"
set "HAS_DATA=0"
if exist "%BIN_DIR%" set "HAS_BIN=1"
if exist "%DATA_DIR%" set "HAS_DATA=1"

if !HAS_BIN!==0 if !HAS_DATA!==0 (
    echo   !DIM!Nothing to uninstall. The USB is already clean.!RESET!
    echo.
    pause
    exit /b
)

:: Calculate sizes
set "BIN_SIZE=0"
set "DATA_SIZE=0"
if !HAS_BIN!==1 (
    for /f "tokens=*" %%S in ('powershell -NoProfile -Command "[math]::Round((Get-ChildItem -Recurse '%BIN_DIR%' -ErrorAction SilentlyContinue | Measure-Object -Property Length -Sum).Sum / 1MB, 1)"') do set "BIN_SIZE=%%S"
)
if !HAS_DATA!==1 (
    for /f "tokens=*" %%S in ('powershell -NoProfile -Command "[math]::Round((Get-ChildItem -Recurse '%DATA_DIR%' -ErrorAction SilentlyContinue | Measure-Object -Property Length -Sum).Sum / 1MB, 1)"') do set "DATA_SIZE=%%S"
)

echo   !BOLD!What would you like to remove?!RESET!
echo.
if !HAS_BIN!==1 echo   !CYAN!1)!RESET! Engine only !DIM!(bin folder - !BIN_SIZE! MB)!RESET!
if !HAS_BIN!==1 if !HAS_DATA!==1 echo   !CYAN!2)!RESET! Everything  !DIM!(bin + data folders - frees all space)!RESET!
echo   !CYAN!3)!RESET! Cancel
echo.

:prompt_uninstall
set "UNINST_CHOICE="
set /p "UNINST_CHOICE=  Select option: "

if "!UNINST_CHOICE!"=="3" (
    echo.
    echo   !DIM!Cancelled. Nothing was removed.!RESET!
    pause
    exit /b
)

if "!UNINST_CHOICE!"=="1" if !HAS_BIN!==1 (
    echo.
    echo   !RED!!BOLD!WARNING: This will delete the entire bin folder!!RESET!
    echo   !DIM!You will need to run Setup_First_Time.bat again.!RESET!
    echo.
    set "CONFIRM="
    set /p "CONFIRM=  Are you sure? !RED!(Y/N)!RESET!: "
    if /I "!CONFIRM!"=="Y" (
        echo.
        echo   !YELLOW![~] Removing engine files...!RESET!
        rmdir /s /q "%BIN_DIR%" 2>nul
        echo   !GREEN![OK] Engine removed! Freed ~!BIN_SIZE! MB!RESET!
    ) else (
        echo   !DIM!Cancelled.!RESET!
    )
    echo.
    pause
    exit /b
)

if "!UNINST_CHOICE!"=="2" if !HAS_BIN!==1 if !HAS_DATA!==1 (
    echo.
    echo   !RED!!BOLD!WARNING: This will delete ALL data including:!RESET!
    echo   !RED!  - AI Engine (bin folder)!RESET!
    echo   !RED!  - API keys and settings!RESET!
    echo   !RED!  - Chat history and logs!RESET!
    echo.
    set "CONFIRM="
    set /p "CONFIRM=  Type 'DELETE' to confirm: "
    if "!CONFIRM!"=="DELETE" (
        echo.
        echo   !YELLOW![~] Removing all files...!RESET!
        rmdir /s /q "%BIN_DIR%" 2>nul
        rmdir /s /q "%DATA_DIR%" 2>nul
        set /a TOTAL_SIZE=BIN_SIZE+DATA_SIZE
        echo   !GREEN![OK] Everything removed! Freed ~!TOTAL_SIZE! MB!RESET!
    ) else (
        echo   !DIM!Cancelled. You must type DELETE exactly.!RESET!
    )
    echo.
    pause
    exit /b
)

echo   !RED![ERROR] Invalid selection.!RESET!
goto prompt_uninstall

@echo off
setlocal enabledelayedexpansion
title Portable AI USB - Reconfigure

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
set "DATA_DIR=%ROOT_DIR%data"
set "ENV_FILE=%DATA_DIR%\ai_settings.env"

echo.
echo !CYAN!=========================================================!RESET!
echo   !BOLD!Portable AI USB - Reconfiguration Tool!RESET!
echo !CYAN!=========================================================!RESET!
echo.
echo   This will clear your current API Key and Model choices
echo   and restart the setup menu so you can pick new ones.
echo.

:: Show current config if it exists
if exist "%ENV_FILE%" (
    echo   !BOLD!Current Configuration:!RESET!
    echo   !CYAN!-------------------------------------------------!RESET!
    for /f "usebackq tokens=1,* delims==" %%A in ("%ENV_FILE%") do (
        set "LINE=%%A"
        if not "!LINE:~0,1!"=="#" (
            set "KEY=%%A"
            set "VAL=%%B"
            :: Mask API keys
            if "!KEY!"=="OPENAI_API_KEY"   set "VAL=!VAL:~0,6!****!VAL:~-4!"
            if "!KEY!"=="GEMINI_API_KEY"   set "VAL=!VAL:~0,6!****!VAL:~-4!"
            if "!KEY!"=="ANTHROPIC_API_KEY" set "VAL=!VAL:~0,6!****!VAL:~-4!"
            echo   !DIM!!KEY!!RESET! = !GREEN!!VAL!!RESET!
        )
    )
    echo   !CYAN!-------------------------------------------------!RESET!
    echo.
)

:confirm
set "RESET_CONFIRM="
set /p "RESET_CONFIRM=  Reset configuration? !RED!(Y/N)!RESET!: "
if /I "!RESET_CONFIRM!"=="Y" goto do_reset
if /I "!RESET_CONFIRM!"=="N" (
    echo.
    echo   !DIM!Cancelled. No changes made.!RESET!
    pause
    exit /b
)
echo   !RED![ERROR] Invalid selection. Please enter Y or N.!RESET!
goto confirm

:do_reset
if exist "%ENV_FILE%" (
    del "%ENV_FILE%"
    echo.
    echo   !GREEN![OK] Previous configuration cleared!!RESET!
    echo.
) else (
    echo.
    echo   !DIM![INFO] No previous configuration found.!RESET!
    echo.
)

echo   !CYAN![~] Launching setup...!RESET!
echo.
call "%USB_ROOT%Start_AI.bat"

@echo off
title Set PowerShell 7 as Default Terminal

REM Check for administrative privileges
NET SESSION >nul 2>&1
if %errorLevel% neq 0 (
    echo Error: This script requires administrative privileges.
    echo Please run as administrator and try again.
    pause
    exit /b 1
)

REM Step 1: Check if PowerShell 7 is installed
echo Checking for PowerShell 7 installation...
where pwsh >nul 2>&1
if %errorLevel% neq 0 (
    echo Error: PowerShell 7 is not installed.
    echo Please install PowerShell 7 manually from https://github.com/PowerShell/PowerShell/releases and try again.
    pause
    exit /b 1
)
echo PowerShell 7 found.
for /f "tokens=*" %%i in ('pwsh -Command "(Get-Item (Get-Command pwsh).Source).VersionInfo.ProductVersion"') do set "version=%%i"
echo Version: %version%

REM Step 2: Check if Windows Terminal is installed
echo Checking for Windows Terminal...
where wt >nul 2>&1
if %errorLevel% neq 0 (
    echo Error: Windows Terminal is not installed.
    echo Please install Windows Terminal from Microsoft Store or GitHub and try again.
    pause
    exit /b 1
)

REM Step 3: Configure PowerShell 7 as default in Windows Terminal
echo Configuring PowerShell 7 as default terminal...
set "settingsPath=%LOCALAPPDATA%\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json"
if not exist "%settingsPath%" (
    echo Error: Windows Terminal settings file not found at %settingsPath%
    pause
    exit /b 1
)

powershell -Command "$settingsContent = Get-Content -Path '%settingsPath%' | ConvertFrom-Json; $ps7Profile = $settingsContent.profiles.list | Where-Object { $_.name -eq 'PowerShell' }; if (-not $ps7Profile) { exit 2 }; if ($settingsContent.defaultProfile -eq $ps7Profile.guid) { Write-Host 'PowerShell 7 is already the default terminal.'; exit 0 } else { $settingsContent.defaultProfile = $ps7Profile.guid; $settingsContent | ConvertTo-Json -Depth 100 | Set-Content -Path '%settingsPath%'; exit 0 }" >nul 2>&1
set "psError=%errorLevel%"
if %psError% equ 2 (
    echo Error: PowerShell 7 profile not found in Windows Terminal settings.
    pause
    exit /b 1
)
if %psError% neq 0 (
    echo Error: Failed to configure PowerShell 7 as default.
    pause
    exit /b 1
)
powershell -Command "if ($env:psError -eq 0) { Write-Host 'Default profile updated to PowerShell 7.' }" >nul 2>&1
if %errorLevel% neq 0 (
    echo PowerShell 7 is already set as the default terminal.
    echo No changes needed.
)

REM Final confirmation
echo PowerShell 7 set as default terminal successfully!
echo Open Windows Terminal to verify. Press any key to exit.
pause
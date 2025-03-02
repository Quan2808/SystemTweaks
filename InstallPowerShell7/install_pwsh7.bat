@echo off
title Install PowerShell 7 on Windows

REM Check for administrative privileges
NET SESSION >nul 2>&1
if %errorLevel% neq 0 (
    echo Error: This script requires administrative privileges.
    echo Please run as administrator and try again.
    pause
    exit /b 1
)

REM Step 1: Check if PowerShell 7 is already installed
echo Checking for existing PowerShell 7 installation...
where pwsh >nul 2>&1
if %errorLevel% equ 0 (
    echo PowerShell 7 is already installed.
    for /f "tokens=*" %%i in ('pwsh -Command "(Get-Item (Get-Command pwsh).Source).VersionInfo.ProductVersion"') do set "version=%%i"
    echo Version: %version%
    echo Exiting script as no installation is needed.
    pause
    exit /b 0
)
echo PowerShell 7 not found. Proceeding with installation...

REM Step 2: Download PowerShell 7 installer using PowerShell
echo Downloading PowerShell 7 installer...
powershell -Command "$releaseUrl = 'https://api.github.com/repos/PowerShell/PowerShell/releases/latest'; $release = Invoke-RestMethod -Uri $releaseUrl; $installerUrl = ($release.assets | Where-Object { $_.name -match 'PowerShell-.*-win-x64.msi' }).browser_download_url; Invoke-WebRequest -Uri $installerUrl -OutFile '%TEMP%\PowerShell7.msi'" >nul 2>&1
if %errorLevel% neq 0 (
    echo Error: Failed to download PowerShell 7 installer.
    pause
    exit /b 1
)
echo Installer downloaded to: %TEMP%\PowerShell7.msi

REM Step 3: Install PowerShell 7 silently
echo Installing PowerShell 7...
msiexec.exe /i "%TEMP%\PowerShell7.msi" /quiet /norestart
if %errorLevel% neq 0 (
    echo Error: Failed to install PowerShell 7.
    pause
    exit /b 1
)
echo PowerShell 7 installed successfully!

REM Clean up installer file
del "%TEMP%\PowerShell7.msi" >nul 2>&1
echo Installer file cleaned up.

REM Final confirmation
echo PowerShell 7 installation completed!
echo Run 'pwsh' to start PowerShell 7. Press any key to exit.
pause
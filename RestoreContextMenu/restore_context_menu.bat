@echo off
title Restore Classic Context Menu in Windows 11

REM Check for administrative privileges
NET SESSION >nul 2>&1
if %errorLevel% neq 0 (
    echo Error: This script requires administrative privileges.
    echo Please run as administrator and try again.
    pause
    exit /b 1
)

REM Define constants
set "BACKUP_PATH=%USERPROFILE%\Desktop\RegistryBackup.reg"
set "REG_PATH=HKEY_CURRENT_USER\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32"

REM Step 0: Check if running on Windows 11 (basic check via ver command)
ver | findstr /C:"Version 10.0.2" >nul
if %errorLevel% neq 0 (
    echo Error: This tweak is designed for Windows 11 only.
    echo Exiting script as no changes are needed for this system.
    pause
    exit /b 0
)

REM Step 1: Backup the registry
echo Backing up the registry...
reg export "HKEY_CURRENT_USER\Software\Classes\CLSID" "%BACKUP_PATH%" /y >nul 2>&1
if %errorLevel% neq 0 (
    echo Error: Failed to back up the registry.
    echo Please check your permissions and try again.
    pause
    exit /b 1
)
echo Registry backup saved to: %BACKUP_PATH%
pause

REM Step 2: Add registry key to restore classic context menu
echo Restoring classic right-click context menu...
reg add "%REG_PATH%" /ve /f >nul 2>&1
if %errorLevel% neq 0 (
    echo Error: Failed to update registry.
    echo Please check your permissions and try again.
    pause
    exit /b 1
)
echo Registry updated successfully.

REM Step 3: Restart Windows Explorer
echo Restarting Windows Explorer to apply changes...
taskkill /f /im explorer.exe >nul 2>&1
timeout /t 1 /nobreak >nul
start explorer.exe
if %errorLevel% neq 0 (
    echo Error: Failed to restart Windows Explorer.
    pause
    exit /b 1
)
echo Windows Explorer restarted successfully.

REM Final confirmation
echo Classic context menu restored successfully!
echo Right-click anywhere to verify the change. Press any key to exit.
pause
@echo off

REM Check for administrator privileges
NET SESSION >nul 2>&1
if %errorLevel% neq 0 (
    echo Error: This script requires administrative privileges. Please run it as an administrator.
    pause
    exit
)

REM Define constants
set BACKUP_PATH=%USERPROFILE%\Desktop\RegistryBackup.reg
set REG_PATH=HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\be337238-0d82-4146-a960-4f3749d470c7

REM Step 1: Backup the registry
echo Backing up the registry before making changes...
reg export "HKEY_LOCAL_MACHINE\SYSTEM" "%BACKUP_PATH%" /y >nul 2>&1

if %errorLevel% neq 0 (
    echo Error: Failed to back up the registry. Please check your permissions and try again.
    pause
    exit
)
echo Registry has been successfully backed up to your Desktop as RegistryBackup.reg.

REM Step 2: Modify registry to expose Turbo Boost settings
echo Modifying registry to disable Turbo Boost...
reg add "%REG_PATH%" /v Attributes /t REG_DWORD /d 2 /f >nul 2>&1

if %errorLevel% neq 0 (
    echo Error: Failed to modify the registry. Please check your permissions and try again.
    pause
    exit
)
echo Turbo Boost registry settings updated successfully.

REM Step 3: Disable Processor Performance Boost Mode in power settings
echo Configuring power settings to disable Processor Performance Boost Mode...
powercfg /setacvalueindex SCHEME_CURRENT SUB_PROCESSOR PERFBOOSTMODE 0 >nul 2>&1
powercfg /setdcvalueindex SCHEME_CURRENT SUB_PROCESSOR PERFBOOSTMODE 0 >nul 2>&1
powercfg /setactive SCHEME_CURRENT >nul 2>&1

if %errorLevel% neq 0 (
    echo Error: Failed to configure power settings. Please check your system configuration and try again.
    pause
    exit
)
echo Processor Performance Boost Mode has been disabled for both 'On battery' and 'Plugged in'.

REM Final confirmation message
echo Configuration completed successfully!
echo Turbo Boost is now disabled. Press any key to exit.
pause

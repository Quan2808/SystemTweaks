@echo off
title Install VSCodium on Windows

REM Check for administrative privileges
NET SESSION >nul 2>&1
if %errorLevel% neq 0 (
    echo Error: This script requires administrative privileges.
    echo Please run as administrator and try again.
    pause
    exit /b 1
)

REM Step 1: Check if VSCodium is fully installed
echo Checking for existing VSCodium installation...
set "vscodiumExe=%ProgramFiles%\VSCodium\VSCodium.exe"
set "startMenu=%ProgramData%\Microsoft\Windows\Start Menu\Programs\VSCodium\VSCodium.lnk"
set "desktop=%Public%\Desktop\VSCodium.lnk"
set "vscodiumCmd="
for /f "tokens=*" %%i in ('where codium 2^>nul') do set "vscodiumCmd=%%i"
if defined vscodiumCmd (
    if exist "%vscodiumExe%" (
        echo VSCodium executable found at: %vscodiumExe%
        for /f "tokens=*" %%v in ('"%vscodiumCmd%" --version') do (
            set "version=%%v"
            goto :found_version
        )
        :found_version
        echo Version: %version%
        if exist "%startMenu%" if exist "%desktop%" (
            echo Start Menu and Desktop shortcuts already exist.
            echo Exiting script as no installation is needed.
            pause
            exit /b 0
        ) else (
            echo VSCodium installed but missing shortcuts. Reinstalling...
        )
    ) else (
        echo VSCodium not found or not fully installed. Proceeding with installation...
    )
) else (
    echo VSCodium not found or not fully installed. Proceeding with installation...
)

REM Step 2: Download the latest VSCodium installer
echo Downloading VSCodium installer...
powershell -Command "$releaseUrl = 'https://api.github.com/repos/VSCodium/vscodium/releases/latest'; $release = Invoke-RestMethod -Uri $releaseUrl; $installerAsset = $release.assets | Where-Object { $_.name -match 'VSCodiumSetup-x64-.*.exe' } | Select-Object -First 1; if (-not $installerAsset) { exit 1 }; Invoke-WebRequest -Uri $installerAsset.browser_download_url -OutFile '%TEMP%\VSCodiumSetup.exe'" >nul 2>&1
if %errorLevel% neq 0 (
    echo Error: Failed to download VSCodium installer.
    pause
    exit /b 1
)
echo Installer downloaded to: %TEMP%\VSCodiumSetup.exe

REM Step 3: Install VSCodium silently with shortcuts
echo Installing VSCodium...
"%TEMP%\VSCodiumSetup.exe" /VERYSILENT /SUPPRESSMSGBOXES /NORESTART /MERGETASKS=!runcode,desktopicon,startmenu
if %errorLevel% neq 0 (
    echo Error: Failed to install VSCodium.
    pause
    exit /b 1
)
if not exist "%vscodiumExe%" (
    echo Error: VSCodium executable not found after installation.
    pause
    exit /b 1
)
echo VSCodium installed successfully at: %vscodiumExe%

REM Clean up installer file
del "%TEMP%\VSCodiumSetup.exe" >nul 2>&1
if not exist "%TEMP%\VSCodiumSetup.exe" (
    echo Installer file cleaned up.
)

REM Final confirmation
echo VSCodium installation completed!
echo Run 'codium' or use Start Menu/Desktop shortcuts to start VSCodium. Press any key to exit.
pause
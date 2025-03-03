# Ensure script runs with administrative privileges
if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Host "Error: This script requires administrative privileges." -ForegroundColor Red
    Write-Host "Please run PowerShell as an administrator and try again." -ForegroundColor Yellow
    Pause
    exit 1
}

# Step 1: Check if VSCodium is fully installed
Write-Host "Checking for existing VSCodium installation..." -ForegroundColor Cyan
$vscodiumExePath = "$env:ProgramFiles\VSCodium\VSCodium.exe"
$startMenuShortcut = "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\VSCodium\VSCodium.lnk"
$desktopShortcut = "$env:Public\Desktop\VSCodium.lnk"
$vscodiumCmdPath = (Get-Command codium -ErrorAction Stop).Source
try {
    if (Test-Path $vscodiumExePath) {
        $vscodiumPath = $vscodiumExePath
        Write-Host "VSCodium executable found at: $vscodiumPath" -ForegroundColor Yellow
        Write-Host "Version: $(& $vscodiumCmdPath --version | Select-Object -First 1)" -ForegroundColor Yellow
        if ((Test-Path $startMenuShortcut) -and (Test-Path $desktopShortcut)) {
            Write-Host "Exiting script as no installation is needed." -ForegroundColor Yellow
            Pause
            exit 0
        }
        else {
            Write-Host "VSCodium installed but missing shortcuts. Reinstalling..." -ForegroundColor Cyan
        }
    }
    else {
        Write-Host "VSCodium not found or not fully installed. Proceeding with installation..." -ForegroundColor Green
    }
}
catch {
    Write-Host "VSCodium not found or not fully installed. Proceeding with installation..." -ForegroundColor Green
}

# Step 2: Download the latest VSCodium installer
Write-Host "Downloading VSCodium installer..." -ForegroundColor Cyan
try {
    $releaseUrl = "https://api.github.com/repos/VSCodium/vscodium/releases/latest"
    $release = Invoke-RestMethod -Uri $releaseUrl -ErrorAction Stop
    $installerAsset = $release.assets | Where-Object { $_.name -match "VSCodiumSetup-x64-.*.exe" } | Select-Object -First 1
    if (-not $installerAsset) { throw "Failed to find VSCodium installer URL for x64." }
    $installerUrl = $installerAsset.browser_download_url
    
    $installerPath = "$env:TEMP\VSCodiumSetup.exe"
    Invoke-WebRequest -Uri $installerUrl -OutFile $installerPath -ErrorAction Stop
    Write-Host "Installer downloaded to: $installerPath" -ForegroundColor Green
}
catch {
    Write-Host "Error: Failed to download VSCodium installer." -ForegroundColor Red
    Write-Host "Details: $($_.Exception.Message)" -ForegroundColor Yellow
    Pause
    exit 1
}

# Step 3: Install VSCodium silently with shortcuts
Write-Host "Installing VSCodium..." -ForegroundColor Cyan
try {
    $installProcess = Start-Process -FilePath $installerPath -ArgumentList "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /MERGETASKS=!runcode,desktopicon,startmenu" -Wait -NoNewWindow -PassThru -ErrorAction Stop
    if ($installProcess.ExitCode -ne 0) {
        throw "Installer exited with code $($installProcess.ExitCode)."
    }
    # Verify installation
    if (Test-Path $vscodiumExePath) {
        Write-Host "VSCodium installed successfully at: $vscodiumExePath" -ForegroundColor Green
    }
    else {
        throw "VSCodium executable not found after installation."
    }
}
catch {
    Write-Host "Error: Failed to install VSCodium." -ForegroundColor Red
    Write-Host "Details: $($_.Exception.Message)" -ForegroundColor Yellow
    Pause
    exit 1
}
finally {
    # Clean up installer file
    if (Test-Path $installerPath) {
        Remove-Item $installerPath -Force
        Write-Host "Installer file cleaned up." -ForegroundColor Green
    }
}

# Final confirmation
Write-Host "VSCodium installation completed!" -ForegroundColor Green
Write-Host "Run 'codium' or use Start Menu/Desktop shortcuts to start VSCodium. Press any key to exit." -ForegroundColor White
Pause
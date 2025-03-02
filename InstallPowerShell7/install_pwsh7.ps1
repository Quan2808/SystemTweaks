# Ensure script runs with administrative privileges
if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Host "Error: This script requires administrative privileges." -ForegroundColor Red
    Write-Host "Please run PowerShell as an administrator and try again." -ForegroundColor Yellow
    Pause
    exit 1
}

# Step 1: Check if PowerShell 7 is already installed
Write-Host "Checking for existing PowerShell 7 installation..." -ForegroundColor Cyan
try {
    $pwshPath = (Get-Command pwsh -ErrorAction Stop).Source
    if ($pwshPath) {
        Write-Host "PowerShell 7 is already installed at: $pwshPath" -ForegroundColor Yellow
        Write-Host "Version: $((Get-Item $pwshPath).VersionInfo.ProductVersion)" -ForegroundColor Yellow
        Write-Host "Exiting script as no installation is needed." -ForegroundColor Yellow
        Pause
        exit 0
    }
}
catch {
    Write-Host "PowerShell 7 not found. Proceeding with installation..." -ForegroundColor Green
}

# Step 2: Download the latest PowerShell 7 installer
Write-Host "Downloading PowerShell 7 installer..." -ForegroundColor Cyan
try {
    $releaseUrl = "https://api.github.com/repos/PowerShell/PowerShell/releases/latest"
    $release = Invoke-RestMethod -Uri $releaseUrl -ErrorAction Stop
    $installerUrl = ($release.assets | Where-Object { $_.name -match "PowerShell-.*-win-x64.msi" }).browser_download_url
    if (-not $installerUrl) { throw "Failed to find PowerShell 7 installer URL." }
    
    $installerPath = "$env:TEMP\PowerShell7.msi"
    Invoke-WebRequest -Uri $installerUrl -OutFile $installerPath -ErrorAction Stop
    Write-Host "Installer downloaded to: $installerPath" -ForegroundColor Green
}
catch {
    Write-Host "Error: Failed to download PowerShell 7 installer." -ForegroundColor Red
    Write-Host "Details: $($_.Exception.Message)" -ForegroundColor Yellow
    Pause
    exit 1
}

# Step 3: Install PowerShell 7 silently
Write-Host "Installing PowerShell 7..." -ForegroundColor Cyan
try {
    Start-Process -FilePath "msiexec.exe" -ArgumentList "/i `"$installerPath`" /quiet /norestart" -Wait -NoNewWindow -ErrorAction Stop
    Write-Host "PowerShell 7 installed successfully!" -ForegroundColor Green
}
catch {
    Write-Host "Error: Failed to install PowerShell 7." -ForegroundColor Red
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
Write-Host "PowerShell 7 installation completed!" -ForegroundColor Green
Write-Host "Run 'pwsh' to start PowerShell 7. Press any key to exit." -ForegroundColor White
Pause
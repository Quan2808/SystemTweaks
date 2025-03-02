# Ensure script runs with administrative privileges
if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Host "Error: This script requires administrative privileges." -ForegroundColor Red
    Write-Host "Please run PowerShell as an administrator and try again." -ForegroundColor Yellow
    Pause
    exit 1
}

# Step 1: Check if PowerShell 7 is installed
Write-Host "Checking for PowerShell 7 installation..." -ForegroundColor Cyan
try {
    $pwshPath = (Get-Command pwsh -ErrorAction Stop).Source
    Write-Host "PowerShell 7 found at: $pwshPath" -ForegroundColor Green
    Write-Host "Version: $((Get-Item $pwshPath).VersionInfo.ProductVersion)" -ForegroundColor Green
}
catch {
    Write-Host "Error: PowerShell 7 is not installed." -ForegroundColor Red
    Write-Host "Please install PowerShell 7 manually from https://github.com/PowerShell/PowerShell/releases and try again." -ForegroundColor Yellow
    Pause
    exit 1
}

# Step 2: Check if Windows Terminal is installed
Write-Host "Checking for Windows Terminal..." -ForegroundColor Cyan
if (-not (Get-Command "wt" -ErrorAction SilentlyContinue)) {
    Write-Host "Error: Windows Terminal is not installed." -ForegroundColor Red
    Write-Host "Please install Windows Terminal from Microsoft Store or GitHub and try again." -ForegroundColor Yellow
    Pause
    exit 1
}

# Step 3: Configure PowerShell 7 as default in Windows Terminal
Write-Host "Configuring PowerShell 7 as default terminal..." -ForegroundColor Cyan
$settingsPath = "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json"
if (-not (Test-Path -Path $settingsPath)) {
    Write-Host "Error: Windows Terminal settings file not found at $settingsPath" -ForegroundColor Red
    Pause
    exit 1
}

try {
    $settingsContent = Get-Content -Path $settingsPath | ConvertFrom-Json -ErrorAction Stop
    $ps7Profile = $settingsContent.profiles.list | Where-Object { $_.name -eq "PowerShell" }
    if (-not $ps7Profile) {
        Write-Host "Error: PowerShell 7 profile not found in Windows Terminal settings." -ForegroundColor Red
        Write-Host "Ensure PowerShell 7 is registered in Windows Terminal (run 'wt -p \"PowerShell\"' to check)." -ForegroundColor Yellow
        Pause
        exit 1
    }

    # Check if PowerShell 7 is already the default profile
    if ($settingsContent.defaultProfile -eq $ps7Profile.guid) {
        Write-Host "PowerShell 7 is already set as the default terminal." -ForegroundColor Yellow
        Write-Host "No changes needed. Exiting..." -ForegroundColor Yellow
        Pause
        exit 0
    }

    # Set PowerShell 7 as default
    $settingsContent.defaultProfile = $ps7Profile.guid
    $updatedSettings = $settingsContent | ConvertTo-Json -Depth 100
    Set-Content -Path $settingsPath -Value $updatedSettings -ErrorAction Stop
    Write-Host "Default profile updated to PowerShell 7." -ForegroundColor Green
}
catch {
    Write-Host "Error: Failed to configure Windows Terminal settings." -ForegroundColor Red
    Write-Host "Details: $($_.Exception.Message)" -ForegroundColor Yellow
    Pause
    exit 1
}

# Final confirmation
Write-Host "PowerShell 7 set as default terminal successfully!" -ForegroundColor Green
Write-Host "Open Windows Terminal to verify. Press any key to exit." -ForegroundColor White
Pause
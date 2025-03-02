# Ensure script runs with administrative privileges
if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Host "Error: This script requires administrative privileges." -ForegroundColor Red
    Write-Host "Please run PowerShell as an administrator and try again." -ForegroundColor Yellow
    Pause
    exit 1
}

# Define constants
$RegistryBackupPath = "$env:USERPROFILE\Desktop\RegistryBackup.reg"
$ContextMenuRegPath = "HKCU:\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32"

# Step 0: Check if running on Windows 11
$osVersion = [System.Environment]::OSVersion.Version
if ($osVersion.Major -ne 10 -or $osVersion.Build -lt 22000) {
    Write-Host "Error: This tweak is designed for Windows 11 only." -ForegroundColor Red
    Write-Host "Current OS version: $($osVersion.Major).$($osVersion.Minor) Build $($osVersion.Build)" -ForegroundColor Yellow
    Write-Host "Exiting script as no changes are needed for this system." -ForegroundColor Yellow
    Pause
    exit 0
}

# Step 1: Backup the registry
Write-Host "Backing up the registry..." -ForegroundColor Cyan
try {
    reg export "HKEY_CURRENT_USER\Software\Classes\CLSID" $RegistryBackupPath /y 2>$null
    if ($LASTEXITCODE -ne 0) { throw "Registry backup failed." }
    Write-Host "Registry backup saved to: $RegistryBackupPath" -ForegroundColor Green
}
catch {
    Write-Host "Error: Failed to back up the registry." -ForegroundColor Red
    Write-Host "Details: $($_.Exception.Message)" -ForegroundColor Yellow
    Write-Host "Please ensure you have sufficient permissions." -ForegroundColor Yellow
    Pause
    exit 1
}
Pause

# Step 2: Add registry key to restore classic context menu
Write-Host "Restoring classic right-click context menu..." -ForegroundColor Cyan
try {
    if (-not (Test-Path $ContextMenuRegPath)) {
        New-Item -Path "HKCU:\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}" -Force | Out-Null
        New-Item -Path $ContextMenuRegPath -Force | Out-Null
    }
    Set-ItemProperty -Path $ContextMenuRegPath -Name "(Default)" -Value "" -Type String -Force -ErrorAction Stop
    Write-Host "Registry updated successfully." -ForegroundColor Green
}
catch {
    Write-Host "Error: Failed to update registry." -ForegroundColor Red
    Write-Host "Details: $($_.Exception.Message)" -ForegroundColor Yellow
    Pause
    exit 1
}

# Step 3: Restart Windows Explorer
Write-Host "Restarting Windows Explorer to apply changes..." -ForegroundColor Cyan
try {
    Stop-Process -Name "explorer" -Force -ErrorAction Stop
    Start-Sleep -Seconds 1
    Start-Process "explorer.exe" -ErrorAction Stop
    Write-Host "Windows Explorer restarted successfully." -ForegroundColor Green
}
catch {
    Write-Host "Error: Failed to restart Windows Explorer." -ForegroundColor Red
    Write-Host "Details: $($_.Exception.Message)" -ForegroundColor Yellow
    Pause
    exit 1
}

# Final confirmation
Write-Host "Classic context menu restored successfully!" -ForegroundColor Green
Write-Host "Right-click anywhere to verify the change. Press any key to exit." -ForegroundColor White
Pause
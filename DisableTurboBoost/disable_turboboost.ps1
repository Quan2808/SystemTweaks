# Ensure script runs with administrative privileges
if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Host "Error: This script requires administrative privileges." -ForegroundColor Red
    Write-Host "Please run PowerShell as an administrator and try again." -ForegroundColor Yellow
    Pause
    exit 1
}

# Define constants
$RegistryBackupPath = "$env:USERPROFILE\Desktop\RegistryBackup.reg"
$TurboBoostRegPath = "HKLM:\SYSTEM\ControlSet001\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\be337238-0d82-4146-a960-4f3749d470c7"

# Step 1: Backup the registry
Write-Host "Backing up the registry..." -ForegroundColor Cyan
try {
    reg export "HKEY_LOCAL_MACHINE\SYSTEM" $RegistryBackupPath /y 2>$null
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

# Step 2: Modify registry to expose Turbo Boost settings
Write-Host "Modifying registry to disable Turbo Boost..." -ForegroundColor Cyan
try {
    Set-ItemProperty -Path $TurboBoostRegPath -Name "Attributes" -Value 2 -Type DWord -Force -ErrorAction Stop
    Write-Host "Turbo Boost registry settings updated successfully." -ForegroundColor Green
}
catch {
    Write-Host "Error: Failed to modify registry." -ForegroundColor Red
    Write-Host "Details: $($_.Exception.Message)" -ForegroundColor Yellow
    Pause
    exit 1
}

# Step 3: Disable Processor Performance Boost Mode in power settings
Write-Host "Configuring power settings..." -ForegroundColor Cyan
try {
    powercfg /setacvalueindex SCHEME_CURRENT SUB_PROCESSOR PERFBOOSTMODE 0
    powercfg /setdcvalueindex SCHEME_CURRENT SUB_PROCESSOR PERFBOOSTMODE 0
    powercfg /setactive SCHEME_CURRENT
    if ($LASTEXITCODE -ne 0) { throw "Power configuration failed." }
    Write-Host "Processor Performance Boost Mode disabled for both 'On battery' and 'Plugged in'." -ForegroundColor Green
}
catch {
    Write-Host "Error: Failed to configure power settings." -ForegroundColor Red
    Write-Host "Details: $($_.Exception.Message)" -ForegroundColor Yellow
    Pause
    exit 1
}

# Final confirmation
Write-Host "Configuration completed successfully!" -ForegroundColor Green
Write-Host "Turbo Boost is now disabled. Press any key to exit." -ForegroundColor White
Pause
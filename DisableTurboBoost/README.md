# Disable Turbo Boost

Scripts to disable Intel Turbo Boost on Windows, reducing CPU heat and power usage by modifying registry settings and power configurations. Ideal for users prioritizing stability over peak performance.

## Files

- **`disable_turboboost.bat`**: Batch script for Command Prompt execution.
- **`disable_turboboost.ps1`**: PowerShell script with enhanced error handling, colored output, and GitHub execution support.

## Prerequisites

- **OS**: Windows 10 or 11.
- **Privileges**: Administrative rights required.
- **PowerShell**: Version 5.1+ (7.x recommended for `pwsh`).

## What It Does

1. Backs up the registry to `Desktop\RegistryBackup.reg`.
2. Modifies `HKLM:\SYSTEM\ControlSet001\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\be337238-0d82-4146-a960-4f3749d470c7` to expose Turbo Boost settings.
3. Disables "Processor Performance Boost Mode" for both "On battery" and "Plugged in" in the current power plan.

## Usage

### 1. PowerShell Script (`disable_turboboost.ps1`)

#### a. Local Execution

1. Download `disable_turboboost.ps1` from this repository.
2. Open PowerShell as administrator:
   - Press `Win + S`, type `pwsh`, right-click, and select "Run as administrator".
3. Navigate to the script directory:
   ```powershell
   cd C:\path\to\DisableTurboBoost
   ```
4. Run the script:
   ```powershell
   .\disable_turboboost.ps1
   ```

#### b. Direct Execution with `iex` (Caution: Less Secure)

1. Open PowerShell as administrator.
2. Run:
   ```powershell
   irm "https://raw.githubusercontent.com/Quan2808/SystemTweaks/main/DisableTurboBoost/disable_turboboost.ps1" | iex
   ```
   - `irm` downloads the script, and `iex` executes it.
   - Replace `main` with your branch (e.g., `disable-turboboost`) if needed.
   - **Security Note**: Always review the script at the URL before execution.

### 2. Batch Script (`disable_turboboost.bat`)

1. Download `disable_turboboost.bat` from this repository.
2. Right-click the file and select **"Run as administrator"**.
3. Follow the on-screen prompts.

## Script Functionality

Both scripts:

- Verify administrative privileges, exiting with an error if absent.
- Back up `HKEY_LOCAL_MACHINE\SYSTEM` to `Desktop\RegistryBackup.reg`.
- Set registry `Attributes` to `2` at the specified key.
- Use `powercfg` to disable **Processor Performance Boost Mode**.
- Confirm Turbo Boost is disabled.

## Re-enabling Turbo Boost

- ### Option 1: Restore Registry

  - 1.  Double-click `RegistryBackup.reg` on your Desktop.
  - 2.  Follow the prompts to restore.
  - 3.  Restart your system if needed.

- ### Option 2: Manual Power Options

  - 1.  Open **Control Panel > Power Options > Change plan settings > Change advanced power settings**.
  - 2.  Under **"Processor power management"**, set **"Processor performance boost mode"** to **"Enabled"** for both **"On battery"** and **"Plugged in"**.
  - 3.  Apply changes.

## Notes

- Disabling Turbo Boost may reduce performance for CPU-intensive tasks.
- Ensure the active power plan supports these changes (`powercfg /getactivescheme`).

## Troubleshooting

- **Script fails**: Ensure you run it as administrator.
- **PowerShell blocks execution**: Set execution policy:
  ```powershell
  Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy Bypass -Force
  ```
- **No effect**: Confirm your CPU supports Turbo Boost and the registry key exists.

## Example Output

### `disable_turboboost.bat`

```
Backing up the registry before making changes...
Registry has been successfully backed up to your Desktop as RegistryBackup.reg.
Modifying registry to disable Turbo Boost...
Turbo Boost registry settings updated successfully.
Configuring power settings to disable Processor Performance Boost Mode...
Processor Performance Boost Mode has been disabled for both 'On battery' and 'Plugged in'.
Configuration completed successfully!
```

### `disable_turboboost.ps1`

```
Backing up the registry...
Registry backup saved to: C:\Users\YourUsername\Desktop\RegistryBackup.reg
Modifying registry to disable Turbo Boost...
Turbo Boost registry settings updated successfully.
Configuring power settings...
Processor Performance Boost Mode disabled for both 'On battery' and 'Plugged in'.
Configuration completed successfully!
```

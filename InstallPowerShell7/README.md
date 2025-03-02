# Install PowerShell 7

Scripts to install PowerShell 7 on Windows 10 or 11, providing a modern PowerShell experience with improved features over the default PowerShell 5.1.

## Files

- **`install_pwsh7.bat`**: Batch script for Command Prompt execution.
- **`install_pwsh7.ps1`**: PowerShell script with enhanced error handling and GitHub execution support.

## Prerequisites

- **OS**: Windows 10 or 11.
- **Privileges**: Administrative rights required.
- **Internet**: Required to download the installer.

## What It Does

1. Checks if PowerShell 7 is already installed, exiting if found.
2. Downloads the latest PowerShell 7 MSI installer from GitHub.
3. Installs PowerShell 7 silently and cleans up the installer file.

## Usage

### 1. PowerShell Script (`install_pwsh7.ps1`)

#### a. Local Execution

1. Download `install_pwsh7.ps1` from this repository.
2. Open PowerShell as administrator:
   - Press `Win + S`, type `powershell`, right-click, select "Run as administrator".
3. Navigate to the script directory:
   ```powershell
   cd C:\path\to\InstallPowerShell7
   ```
4. Run the script:
   ```powershell
   .\install_pwsh7.ps1
   ```

#### b. Direct Execution with `iex` (Caution: Less Secure)

1. Open PowerShell as administrator.
2. Run:
   ```powershell
   irm "https://raw.githubusercontent.com/Quan2808/SystemTweaks/main/InstallPowerShell7/install_pwsh7.ps1" | iex
   ```
   - `irm` downloads the script, and `iex` executes it.
   - Replace `main` with your branch (e.g., `install-pwsh7`) if needed.
   - **Security Note**: Always review the script at the URL before execution.

### 2. Batch Script (`install_pwsh7.bat`)

1. Download `install_pwsh7.bat` from this repository.
2. Right-click the file and select **"Run as administrator"**.
3. Follow the on-screen prompts.

## Script Functionality

Both scripts:

- Verify administrative privileges, exiting with an error if absent.
- Check for existing PowerShell 7 installation, exiting if found.
- Download the latest PowerShell 7 MSI from GitHub.
- Install silently and remove the installer file.
- Confirm installation success.

## Troubleshooting

- **Script fails**: Ensure you run as administrator and have an internet connection.
- **Download fails**: Check your network or try again later (GitHub API may be temporarily unavailable).
- **Installation fails**: Verify free disk space and admin rights.

## Example Output

### `install_pwsh7.bat`

```
Checking for existing PowerShell 7 installation...
PowerShell 7 not found. Proceeding with installation...
Downloading PowerShell 7 installer...
Installer downloaded to: C:\Users\YourUsername\AppData\Local\Temp\PowerShell7.msi
Installing PowerShell 7...
PowerShell 7 installed successfully!
Installer file cleaned up.
PowerShell 7 installation completed!
```

### `install_pwsh7.ps1`

```
Checking for existing PowerShell 7 installation...
PowerShell 7 not found. Proceeding with installation...
Downloading PowerShell 7 installer...
Installer downloaded to: C:\Users\YourUsername\AppData\Local\Temp\PowerShell7.msi
Installing PowerShell 7...
PowerShell 7 installed successfully!
Installer file cleaned up.
PowerShell 7 installation completed!
```

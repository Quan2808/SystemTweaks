# Install VSCodium

Scripts to download and install VSCodium on Windows 10 or 11 with Start Menu and Desktop shortcuts, providing an open-source alternative to Visual Studio Code with telemetry disabled.

## Files

- **`install_vscodium.bat`**: Batch script for Command Prompt execution.
- **`install_vscodium.ps1`**: PowerShell script with enhanced error handling and GitHub execution support.

## Prerequisites

- **OS**: Windows 10 or 11.
- **Privileges**: Administrative rights required.
- **Internet**: Required to download the installer.

## What It Does

1. Checks if VSCodium is fully installed (including Start Menu and Desktop shortcuts), exiting if complete.
2. Downloads the latest VSCodium installer from GitHub if needed.
3. Installs VSCodium silently with Start Menu and Desktop shortcuts, cleaning up the installer file.

## Usage

### 1. PowerShell Script (`install_vscodium.ps1`)

#### a. Local Execution

1. Download `install_vscodium.ps1` from this repository.
2. Open PowerShell as administrator:
   - Press `Win + S`, type `powershell`, right-click, select "Run as administrator".
3. Navigate to the script directory:
   ```powershell
   cd C:\path\to\InstallVSCodium
   ```
4. Run the script:
   ```powershell
   .\install_vscodium.ps1
   ```

#### b. Direct Execution with `iex` (Caution: Less Secure)

1. Open PowerShell as administrator.
2. Run:
   ```powershell
   irm "https://raw.githubusercontent.com/Quan2808/SystemTweaks/main/InstallVSCodium/install_vscodium.ps1" | iex
   ```
   - `irm` downloads the script, and `iex` executes it.
   - Replace `main` with your branch (e.g., `install-vscodium`) if needed.
   - **Security Note**: Always review the script at the URL before execution.

### 2. Batch Script (`install_vscodium.bat`)

1. Download `install_vscodium.bat` from this repository.
2. Right-click the file and select **"Run as administrator"**.
3. Follow the on-screen prompts.

## Script Functionality

Both scripts:

- Verify administrative privileges, exiting with an error if absent.
- Check for existing VSCodium installation with shortcuts, reinstalling if incomplete.
- Download the latest VSCodium installer from GitHub if needed.
- Install silently with Start Menu and Desktop shortcuts, then remove the installer file.
- Confirm installation success.

## Troubleshooting

- **Script fails**: Ensure you run as administrator and have an internet connection.
- **Download fails**: Check your network or try again later (GitHub API may be temporarily unavailable).
- **Installation fails**: Verify free disk space and admin rights.

## Example Output

### `install_vscodium.bat`

```
Checking for existing VSCodium installation...
VSCodium not found or not fully installed. Proceeding with installation...
Downloading VSCodium installer...
Installer downloaded to: C:\Users\YourUsername\AppData\Local\Temp\VSCodiumSetup.exe
Installing VSCodium...
VSCodium installed successfully!
Installer file cleaned up.
VSCodium installation completed!
```

### `install_vscodium.ps1`

```
Checking for existing VSCodium installation...
VSCodium not found or not fully installed. Proceeding with installation...
Downloading VSCodium installer...
Installer downloaded to: C:\Users\YourUsername\AppData\Local\Temp\VSCodiumSetup.exe
Installing VSCodium...
VSCodium installed successfully at: C:\Program Files\VSCodium\VSCodium.exe
Installer file cleaned up.
VSCodium installation completed!
```

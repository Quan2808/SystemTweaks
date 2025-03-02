# Set PowerShell 7 Default

Scripts to set PowerShell 7 as the default terminal in Windows Terminal on Windows 10 or 11, replacing the default PowerShell 5.1. Requires PowerShell 7 to be pre-installed.

## Files

- **`set_pwsh7_default.bat`**: Batch script for Command Prompt execution.
- **`set_pwsh7_default.ps1`**: PowerShell script with enhanced error handling and GitHub execution support.

## Prerequisites

- **OS**: Windows 10 or 11.
- **Privileges**: Administrative rights required.
- **PowerShell 7**: Must be installed (download from https://github.com/PowerShell/PowerShell/releases if needed).
- **Windows Terminal**: Must be installed (available via Microsoft Store or GitHub).

## What It Does

1. Verifies PowerShell 7 is installed, exiting if not.
2. Confirms Windows Terminal is installed, exiting if not.
3. Checks if PowerShell 7 is already the default profile, exiting if true.
4. Configures Windows Terminal to use PowerShell 7 as the default profile if needed.

## Usage

### 1. PowerShell Script (`set_pwsh7_default.ps1`)

#### a. Local Execution

1. Download `set_pwsh7_default.ps1` from this repository.
2. Open PowerShell as administrator:
   - Press `Win + S`, type `powershell`, right-click, select "Run as administrator".
3. Navigate to the script directory:
   ```powershell
   cd C:\path\to\SetPowerShell7Default
   ```
4. Run the script:
   ```powershell
   .\set_pwsh7_default.ps1
   ```

#### b. Direct Execution with `iex` (Caution: Less Secure)

1. Open PowerShell as administrator.
2. Run:
   ```powershell
   irm "https://raw.githubusercontent.com/Quan2808/SystemTweaks/main/SetPowerShell7Default/set_pwsh7_default.ps1" | iex
   ```
   - `irm` downloads the script, and `iex` executes it.
   - Replace `main` with your branch (e.g., `set-pwsh7-default`) if needed.
   - **Security Note**: Always review the script at the URL before execution.

### 2. Batch Script (`set_pwsh7_default.bat`)

1. Download `set_pwsh7_default.bat` from this repository.
2. Right-click the file and select **"Run as administrator"**.
3. Follow the on-screen prompts.

## Script Functionality

Both scripts:

- Verify administrative privileges, exiting with an error if absent.
- Check for PowerShell 7 installation, exiting if not found.
- Confirm Windows Terminal installation, exiting if not present.
- Check if PowerShell 7 is already the default profile, skipping if true.
- Update Windows Terminal settings to set PowerShell 7 as the default profile if needed.
- Confirm success.

## Troubleshooting

- **Script fails**: Ensure you run as administrator.
- **PowerShell 7 not found**:
  - Install it automatic from **[Install PowerShell 7](InstallPowerShell7/README.md)**.
  - Install it manually from https://github.com/PowerShell/PowerShell/releases.
- **Windows Terminal not detected**: Install it from Microsoft Store or GitHub.
- **Profile not updated**: Verify PowerShell 7 is registered in Windows Terminal (wt -p "PowerShell").

## Example Output

### `set_pwsh7_default.bat`

```
Checking for PowerShell 7 installation...
PowerShell 7 found.
Version: 7.x.x
Checking for Windows Terminal...
Configuring PowerShell 7 as default terminal...
PowerShell 7 is already set as the default terminal.
No changes needed.
PowerShell 7 set as default terminal successfully!
```

_(or)_

```
Checking for PowerShell 7 installation...
PowerShell 7 found.
Version: 7.x.x
Checking for Windows Terminal...
Configuring PowerShell 7 as default terminal...
Default profile updated to PowerShell 7.
PowerShell 7 set as default terminal successfully!
```

### `set_pwsh7_default.ps1`

```
Checking for PowerShell 7 installation...
PowerShell 7 found at: C:\Program Files\PowerShell\7\pwsh.exe
Version: 7.x.x
Checking for Windows Terminal...
Configuring PowerShell 7 as default terminal...
PowerShell 7 is already set as the default terminal.
No changes needed. Exiting...
```

_(or)_

```
Checking for PowerShell 7 installation...
PowerShell 7 found at: C:\Program Files\PowerShell\7\pwsh.exe
Version: 7.x.x
Checking for Windows Terminal...
Configuring PowerShell 7 as default terminal...
Default profile updated to PowerShell 7.
PowerShell 7 set as default terminal successfully!
```

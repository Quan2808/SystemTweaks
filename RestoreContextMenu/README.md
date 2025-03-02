# Restore Context Menu

Scripts to restore the classic right-click context menu in Windows 11, reverting from the modern menu introduced in Windows 11 to the full-featured version from Windows 10. Ideal for users preferring the traditional interface.

## Files

- **`restore_context_menu.bat`**: Batch script for Command Prompt execution.
- **`restore_context_menu.ps1`**: PowerShell script with enhanced error handling, colored output, and GitHub execution support.

## Prerequisites

- **OS**: Windows 11 (script exits if not detected).
- **Privileges**: Administrative rights required.
- **PowerShell**: Version 5.1+ (7.x recommended for `pwsh`).

## What It Does

1. Verifies the system is running Windows 11, exiting if not.
2. Backs up the registry to `Desktop\RegistryBackup.reg`.
3. Modifies `HKCU:\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32` to restore the classic context menu.
4. Restarts Windows Explorer to apply changes.

## Usage

### 1. PowerShell Script (`restore_context_menu.ps1`)

#### a. Local Execution

1. Download `restore_context_menu.ps1` from this repository.
2. Open PowerShell as administrator:
   - Press `Win + S`, type `pwsh`, right-click, and select "Run as administrator".
3. Navigate to the script directory:
   ```powershell
   cd C:\path\to\RestoreContextMenu
   ```
4. Run the script:
   ```powershell
   .\restore_context_menu.ps1
   ```

#### b. Direct Execution with `iex` (Caution: Less Secure)

1. Open PowerShell as administrator.
2. Run:

   ```powershell
   irm "https://raw.githubusercontent.com/Quan2808/SystemTweaks/main/RestoreContextMenu/restore_context_menu.ps1" | iex
   ```

   - `irm` downloads the script, and `iex` executes it.
   - Replace `main` with your branch (e.g., `restore-context-menu`) if needed.
   - **Security Note**: Always review the script at the URL before execution.

### 2. Batch Script (`restore_context_menu.bat`)

1. Download `restore_context_menu.bat` from this repository.
2. Right-click the file and select **"Run as administrator"**.
3. Follow the on-screen prompts.

## Script Functionality

Both scripts:

- Verify administrative privileges, exiting with an error if absent.
- Check for Windows 11, exiting if not detected.
- Back up `HKEY_CURRENT_USER\Software\Classes\CLSID to Desktop\RegistryBackup.reg`.
- Set registry key `{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32` to restore the classic menu.
- Restart Windows Explorer and confirm the change.

## Re-enabling Modern Context Menu

- ### Option 1: Restore Registry

  - 1.  Double-click `RegistryBackup.reg` on your Desktop.
  - 2.  Follow the prompts to restore.
  - 3.  Restart Windows Explorer (`taskkill /f /im explorer.exe && start explorer.exe`) or reboot.

- ### Option 2: Manual Registry Edit

  - 1.  Open `regedit` as administrator.
  - 2.  Navigate to `HKEY_CURRENT_USER\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}`.
  - 3.  Delete the key and its subkeys.
  - 4.  Restart Windows Explorer (`taskkill /f /im explorer.exe && start explorer.exe`).

## Notes

- This tweak only applies to Windows 11; it exits on other OS versions.
- The classic menu may increase right-click response time slightly due to additional options.

## Troubleshooting

- **Script fails**: Ensure you run it as administrator.
- **PowerShell blocks execution**: Set execution policy:
  ```powershell
  Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy Bypass -Force
  ```
- **No effect**: Confirm you’re on Windows 11 (Build 22000+) and Explorer restarted successfully.

## Example Output

### `restore_context_menu.bat`

```
Backing up the registry...
Registry backup saved to: C:\Users\YourUsername\Desktop\RegistryBackup.reg
Restoring classic right-click context menu...
Registry updated successfully.
Restarting Windows Explorer to apply changes...
Windows Explorer restarted successfully.
Classic context menu restored successfully!
```

### `restore_context_menu.ps1`

```
Backing up the registry...
Registry backup saved to: C:\Users\YourUsername\Desktop\RegistryBackup.reg
Restoring classic right-click context menu...
Registry updated successfully.
Restarting Windows Explorer to apply changes...
Windows Explorer restarted successfully.
Classic context menu restored successfully!
```

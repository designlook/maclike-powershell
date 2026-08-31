# maclike-powershell

Small PowerShell helpers for people who want familiar macOS-style terminal commands on Windows.

## Features

- `open .`, `open file.txt`, and `open https://example.com`
- `rm -r`, `rm -f`, `rm -rf`, and `rm -fr`
- Notes for `cd ~` (already built into PowerShell)
- Optional GNU Nano installation
- Optional Caps Lock → Ctrl and Left Alt → Ctrl keyboard remap

> [!WARNING]
> `rm -rf` and `rm -fr` permanently delete files and directories. They do not use the Recycle Bin.

## Requirements

- Windows
- PowerShell 7 or newer

Check your version:

```powershell
$PSVersionTable.PSVersion
```

In Windows Terminal, choose **PowerShell**, not **Windows PowerShell**.

## Install

Clone or download this repository, open PowerShell in its directory, and run:

```powershell
Set-ExecutionPolicy -Scope Process Bypass
.\install.ps1
```

Open a new PowerShell tab after installation.

## Usage

### Open files, folders, and URLs

```powershell
open .
open README.md
open https://example.com
```

### Home directory

PowerShell supports this natively:

```powershell
cd ~
```

### Remove files and directories

```powershell
rm file.txt
rm -r folder
rm -rf folder
rm -fr folder
```

The native PowerShell spelling remains available as:

```powershell
Remove-Item folder -Recurse -Force
```

### Install Nano

```powershell
winget install --exact --id GNU.Nano
```

Restart PowerShell, then run:

```powershell
nano README.md
```

## Optional keyboard remap

The included registry file maps:

- Caps Lock → Left Ctrl
- Left Alt → Left Ctrl

> [!CAUTION]
> The Windows `Scancode Map` is a single system-wide value. Applying this file
> replaces any existing registry-based keyboard remaps. It requires administrator
> approval and a Windows restart.

Check for an existing map first:

```powershell
Get-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Keyboard Layout' -Name 'Scancode Map' -ErrorAction SilentlyContinue
```

If that command returns an existing `Scancode Map`, do not continue until you
have backed it up.

Apply the remap by double-clicking:

```text
keyboard/remap-caps-left-alt-to-control.reg
```

Approve the Registry Editor and administrator prompts, then restart Windows.

To restore Windows defaults, double-click:

```text
keyboard/restore-default-keyboard.reg
```

The restore file removes the entire `Scancode Map`, including mappings created
by other tools. Restart Windows afterward.

## Uninstall

Open your PowerShell profile:

```powershell
notepad $PROFILE.CurrentUserAllHosts
```

Remove the section marked `maclike-powershell`, then delete
`MacLike.PowerShell.ps1` from the same directory as your profile.

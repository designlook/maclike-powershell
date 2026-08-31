# maclike-powershell

Small PowerShell helpers for people who want familiar macOS-style terminal commands on Windows.

## Features

- `open .`, `open file.txt`, and `open https://example.com`
- `rm -r`, `rm -f`, `rm -rf`, and `rm -fr`
- Notes for `cd ~` (already built into PowerShell)
- Optional GNU Nano installation

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

## Uninstall

Open your PowerShell profile:

```powershell
notepad $PROFILE.CurrentUserAllHosts
```

Remove the section marked `maclike-powershell`, then delete
`MacLike.PowerShell.ps1` from the same directory as your profile.

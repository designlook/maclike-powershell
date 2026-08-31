$ErrorActionPreference = 'Stop'

$sourcePath = Join-Path $PSScriptRoot 'MacLike.PowerShell.ps1'
$profilePath = $PROFILE.CurrentUserAllHosts
$profileDirectory = Split-Path -Parent $profilePath
$installedHelperPath = Join-Path $profileDirectory 'MacLike.PowerShell.ps1'

if (-not (Test-Path -LiteralPath $sourcePath)) {
    throw "Helper file not found: $sourcePath"
}

New-Item -ItemType Directory -Path $profileDirectory -Force | Out-Null

$sourceFullPath = [System.IO.Path]::GetFullPath($sourcePath)
$destinationFullPath = [System.IO.Path]::GetFullPath($installedHelperPath)

if ($sourceFullPath -ne $destinationFullPath) {
    Copy-Item -LiteralPath $sourcePath -Destination $installedHelperPath -Force
}

if (-not (Test-Path -LiteralPath $profilePath)) {
    New-Item -ItemType File -Path $profilePath -Force | Out-Null
}

$marker = '# >>> maclike-powershell >>>'
$profileContent = Get-Content -LiteralPath $profilePath -Raw

if ($profileContent -notmatch [regex]::Escape($marker)) {
    $loaderBlock = @'
# >>> maclike-powershell >>>
. "$PSScriptRoot\MacLike.PowerShell.ps1"
# <<< maclike-powershell <<<
'@

    if ((Get-Item -LiteralPath $profilePath).Length -gt 0) {
        Add-Content -LiteralPath $profilePath -Value ''
    }

    Add-Content -LiteralPath $profilePath -Value $loaderBlock
}

Write-Host 'maclike-powershell installed successfully.' -ForegroundColor Green
Write-Host "Profile: $profilePath"
Write-Host 'Open a new PowerShell tab, then try: open .'

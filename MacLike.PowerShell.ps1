Set-StrictMode -Version Latest

function open {
    [CmdletBinding()]
    param(
        [Parameter(Position = 0, ValueFromRemainingArguments)]
        [string[]] $Path = @('.')
    )

    foreach ($item in $Path) {
        Start-Process $item
    }
}

# A function must replace PowerShell's built-in rm alias before Unix-style
# combined flags such as -rf can be interpreted.
Remove-Item Alias:rm -Force -ErrorAction SilentlyContinue

function rm {
    [CmdletBinding()]
    param(
        [Parameter(Position = 0, ValueFromRemainingArguments)]
        [object[]] $Arguments
    )

    $recurse = $false
    $force = $false
    $paths = [System.Collections.Generic.List[string]]::new()
    $parseOptions = $true

    foreach ($argumentValue in $Arguments) {
        $argument = [string] $argumentValue

        if ($parseOptions -and $argument -eq '--') {
            $parseOptions = $false
            continue
        }

        if ($parseOptions -and $argument -match '^-[rf]+$') {
            if ($argument.Contains('r')) { $recurse = $true }
            if ($argument.Contains('f')) { $force = $true }
            continue
        }

        if ($parseOptions -and $argument -eq '-Recurse') {
            $recurse = $true
            continue
        }

        if ($parseOptions -and $argument -eq '-Force') {
            $force = $true
            continue
        }

        if ($parseOptions -and $argument.StartsWith('-')) {
            throw "rm: unsupported option '$argument'"
        }

        $paths.Add($argument)
    }

    if ($paths.Count -eq 0) {
        throw 'rm: missing path'
    }

    $removeArguments = @{
        Path = $paths.ToArray()
        Recurse = $recurse
        Force = $force
    }

    # Like Unix rm -f, ignore paths that do not exist when force is enabled.
    if ($force) {
        $removeArguments.ErrorAction = 'SilentlyContinue'
    }

    Remove-Item @removeArguments
}

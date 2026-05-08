#Requires -Version 7
<#
.SYNOPSIS
    Starts TcHaxx.Snappy.CLI in verify mode for the protobuf unit tests.

.DESCRIPTION
    Launches the snappy verifier against the repo's verified snapshot folder so
    a running TwinCAT PLC test session can connect and have its results checked.
    Run this BEFORE starting the PLC unit tests in TwinCAT.

.PARAMETER Port
    AMS port the snappy server listens on. Defaults to 25000.

.PARAMETER LogLevel
    Minimum log event level (Verbose, Debug, Information, Warning, Error, Fatal).

.PARAMETER FloatingPointPrecision
    Decimal places used when comparing REAL/LREAL values.

.PARAMETER CompactDiff
    Compact diff output. Defaults to true.

.EXAMPLE
    .\start-tchaxx-snappy.ps1

.EXAMPLE
    .\start-tchaxx-snappy.ps1 -LogLevel Debug -Port 25000
#>
[CmdletBinding()]
param(
    [int]$Port = 25000,
    [ValidateSet('Verbose', 'Debug', 'Information', 'Warning', 'Error', 'Fatal')]
    [string]$LogLevel = 'Information',
    [int]$FloatingPointPrecision = 5,
    [bool]$CompactDiff = $true
)

$ErrorActionPreference = 'Stop'

$cli = Get-Command 'TcHaxx.Snappy.CLI' -ErrorAction SilentlyContinue
if (-not $cli) {
    throw "TcHaxx.Snappy.CLI not found on PATH. Install it with: dotnet tool install --global TcHaxx.Snappy.CLI"
}

$verifiedDir = Join-Path $PSScriptRoot 'src\protobuf\protobuf\__TESTs\__snappy-verified'
if (-not (Test-Path -LiteralPath $verifiedDir)) {
    throw "Verified snapshot directory not found: $verifiedDir"
}

$cliArgs = @(
    'verify'
    '--dir', $verifiedDir
    '--port', $Port
    '--fpp', $FloatingPointPrecision
    '--log-level', $LogLevel
    '--compact-diff', $CompactDiff.ToString().ToLowerInvariant()
)

Write-Host "Starting $($cli.Source) $($cliArgs -join ' ')" -ForegroundColor Cyan
& $cli.Source @cliArgs
exit $LASTEXITCODE

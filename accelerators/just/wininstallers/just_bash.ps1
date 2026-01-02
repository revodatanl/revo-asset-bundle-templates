$ErrorActionPreference = "Stop"

function PathRefresh {
    $machinePath = [System.Environment]::GetEnvironmentVariable("Path", "Machine")
    $userPath    = [System.Environment]::GetEnvironmentVariable("Path", "User")
    $env:Path    = "$machinePath;$userPath"
}

function ParseSemVer {
  param([Parameter(Mandatory=$true)][string]$VersionText)

  # Accept "just 1.25.0" or "1.25.0"
  $m = [regex]::Match($VersionText, '(\d+)\.(\d+)\.(\d+)')
  if (-not $m.Success) { throw "Could not parse version from: $VersionText" }

  return [version]::new(
    [int]$m.Groups[1].Value,
    [int]$m.Groups[2].Value,
    [int]$m.Groups[3].Value
  )
}

function RequireWinget {
  if (-not (Get-Command winget -ErrorAction SilentlyContinue)) {
    throw "winget not found. Install App Installer (winget) or install dependencies manually, then rerun."
  }
}

function EnsureJustMinVersion {
  param([Parameter(Mandatory=$true)][version]$MinVersion)

  Write-Output "Checking `just` command existence..."
  if (-not (Get-Command just -ErrorAction SilentlyContinue)) {
    Write-Output "just not found, refreshing PATH..."
    PathRefresh
  }

  if (-not (Get-Command just -ErrorAction SilentlyContinue)) {
    Write-Output "just not found, installing via winget..."
    RequireWinget
    winget install --id Casey.Just --source winget --accept-package-agreements --accept-source-agreements
    PathRefresh
  }

  if (-not (Get-Command just -ErrorAction SilentlyContinue)) {
    throw "just is not available on PATH after installation."
  }

  $raw = (just --version) 2>$null
  $current = ParseSemVer $raw

  Write-Output "Detected just version: $current (min required: $MinVersion)"

  if ($current -lt $MinVersion) {
    Write-Output "just is older than required, upgrading via winget..."
    RequireWinget

    # Prefer upgrade, fall back to install if upgrade is not supported for some reason
    $upgradeOk = $true
    try {
      winget upgrade --id Casey.Just --source winget --accept-package-agreements --accept-source-agreements
    } catch {
      $upgradeOk = $false
    }

    if (-not $upgradeOk) {
      winget install --id Casey.Just --source winget --accept-package-agreements --accept-source-agreements
    }

    PathRefresh

    $raw2 = (just --version) 2>$null
    $current2 = ParseSemVer $raw2
    Write-Output "Detected just version after upgrade: $current2"

    if ($current2 -lt $MinVersion) {
      throw "just version is still too old after upgrade. Required: $MinVersion, found: $current2"
    }
  }
}

function Get-GitBashPath {
    $candidates = @(
        "$env:ProgramFiles\Git\bin\bash.exe",
        "$env:ProgramFiles\Git\usr\bin\bash.exe",
        "$env:ProgramFiles(x86)\Git\bin\bash.exe",
        "$env:ProgramFiles(x86)\Git\usr\bin\bash.exe",
        "$env:LOCALAPPDATA\Programs\Git\bin\bash.exe",
        "$env:LOCALAPPDATA\Programs\Git\usr\bin\bash.exe"
    ) | Where-Object { $_ -and (Test-Path $_) }

    if (-not $candidates) { throw "Git Bash not found. Install Git for Windows." }
    return $candidates[0]
}

function EnsureGitBash {
    Write-Output "Checking Git Bash availability..."

    # Reject WSL bash (System32)
    $bashCmd = Get-Command bash.exe -ErrorAction SilentlyContinue
    if ($bashCmd -and ($bashCmd.Source -ieq "$env:WINDIR\System32\bash.exe")) {
        Write-Output "Found WSL bash.exe on PATH ($($bashCmd.Source)), not Git Bash. Ignoring."
        $bashCmd = $null
    }

    $gitBashPath = Get-GitBashPath

    if (-not $gitBashPath) {
        Write-Output "Git Bash not found, installing Git for Windows via winget..."
        RequireWinget
        winget install --id Git.Git --source winget --accept-package-agreements --accept-source-agreements
        PathRefresh
        $gitBashPath = Get-GitBashPath
    }

    if (-not $gitBashPath) {
        throw "Git Bash still not found after installation. Install Git for Windows manually and rerun."
    }

    Write-Output "Git Bash found at: $gitBashPath"

    # Put Git Bash directory first on PATH for this session
    $gitBashDir = Split-Path -Parent $gitBashPath
    $env:Path = "$gitBashDir;$env:Path"

    # Sanity check
    & $gitBashPath -lc "echo Git Bash OK" | Out-Null
    Write-Output "Git Bash is available and runnable."

    # Makes path executables available inside git bash.
    $env:MSYS2_PATH_TYPE = "inherit"
}

function New-File([string]$path) {
  $dir = Split-Path -Parent $path
  if (-not (Test-Path -LiteralPath $dir)) {
    New-Item -ItemType Directory -Path $dir -Force | Out-Null
  }
  if (-not (Test-Path -LiteralPath $path)) {
    New-Item -ItemType File -Path $path -Force | Out-Null
  }
}

function Convert-SingleQuotes([string]$s) {
  # For single-quoted PowerShell strings, escape a single quote by doubling it
  return $s -replace "'", "''"
}

function Add-Line([string]$path, [string]$line, [string]$comment = $null) {
  New-File $path

  $raw = Get-Content -LiteralPath $path -Raw -ErrorAction SilentlyContinue
  if ($null -eq $raw) { $raw = "" }

  $needle = $line.Trim()

  $exists = $false
  foreach ($l in ($raw -split "(`r`n|`n|`r)")) {
    if ($l.Trim() -eq $needle) { $exists = $true; break }
  }

  if (-not $exists) {
    $toAdd = "`r`n"
    if ($comment) { $toAdd += "# $comment`r`n" }
    $toAdd += "$line`r`n"
    Add-Content -LiteralPath $path -Value $toAdd
  }
}

function Set-DotSource([string]$hostProfilePath, [string]$targetProfilePath) {
  # Single quotes are easiest for space-safe dot-sourcing
  $escaped = Convert-SingleQuotes $targetProfilePath
  $dotSourceLine = ". '$escaped'"
  Add-Line -path $hostProfilePath -line $dotSourceLine -comment "Load shared AllHosts profile"
}

function setPowershellAlias {
  [CmdletBinding()]
  param()

  $aliasName   = "j"
  $aliasTarget = "just"
  
  $existing = Get-Alias -Name $aliasName -ErrorAction SilentlyContinue
  if ($existing -and $existing.Definition -eq $aliasTarget) {
    Write-Host "Alias '$aliasName' is already correctly set ('$aliasTarget'). Nothing to do."
    return
  }

  $allHostsProfile    = $PROFILE.CurrentUserAllHosts
  $profilesDir        = Split-Path -Parent $allHostsProfile
  $consoleHostProfile = Join-Path -Path $profilesDir -ChildPath "Microsoft.PowerShell_profile.ps1"
  $vsCodeHostProfile  = Join-Path -Path $profilesDir -ChildPath "Microsoft.VSCode_profile.ps1"

  Write-Host "Setting up PowerShell alias '$aliasName' -> '$aliasTarget'"

  # 1) Ensure the shared and host profiles exist
  New-File $allHostsProfile
  New-File $consoleHostProfile
  New-File $vsCodeHostProfile

  # 2) Ensure both host profiles load the shared AllHosts profile
  Set-DotSource -hostProfilePath $consoleHostProfile -targetProfilePath $allHostsProfile
  Set-DotSource -hostProfilePath $vsCodeHostProfile  -targetProfilePath $allHostsProfile

  # 3) Ensure the alias exists in AllHosts exactly once
  $wantedAliasLine = "Set-Alias -Name $aliasName -Value $aliasTarget -Scope Global"
  Add-Line -path $allHostsProfile -line $wantedAliasLine -comment "just shorthand"

  # 4) Apply to current session (override any conflicting alias)
  Set-Alias -Name $aliasName -Value $aliasTarget -Scope Global

  # 5) Verify
  $check = Get-Alias -Name $aliasName -ErrorAction SilentlyContinue
  if ($check -and $check.Definition -eq $aliasTarget) {
    Write-Host "OK: Alias '$aliasName' -> '$aliasTarget' set and persisted."
    Write-Host "AllHosts: $allHostsProfile"
    Write-Host "Console:  $consoleHostProfile"
    Write-Host "VS Code:  $vsCodeHostProfile"
  } else {
    Write-Host "FAIL: alias '$aliasName' not set as expected."
  }
}

$minJust = [version]::new(1,25,0)
EnsureJustMinVersion -MinVersion $minJust

EnsureGitBash
$gitBash = Get-GitBashPath
$gitBashEsc = $gitBash -replace '\\', '\\\\'   # C:\x -> C:\\x

setPowershellAlias

@"
# Generated by setup. Do not commit.
set windows-shell := ["$gitBashEsc", "-cu"]
"@ | Set-Content -Encoding UTF8 "just\justfile.local"

Write-Output "Just and Bash are available, triggering `just setup`!"
just setup

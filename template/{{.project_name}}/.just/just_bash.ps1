$ErrorActionPreference = "Stop"

function PathRefresh {
    $machinePath = [System.Environment]::GetEnvironmentVariable("Path", "Machine")
    $userPath    = [System.Environment]::GetEnvironmentVariable("Path", "User")
    $env:Path    = "$machinePath;$userPath"
}

function Add-ToGitHubPathIfPresent {
  param([Parameter(Mandatory=$true)][string]$Dir)

  if ([string]::IsNullOrWhiteSpace($Dir)) { return }
  if (-not (Test-Path -LiteralPath $Dir)) { return }

  # Only in GitHub Actions. Persists to following steps in same job.
  if ($env:GITHUB_PATH) {
    Add-Content -Path $env:GITHUB_PATH -Value $Dir
  }
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
  $justCmd = Get-Command just -ErrorAction SilentlyContinue
  if (-not $justCmd) {
    Write-Output "just not found, refreshing PATH..."
    PathRefresh
  }

  $justCmd = Get-Command just -ErrorAction SilentlyContinue
  if (-not $justCmd) {
    Write-Output "just not found, installing via winget..."
    RequireWinget
    winget install --id Casey.Just --source winget --accept-package-agreements --accept-source-agreements
    PathRefresh
  }

  $justCmd = Get-Command just -ErrorAction SilentlyContinue
  if ($justCmd) {
    $justDir = Split-Path -Parent $justCmd.Source
    Add-ToGitHubPathIfPresent $justDir
  }
  else {
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
    Add-ToGitHubPathIfPresent $gitBashDir

    # Sanity check
    & $gitBashPath -lc "echo Git Bash OK" | Out-Null
    Write-Output "Git Bash is available and runnable."

    # Makes path executables available inside git bash.
    $env:MSYS2_PATH_TYPE = "inherit"
}

$minJust = [version]::new(1,25,0)
EnsureJustMinVersion -MinVersion $minJust

EnsureGitBash
$gitBash = Get-GitBashPath
$gitBashEsc = $gitBash -replace '\\', '\\\\'   # C:\x -> C:\\x

Write-Output "Git Bash should be available at [$gitBash]"

$localPath = Join-Path $PWD ".just\shell_settings.justfile"
$content = @"
# Generated by setup. Do not commit.
set windows-shell := ["$gitBashEsc", "-lc"]

# Convert the script path (passed as `$1) to a POSIX path, then run it with bash.
# `just` will append the temp script path as the last argument, so it lands in `$1.
set script-interpreter := [
  "$gitBashEsc", "-eu", "-c",
  "exec bash \"`$(cygpath -u \"`$1\")\"",
  "--"
]
"@
[System.IO.File]::WriteAllText(
  $localPath,
  $content,
  [System.Text.UTF8Encoding]::new($false)
)

git update-index --skip-worktree -- ".just/shell_settings.justfile"

Write-Output "Just and Bash are available, triggering `just setup`!"
just setup

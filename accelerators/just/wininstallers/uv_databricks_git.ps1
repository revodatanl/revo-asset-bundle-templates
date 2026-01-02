$ErrorActionPreference = "Stop"

[Console]::WriteLine("Running required installations for Windows using PowerShell...")

$required = @("uv", "databricks", "git")
$missing = @()

function continue_setup {
    $repoRoot = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path
    $cmd = "cd `"$repoRoot`"; just continue_setup"   # replace setup

    Start-Process pwsh -Wait -NoNewWindow -ArgumentList @(
    "-NoProfile",
    "-ExecutionPolicy", "Bypass",
    "-Command", $cmd
    )
    exit 0
}

foreach ($t in $required) {
  if (-not (Get-Command $t -ErrorAction SilentlyContinue)) {
    $missing += $t
  }
}

if ($missing.Count -eq 0) {
  [Console]::WriteLine("All required components available")
  continue_setup
}

if (-not (Get-Command winget -ErrorAction SilentlyContinue)) {
  [Console]::WriteLine("winget not available, manual installations required")
  [Console]::WriteLine("Missing: " + ($missing -join ", "))
  exit 1
}

if ($missing -contains "uv") {
  [Console]::WriteLine("Installing uv using winget...")
  winget install -e --id astral-sh.uv --accept-package-agreements --accept-source-agreements
}

if ($missing -contains "git") {
  [Console]::WriteLine("Installing Git using winget...")
  winget install -e --id Git.Git --accept-package-agreements --accept-source-agreements
}

if ($missing -contains "databricks") {
  [Console]::WriteLine("Installing Databricks CLI using winget...")
  winget install -e --id Databricks.DatabricksCLI --accept-package-agreements --accept-source-agreements
}

# refresh PATH in this process
$machinePath = [System.Environment]::GetEnvironmentVariable("Path", "Machine")
$userPath    = [System.Environment]::GetEnvironmentVariable("Path", "User")
$env:Path    = "$machinePath;$userPath"

# final report
$missing2 = @()
foreach ($t in $required) {
  if (-not (Get-Command $t -ErrorAction SilentlyContinue)) {
    $missing2 += $t
  }
}

if ($missing2.Count -eq 0) {
  [Console]::WriteLine("All required components available")
  continue_setup
} else {
  [Console]::WriteLine("Still missing: " + ($missing2 -join ", "))
}

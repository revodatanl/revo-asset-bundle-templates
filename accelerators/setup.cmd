@echo off
setlocal

REM Run PowerShell setup without requiring permanent execution policy changes
echo "Starting powershell script to install and run `just`..."
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0just/wininstallers/just_bash.ps1"
if errorlevel 1 exit /b 1
exit /b 0
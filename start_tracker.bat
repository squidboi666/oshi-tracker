@echo off
cd /d "%~dp0"
pwsh -WindowStyle Hidden -ExecutionPolicy Bypass -File "./Oshi_Tracker.ps1"
exit
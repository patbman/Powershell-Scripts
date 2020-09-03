@echo off
REM powershell.exe -executionpolicy bypass -noprofile -File "%~dp0\rename.ps1"
powershell.exe -executionpolicy bypass -noprofile -File "%~dp0\rename.ps1"
REM PowerShell.exe -NoProfile -Command "& {Start-Process PowerShell.exe -ArgumentList '-NoProfile -ExecutionPolicy Bypass -File ""%~dpn0\rename.ps1""' -Verb RunAs}"
REM rename-computer -newname $((get-ciminstance win32_bios | format-list serialnumber | out-string).substring(17+1).trim())
pause

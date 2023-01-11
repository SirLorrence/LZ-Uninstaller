@echo off
set installerFolder=%~dp0
move %~dp0\LZUninstall "C:\Program Files"
CALL "C:\Program Files\LZUninstall\cleanSetup.bat" %installerFolder%

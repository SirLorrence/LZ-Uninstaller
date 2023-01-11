@echo off
set installDir=%1
::Q - not to ask to confirm
del %installDir% /Q 
rmdir %installDir%

setx /M PATH "%PATH%;C:\Program Files\LZUninstall"
echo Install Complete
echo To Access this tool tpye: lzun (for- Lazy Uninstall)
pause
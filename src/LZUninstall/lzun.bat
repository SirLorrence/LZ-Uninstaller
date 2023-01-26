@echo off
:: Clears on first startup
cls 

echo Admin permissions required my guy. Detecting permissions . . .
net session >nul 2>&1
if %errorlevel% == 0 (
	echo Success ! ! !
) else (
	echo Failure - Please run with Admin Permissions
	goto EExit
)
set DDUFolder= ./DDU*
cd /D %~dp0
if exist %DDUFolder% (
	:: gets any DDU version within the root folder. 
	cd %DDUFolder%
	if not exist "Display Driver Uninstaller.exe" goto DDUE1
	goto start
) else (
	goto DDUE0
)

:start
echo Choose which driver to uninstall
echo [0] All [1] Nvidia [2] AMD [3] Intel
REM if true then it will continue to the over drivers, flowing over to the other sets
set batchOverflow=False
set /p "input=Enter Input: "

REM This is pain..... cant use OR :(
if %errorlevel% neq 0 goto EExit

if %input% == 0 goto BATCH
if %input% == 1 goto NVCMD
if %input% == 2 goto AMDCMD
if %input% == 3 goto INTELCMD


REM if %input% == B goto BATCH
REM if %input% == b goto BATCH
REM if %input% == N goto NVCMD
REM if %input% == n goto NVCMD
REM if %input% == A goto AMDCMD
REM if %input% == a goto AMDCMD
REM if %input% == I goto INTELCMD
REM if %input% == i goto INTELCMD


goto LOOP

:LOOP
cls REM Clears prev 
echo invalid input 
echo:
goto start

:BATCH
set batchOverflow=True

:NVCMD
echo:
echo Removing Nvidia Driver
"Display Driver Uninstaller.exe" -silent -cleannvidia
echo Complete . . .
echo:
if %batchOverflow%==False goto END

:AMDCMD
echo:
echo Removing AMD Driver
"Display Driver Uninstaller.exe" -silent -cleanamd
echo Complete . . .
echo:
if %batchOverflow%==False goto END

:INTELCMD
echo:
echo Removing Intel Driver
"Display Driver Uninstaller.exe" -silent -cleanintel
echo Complete . . .
echo: 
if %batchOverflow%==False goto END

:END
pnputil /scan-devices
echo:
echo All done ! ! !
pause
exit

:: ================================ ERROR CODES
:: Short hand for Error Exit
:EExit
echo:
pause
exit

:DDUE0
echo No DDU Folder Located
echo "Remember: This file needs be the outside the directory (parent directory) for it to be able to locate the DDU folder"
goto EExit

:DDUE1
echo DDU exe not found ! 
echo Check if your DDU version has been extracted correctly.
goto EExit

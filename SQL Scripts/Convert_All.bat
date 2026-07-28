@echo off
setlocal
 
cd /d "%~dp0"
 
set "SCRIPT=%~dp0Convert_SqlParameters.ps1"
 
if not exist "%SCRIPT%" (
    echo ERROR: Cannot find %SCRIPT%
    pause
    exit /b 1
)
 
for %%F in (*.sql) do (
    echo Converting %%F...
 
    powershell.exe ^
        -NoLogo ^
        -NoProfile ^
        -ExecutionPolicy Bypass ^
        -File "%SCRIPT%" ^
        -InputFile "%%~fF" ^
        -OutputFile "%%~dpnF_outsystems.txt"
)
 
echo.
echo All SQL files have been converted to .txt files.
pause
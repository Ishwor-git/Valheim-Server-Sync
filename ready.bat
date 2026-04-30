@echo off
:: ============================================================
::  VALHEIM SAVE PULLER
::  Pulls latest save files from GitHub and copies locally
:: ============================================================

:: SET YOUR REPO FOLDER PATH HERE
:: set REPO_PATH=C:\path\to\your\Valheim-Server-Sync
:: Read config.ini and set variables
for /f "delims== tokens=1,2" %%G in (config.ini) do (
    set %%G=%%H
)

:: ▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲

:: set SAVE_PATH=%USERPROFILE%\AppData\LocalLow\IronGate\Valheim\worlds_local

echo.
echo [1/4] Pulling latest save from GitHub...
cd /d "%REPO_PATH%"
git pull origin main
echo       Pull complete.

echo.
echo [2/4] Checking pulled files...
if not exist "%REPO_PATH%\servername.fwl" (
    echo ERROR: servername.fwl not found in repo folder after pull.
    pause
    exit /b 1
)
if not exist "%REPO_PATH%\servername.db" (
    echo ERROR: servername.db not found in repo folder after pull.
    pause
    exit /b 1
)
echo       Files verified.

echo.
echo [4/4] Copying save files to Valheim worlds_local...
copy /Y "%REPO_PATH%\servername.fwl" "%SAVE_PATH%\servername.fwl"
copy /Y "%REPO_PATH%\servername.db"  "%SAVE_PATH%\servername.db"
echo       Files replaced with latest version.

echo.
echo ============================================================
echo  Latest save files pulled and ready. You can host now!
echo ============================================================
pause

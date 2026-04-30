@echo off
:: ============================================================
::  VALHEIM SAVE PULLER
::  Pulls latest save files from GitHub and copies locally
:: ============================================================

:: SET YOUR REPO FOLDER PATH HERE
 set REPO_PATH=%USERPROFILE%\Desktop\Valheim-Server-Sync
:: ▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲

set SAVE_PATH=%USERPROFILE%\Desktop\Valheim-Server-test

echo.
echo [1/4] Pulling latest save from GitHub...
cd /d "%REPO_PATH%"
git pull origin main
echo       Pull complete.

echo.
echo [2/4] Checking pulled files...
if not exist "%REPO_PATH%\hydraserver.fwl" (
    echo ERROR: hydraserver.fwl not found in repo folder after pull.
    pause
    exit /b 1
)
if not exist "%REPO_PATH%\hydraserver.db" (
    echo ERROR: hydraserver.db not found in repo folder after pull.
    pause
    exit /b 1
)
echo       Files verified.

echo.
echo [4/4] Copying save files to Valheim worlds_local...
copy /Y "%REPO_PATH%\hydraserver.fwl" "%SAVE_PATH%\hydraserver.fwl"
copy /Y "%REPO_PATH%\hydraserver.db"  "%SAVE_PATH%\hydraserver.db"
echo       Files replaced with latest version.

echo.
echo ============================================================
echo  Latest save files pulled and ready. You can host now!
echo ============================================================
pause

@echo off
:: ============================================================
::  VALHEIM SAVE PUSHER
::  Copies save files to repo folder and pushes to GitHub
:: ============================================================

:: SET YOUR REPO FOLDER PATH HERE 
:: set REPO_PATH=C:\path\to\your\Valheim-Server-Sync

for /f "delims== tokens=1,2" %%G in (config.ini) do (
    set %%G=%%H
)


set SAVE_PATH=%USERPROFILE%\AppData\LocalLow\IronGate\Valheim\worlds_local

echo.
echo [1/4] Checking save files...
if not exist "%SAVE_PATH%\servername.fwl" (
    echo ERROR: servername.fwl not found in %SAVE_PATH%
    pause
    exit /b 1
)
if not exist "%SAVE_PATH%\servername.db" (
    echo ERROR: servername.db not found in %SAVE_PATH%
    pause
    exit /b 1
)
echo       Save files found.

echo.
echo [2/4] Copying save files to repo folder...
copy /Y "%SAVE_PATH%\servername.fwl" "%REPO_PATH%\servername.fwl"
copy /Y "%SAVE_PATH%\servername.db"  "%REPO_PATH%\servername.db"
echo       Files copied.

echo.
echo [3/4] Staging and committing...
cd /d "%REPO_PATH%"
git add servername.fwl servername.db
git commit -m "Save update: %DATE% %TIME%"
echo       Committed.

echo.
echo [4/4] Pushing to GitHub...
git push origin main
echo       Push complete!

echo.
echo ============================================================
echo  Save files successfully pushed to GitHub.
echo ============================================================
pause

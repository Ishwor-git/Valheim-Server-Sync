@echo off
:: ============================================================
::  VALHEIM SAVE PUSHER
::  Copies save files to repo folder and pushes to GitHub
:: ============================================================

set REPO_PATH=%USERPROFILE%\Desktop\Valheim-Server-Sync

set SAVE_PATH=%USERPROFILE%\Desktop\Valheim-Server-test

echo.
echo [1/4] Checking save files...
if not exist "%SAVE_PATH%\hydraserver.fwl" (
    echo ERROR: servername.fwl not found in %SAVE_PATH%
    pause
    exit /b 1
)
if not exist "%SAVE_PATH%\hydraserver.db" (
    echo ERROR: servername.db not found in %SAVE_PATH%
    pause
    exit /b 1
)
echo       Save files found.

echo.
echo [2/4] Copying save files to repo folder...
copy /Y "%SAVE_PATH%\hydraserver.fwl" "%REPO_PATH%\hydraserver.fwl"
copy /Y "%SAVE_PATH%\hydraserver.db"  "%REPO_PATH%\hydraserver.db"
echo       Files copied.

echo.
echo [3/4] Staging and committing...
cd /d "%REPO_PATH%"
git add .
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

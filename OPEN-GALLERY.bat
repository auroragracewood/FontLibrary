@echo off
REM Launch the font gallery in your default browser.
REM Starts a tiny Python web server on a free port so browser font-loading
REM works (browsers refuse to load fonts from file:// URLs).

setlocal

REM Find a free port (try 9879 first, fall back if taken).
set PORT=9879
netstat -ano | findstr /R /C:":%PORT% .*LISTENING" >nul
if not errorlevel 1 set PORT=9880
netstat -ano | findstr /R /C:":%PORT% .*LISTENING" >nul
if not errorlevel 1 set PORT=9881

echo.
echo  Font Library Gallery
echo  --------------------
echo  Starting local server on port %PORT% ...
echo  When the browser opens, the gallery loads with all fonts.
echo.
echo  KEEP THIS WINDOW OPEN while browsing.
echo  Close the window (or press Ctrl+C) to stop the server.
echo.

REM Open the URL in default browser (after a brief delay so the server is up).
start "" cmd /c "timeout /t 2 /nobreak >nul & start http://127.0.0.1:%PORT%/gallery.html"

REM Start the server in the foreground so closing this window stops it.
python -m http.server %PORT% --directory "%~dp0" --bind 127.0.0.1

@echo off
cd /d "%~dp0"
where py >nul 2>nul
if %errorlevel%==0 (py dashboard-server.py) else (python dashboard-server.py)
pause

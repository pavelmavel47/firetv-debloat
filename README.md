# Fire TV Debloat

PowerShell-Skripte, die auf einem Amazon Fire TV Stick 4K Max (AFTKRT) unnötige Systempakete per ADB **deaktivieren**.
Gelöscht wird dabei nichts. `restore.ps1` macht alles wieder rückgängig.

Deaktiviert werden vier Gruppen:

- **Telemetrie und Werbung:** Metriken, Crash- und Log-Upload, ACR, Werbe-ID, Empfehlungen
- **Amazon-Apps:** Musik, Fotos, Spiele, Shopping, miniTV, Tutorials und Ähnliches
- **Alexa und Smart Home:** Alexa-Benachrichtigungen, Matter, externe Mediaplayer
- **System-Updates (OTA):** automatische Firmware-Updates

## Benutzung

Voraussetzungen: [ADB (Android Platform Tools)](https://developer.android.com/tools/releases/platform-tools) im `PATH`.
Auf dem Fire TV müssen die Entwickleroptionen und das ADB-Debugging eingeschaltet sein.

```
adb connect <IP-des-FireTV>:5555
.\debloat.ps1 -Device <IP-des-FireTV>:5555
```

Jedes erfolgreich deaktivierte Paket landet in `deaktiviert.txt`. Rückgängig machen:

```
.\restore.ps1 -Device <IP-des-FireTV>:5555
```

## Dateien

| Datei | Inhalt |
|---|---|
| `debloat.ps1` | deaktiviert die Pakete (`pm disable-user --user 0`) |
| `restore.ps1` | aktiviert alle Pakete aus `deaktiviert.txt` wieder |
| `deaktiviert.txt` | Protokoll der deaktivierten Pakete |
| `packages_enabled_vorher.txt` | Liste der aktiven Pakete vor dem Debloat, als Referenz |

## Hinweis

Benutzung auf eigene Gefahr. Wenn OTA-Updates deaktiviert sind, kommen auch keine Sicherheitsupdates mehr.

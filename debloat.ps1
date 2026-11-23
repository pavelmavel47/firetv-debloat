# Fire TV Stick 4K Max (AFTKRT) debloat - deaktiviert Pakete fuer User 0 (reversibel mit restore.ps1)
param([string]$Device = "192.168.2.215:5555")

$groups = [ordered]@{
  "Telemetrie & Werbung" = @(
    "com.amazon.device.metrics", "com.amazon.device.telemetry.emitter", "com.amazon.device.crashmanager",
    "com.amazon.device.logmanager", "com.amazon.dp.logger", "com.amazon.perfc", "com.amazon.perfcollection",
    "com.amazon.wirelessmetrics.service", "com.amazon.tv.acr", "com.amazon.hybridadidservice",
    "com.amazon.ftvads.deeplinking", "com.amazon.neo.minerva.logcat", "com.amazon.logan",
    "com.amazon.tv.developer.dataservice", "com.amazon.kso.blackbird", "com.amazon.sneakpeek",
    "com.amazon.media.recommendations", "com.amazon.connectivitydiag"
  )
  "Amazon-Apps" = @(
    "com.amazon.bueller.music", "com.amazon.bueller.photos", "com.amazon.cloud9", "com.amazon.gamehub",
    "com.amazon.shoptv.client", "com.amazon.shoptv.firetv.client", "com.amazon.minitv.android.app",
    "com.amazon.tahoe", "com.amazon.storm.lightning.tutorial", "com.amazon.tmm.tutorial",
    "com.amazon.tv.releasenotes", "com.amazon.tv.earlyaccess", "com.amazon.tv.ftvambient",
    "com.amazon.smarthomemapviewapp", "com.android.protips", "com.android.printservice.recommendation",
    "com.android.bookmarkprovider", "com.android.providers.partnerbookmarks"
  )
  "Alexa & Smart Home" = @(
    "com.amazon.tv.alexaalerts", "com.amazon.tv.alexanotifications", "com.amazon.rtcsessioncontroller",
    "com.amazon.tv.matter", "com.amazon.tv.mattercohost", "com.amazon.alexa.externalmediaplayer.fireos",
    "com.amazon.spotify.mediabrowserservice", "com.amazon.firetv.androidskillconnectioncapability",
    "com.amazon.vizzini", "com.amazon.alexamediaplayer.runtime.ftv"
  )
  "System-Updates (OTA)" = @(
    "com.amazon.device.software.ota", "com.amazon.device.software.ota.override",
    "com.amazon.tv.forcedotaupdater.v2"
  )
}

$log = Join-Path $PSScriptRoot "deaktiviert.txt"
foreach ($g in $groups.Keys) {
  "== $g =="
  foreach ($p in $groups[$g]) {
    $r = (adb -s $Device shell pm disable-user --user 0 $p) -join " "
    $ok = $r -match "new state: disabled"
    if ($ok) { Add-Content -Encoding utf8 $log $p }
    "{0,-55} {1}" -f $p, $(if ($ok) { "OK" } else { "FEHLER: $r" })
  }
}

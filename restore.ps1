# Aktiviert alle von debloat.ps1 deaktivierten Pakete wieder
param([string]$Device = "192.168.2.215:5555")

foreach ($p in Get-Content (Join-Path $PSScriptRoot "deaktiviert.txt")) {
  "{0,-55} {1}" -f $p, ((adb -s $Device shell pm enable --user 0 $p) -join " ")
}

#!/usr/bin/env bash
set -x
mkdir -p out
echo "emulator up: $(date -u +%T)" >> out/times.txt
adb install -r app.apk; echo "installed: $(date -u +%T) exit=$?" >> out/times.txt
adb exec-out screencap -p > out/0-home.png
cd out
maestro test ../.walk/opens.yaml --format junit --output opens.xml --debug-output dbg-opens; echo "opens exit=$? $(date -u +%T)" >> times.txt
maestro test ../.walk/fails.yaml --format junit --output fails.xml --debug-output dbg-fails; echo "fails exit=$? $(date -u +%T)" >> times.txt
adb exec-out screencap -p > z-end.png
adb logcat -d -t 400 > logcat.txt
exit 0

#!/usr/bin/env bash
set -x
mkdir -p out
echo "emulator up: $(date -u +%T)" >> out/times.txt
adb install -r app.apk; echo "installed: $(date -u +%T)" >> out/times.txt
sleep 10
cd out
maestro test ../.walk/profile.walk.yaml --format junit --output profile.xml; echo "profile walk exit=$? $(date -u +%T)" >> times.txt
cp -r ~/.maestro/tests ./maestro-tests 2>/dev/null
adb exec-out screencap -p > z-end.png
exit 0

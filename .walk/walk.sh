#!/usr/bin/env bash
set -x
mkdir -p out
echo "emulator up: $(date -u +%T)" >> out/times.txt
adb install -r app.apk; echo "installed: $(date -u +%T)" >> out/times.txt
for i in $(seq 1 60); do adb shell "ping -c 1 -W 2 u.expo.dev" > /dev/null 2>&1 && break; sleep 2; done
echo "reached u.expo.dev after ${i} tries: $(date -u +%T)" >> out/times.txt
adb shell am start -a android.intent.action.VIEW -d "classme://expo-development-client/?url=https%3A%2F%2Fu.expo.dev%2F6b5f96ab-1b7f-4108-81e6-89b8eca36186%2Fgroup%2Fe2eaf7ae-e0fa-4b9f-bd38-ac1674177545" com.contactdev2.classme
echo "opened: $(date -u +%T)" >> out/times.txt
cd out
maestro test ../.walk/profile.walk.yaml --format junit --output profile.xml; echo "profile walk exit=$? $(date -u +%T)" >> times.txt
cp -r ~/.maestro/tests ./maestro-tests 2>/dev/null
adb exec-out screencap -p > z-end.png
exit 0

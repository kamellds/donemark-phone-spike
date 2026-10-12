#!/usr/bin/env bash
set -x
mkdir -p out
echo "emulator up: $(date -u +%T)" >> out/times.txt
adb install -r app.apk; echo "installed: $(date -u +%T)" >> out/times.txt
sleep 20
adb logcat -G 16M; adb logcat -c
(adb logcat -v time > out/logcat-live.txt 2>&1 &)
adb shell am start -W -a android.intent.action.VIEW -d "classme://expo-development-client/?url=https%3A%2F%2Fu.expo.dev%2F6b5f96ab-1b7f-4108-81e6-89b8eca36186%2Fgroup%2Fe2eaf7ae-e0fa-4b9f-bd38-ac1674177545" com.contactdev2.classme > out/am.txt 2>&1
for t in 1 2 3 4 5 6 7 8 9 10 11 12; do sleep 5; adb exec-out screencap -p > out/open-$(date -u +%H%M%S).png; done
echo "opened, photos taken: $(date -u +%T)" >> out/times.txt
maestro hierarchy > out/hierarchy.json 2>&1
adb exec-out screencap -p > out/z-end.png
pkill -f "adb logcat" || true
exit 0

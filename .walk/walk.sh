#!/usr/bin/env bash
set -x
mkdir -p out
echo "emulator up: $(date -u +%T)" >> out/times.txt
adb install -r app.apk; echo "installed: $(date -u +%T)" >> out/times.txt
adb logcat -c
adb shell am start -W -a android.intent.action.VIEW -d "anewapp://expo-development-client/?url=https%3A%2F%2Fu.expo.dev%2F64916f0d-eca8-458b-8392-675cca22d7c4%2Fgroup%2Fb28e7822-6d71-405f-981a-5db53df095ac" com.kamellds.donemark_phone_spike > out/am.txt 2>&1
for t in 3 8 15 25 40 60 90; do sleep_for=$t; sleep 5; adb exec-out screencap -p > out/open-$(date -u +%H%M%S).png; done
echo "opened, photos taken: $(date -u +%T)" >> out/times.txt
maestro hierarchy > out/hierarchy.json 2>&1
cd out
maestro test ../.walk/opens.yaml --format junit --output opens.xml; echo "opens exit=$? $(date -u +%T)" >> times.txt
cp ../.walk/*.png . 2>/dev/null; cp -r ~/.maestro/tests ./maestro-tests 2>/dev/null
adb exec-out screencap -p > z-end.png
adb logcat -d > logcat.txt
exit 0

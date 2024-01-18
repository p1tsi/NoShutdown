#!/bin/sh

echo "[+] Compile no_shutdown"
clang -arch arm64 \
 -o no_shutdown \
 -framework Foundation \
 -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk \
  no_shutdown.m

echo "[+] Adhoc codesign no_shutdown"
codesign -s - no_shutdown

echo "[+] Compile launcher"
clang -arch arm64 \
 -o launcher \
 -framework Foundation \
 -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk \
 launcher.m

echo "[+] Adhoc codesign launcher"
codesign -s - launcher

echo "[+] done"
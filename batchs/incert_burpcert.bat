@echo off
title Incert-BurpCert
echo.
echo ┌───────────────────────────────────────────────────────┒
echo │       Incert BurpsuiteCertification to Android        ┃
echo │                                    From Kai_HT        ┃
echo └━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
echo.
REM Precedent download of buffsuit certificate required (from http://buffstutie)
echo [*] adb environment variable setting is required.
echo [*] openssl environment variable setting is required
echo.

set /p cerName=Do u Want Custom Certification Name? - Default Name is cacert(Y/N): 
if /i "%cerName%"=="N" SET %cerName%=cacert
if /i "%cerName%"=="Y" goto c_cert

REM Set Custom Certification Name
set /p cerName=Setting Custom Certification Name: 

echo [+] Start Receive root permissions from ADB.
adb root
echo [-] Finish Receive Root Permissions
echo [+] Start Mounting androidRoot Directory
adb shell "mount -o rw,remount /"
echo [-] Finish Mounting androidRoot Directory
echo [+] Start changing Certification From OpenSSL
openssl x509 -inform DER -in %cerName%.der -out %cerName%.pem
openssl x509 -inform PEM -subject_hash_old -in %cerName%.pem
echo [-] Finish changing Certification Files
echo [+] Start Moving on Certification file to Device.
mv %cerName%.pem 9a5ba575.0
adb push 9a5ba575.0 /system/etc/security/cacerts/
adb shell "chown 644 /system/etc/security/cacerts/9a5ba575.0"
echo [-] Finish Moveing Certification file.
adb shell "mount -o ro,remount /"
echo [-] Set Mounting androidRoot Directory

echo [*] Move Certification file in Deive Finish.
pause

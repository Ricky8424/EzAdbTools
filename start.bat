@echo off

::
::  Copyright (c) 2020, TipzTeam
::
::  Licensed under the GPLv3 License, Version 2.0 (the "License"); you
::  may not use this file except in compliance with the License.  You may
::  obtain a copy of the License at
::
::  https://www.gnu.org/licenses/gpl-3.0.en.html
::
::  Unless required by applicable law or agreed to in writing, software
::  distributed under the License is distributed on an "AS IS" BASIS,
::  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or
::  implied.  See the License for the specific language governing
::  permissions and limitations under the License.
::

:int
title EzAdbTools
color 0a

echo Checking if your system meet the requirments...

echo Checking system...

echo PROCESSOR_ARCHITECTURE:
echo PROCESSOR_ARCHITECTURE var:
echo %PROCESSOR_ARCHITECTURE% | find /i "x86" > nul
if %errorlevel%==0 (
    echo E1000: 32-bit systems aren't supported by ExAdbTools, exitting...
    choice /d y /t 2 > nul
) else (
    echo 64-bit systems are supported, continuing...
)
echo.

echo Checking for adb.exe...
if not exist "%CD%\bin\adb.exe" (
echo E1001: Unable to find adb.exe. Redownload this application.
choice /d y /t 2 > nul
exit
) else (
echo Found adb.exe
)

echo Checking for fastboot...
if not exist "%CD%\bin\fastboot.exe" (
echo E1002: Unable to find fastboot.exe. Redownload this application.
choice /d y /t 2 > nul
exit
)
echo Found fastboot.exe

echo Starting Services...

echo Resetting adb...
cd bin
adb.exe kill-server
adb.exe start-server
cd ..

echo Resetting variables...
set M=
set pressanykey=
set adb_install_app=
set sideload_zip=
set fastboot_flash_part=
set fastboot_flash_image=
set unlock_bin=
set unlock_key=

echo Done!

goto :menu

:menu
cls
set M=
echo.
cd variables
type startprint
cd ..
echo Start Menu
echo ==============================
echo.
echo 1 - adb related
echo 2 - fastboot related
echo 3 - Command Line
echo 4 - Display control
echo X - Exit
echo.
set /P M="Input options shown above then press ENTER: "
if %M%==1 GOTO adb
if %M%==2 GOTO fastboot
if %M%==3 GOTO cmd
if %M%==4 GOTO scrcpy
if %M%==X GOTO exit
if %M%==x GOTO exit
if %M%=show c GOTO elic
cls
cd variables
type error1003
cd ..
choice /d y /t 2 > nul
set M=
goto menu

:adb
cls
set M=
echo.
cd variables
type startprint
cd ..
echo adb Related
echo ==============================
echo.
echo 1 - Install Application
echo 2 - Android Shell
echo 3 - Reboot Menu
echo 4 - Backup
echo 5 - Sideload flashable zip file
echo 6 - Logcat
echo C - Connected devices
echo X - Back
echo.
set /P M="Input options shown above then press ENTER: "
if %M%==1 GOTO adb_app_install
if %M%==2 GOTO adb_root_shell_ask
if %M%==C GOTO adb_devices
if %M%==c GOTO adb_devices
if %M%==3 GOTO adb_reboot
if %M%==4 GOTO adb_full_backup
if %M%==5 GOTO adb_sideload
if %M%==6 GOTO adb_logcat
if %M%==X GOTO menu
if %M%==x GOTO menu
cls
cd variables
type error1003
cd ..
choice /d y /t 2 > nul
set M=
goto adb

:adb_appman
cls
echo.
cd variables
type startprint
cd ..
echo Application Manager
echo ==============================
echo.
echo 1 - Install Applications
echo 2 - Uninstall Applications (Incomplete)
echo 3 - List Applications
echo X - Back
echo.
set /P M="Input options shown above then press ENTER: "
if %M%==1 GOTO adb_app_install
if %M%==2 GOTO adb_app_uni
if %M%==3 GOTO adb_app_list
if %M%==X GOTO adb
if %M%==x GOTO adb
cls
cd variables
type error1003
cd ..
choice /d y /t 2 > nul
set M=
goto adb_appman

:adb_app_install
cls
echo.
cd variables
type startprint
cd ..
echo Install Applications
echo ==============================
echo.
set /P adb_install_app="Drag and drop the apk file into this window then hit enter: "
if exist %adb_install_app% (
set delworkingbat=1
    (
    echo cd variables
    echo type startprint
    echo cd ..
    echo echo Install Applications
    echo echo ==============================
	echo cd bin
	echo adb.exe install %adb_install_app%
	echo cd ..
    echo call delworking.bat
	echo cls
)>"working.bat"
call working.bat

:adb_app_uni
cls
echo.
cd variables
type startprint
cd ..
echo Uninstall Applications
echo ==============================
echo.
echo Incomplete.
choice /d y /t 2 > nul
goto adb_appman

:adb_app_list
cls
echo.
cd variables
type startprint
cd ..
echo List Applications
echo ==============================
echo.
cd bin
adb shell pm list packages -f
cd ..
pause
goto adb_appman

:adb_android_shell
cls
echo.
cd variables
type startprint
cd ..
echo Android Shell
echo ==============================
echo.
cd bin 
adb.exe shell
goto menu

:adb_su_android_shell
cls
echo.
cd variables
type startprint
cd ..
echo Android Shell
echo ==============================
echo.
echo This will stop EzAdbTools, restart this program if you need it later.
cd bin 
adb.exe shell su
adb.exe shell

:adb_devices
cls
echo.
cd variables
type startprint
cd ..
echo Connected devices
echo ==============================
echo.
echo Remember to authorize your computer before you do anything!
echo.
cd bin
adb.exe devices
cd ..
set /p pressanykey="Press any key to return to the menu..."
goto adb

:adb_reboot
cls
set M=
echo.
cd variables
type startprint
cd ..
echo Reboot Menu
echo ==============================
echo.
echo 1 - Reboot device
echo 2 - Reboot into Fastboot Mode
echo 3 - Reboot into Recovery Mode
echo 4 - Reboot into Emergency Download Mode
echo 5 - Reboot into Download Mode
echo 6 - Reboot into Safe Mode (ROOT)
echo X - Back
echo.
set /P M="Input options shown above then press ENTER: "
if %M%==1 GOTO adb_reboot_device
if %M%==2 GOTO adb_reboot_fastboot
if %M%==3 GOTO adb_reboot_recovery
if %M%==4 GOTO adb_reboot_edl
if %M%==5 GOTO adb_reboot_download
if %M%==6 GOTO adb_reboot_safemode_root
if %M%==X GOTO adb
if %M%==x GOTO adb
cls
cd variables
type error1003
cd ..
choice /d y /t 2 > nul
set M=
goto adb_reboot

:adb_reboot_device
cls
echo.
cd variables
type startprint
cd ..
echo Reboot device
echo ==============================
echo.
cd bin
adb.exe reboot
cd ..
echo Done!
choice /d y /t 2 > nul
goto adb_reboot

:adb_reboot_fastboot
cls
echo.
cd variables
type startprint
cd ..
echo Reboot into Fastboot Mode
echo ==============================
echo.
cd bin
adb.exe reboot bootloader
cd ..
echo Done!
choice /d y /t 2 > nul
goto adb_reboot

:adb_reboot_recovery
cls
echo.
cd variables
type startprint
cd ..
echo Reboot into Recovery Mode
echo ==============================
echo.
cd bin
adb.exe reboot recovery
cd ..
echo Done!
choice /d y /t 2 > nul
goto adb_reboot

:adb_reboot_edl
cls
echo.
cd variables
type startprint
cd ..
echo Reboot into EDL
echo ==============================
echo.
cd bin
adb.exe reboot edl
cd ..
echo Done!
choice /d y /t 2 > nul
goto adb_reboot

:adb_reboot_download
cls
echo.
cd variables
type startprint
cd ..
echo Reboot into Download Mode
echo ==============================
echo.
cd bin
adb.exe reboot download
cd ..
echo Done!
choice /d y /t 2 > nul
goto adb_reboot

:adb_reboot_safemode_root
cls
echo.
cd variables
type startprint
cd ..
echo Reboot into Safe Mode (ROOT)
echo ==============================
echo.
cd bin
adb shell su -c 'setprop persist.sys.safemode 1'
cd ..
echo Done!
choice /d y /t 2 > nul
goto adb_reboot

:adb_full_backup
cls
echo.
cd variables
type startprint
cd ..
echo Full Backup
echo ==============================
echo.
echo This feature is not tested.
choice /d y /t 2 > nul
    (
    echo cd variables
    echo type startprint
    echo cd ..
	echo echo Full Backup
	echo echo ==============================
	echo cd bin
	echo mkdir backups
	echo adb.exe backup -apk -shared -all -f \backups\backup.ab
	echo cd ..
    echo call delworking.bat
	echo cls
)>"working.bat"
call working.bat

:adb_root_mode_on
cls
set M=
echo.
cd variables
type startprint
cd ..
echo Enable Root Mode
echo ==============================
echo.
cd bin
adb.exe root
cd ..
set root_mode=1
echo Root mode is enabled.
choice /d y /t 3 > nul

:adb_root_mode_off
cls
set M=
echo.
cd variables
type startprint
cd ..
echo Disable Root Mode
echo ==============================
echo.
cd bin
adb.exe unroot
cd ..
set root_mode=0
echo Root mode is disabled.
choice /d y /t 3 > nul

:adb_sideload
cls
set M=
echo.
cd variables
type startprint
cd ..
echo Sideload flashable zip file
echo ==============================
echo.
set /P sideload_zip="Drag and drop the flashable zip file you want to flash: "
set delworkingbat=1
    (
    echo cd variables
    echo type startprint
    echo cd ..
    echo echo Sideload flashable zip file
    echo echo ==============================
    echo cd bin
    echo adb.exe sideload %sideload_zip%
    echo cd ..
    echo call delworking.bat
    echo cls
)>"working.bat"
call working.bat

:adb_logcat
cls
set M=
echo.
cd variables
type startprint
cd ..
echo Logcat
echo ==============================
echo.
echo You will have to restart this application
echo to close to logcat.
pause
adb logcat

:fastboot
cls
set M=
echo.
cd variables
type startprint
cd ..
echo fastboot Related
echo ==============================
echo.
echo 1 - Reboot device
echo 2 - Bootloader unlocking related
echo 3 - Get device-id
echo 4 - Flash image file
echo 5 - Enable Charge Screen
echo X - Back
echo.
set /P M="Input options shown above then press ENTER: "
if %M%==1 GOTO fastboot_reboot
if %M%==2 GOTO fastboot_unlock
if %M%==3 GOTO fastboot_device_id
if %M%==4 GOTO fastboot_flash
if %M%==4 GOTO fastboot_charge
if %M%==X GOTO menu
if %M%==x GOTO menu
cls
cd variables
type error1003
cd ..
choice /d y /t 2 > nul
set M=
goto fastboot

:fastboot_reboot
cls
echo.
cd variables
type startprint
cd ..
echo Reboot Device
echo ==============================
echo.
echo Rebooting device in fastboot mode in 5 seconds...
choice /d y /t 5 > nul
cd bin
fastboot.exe reboot
cd ..
echo Done!
choice /d y /t 2 > nul
goto fastboot

:fastboot_unlock
cls
echo.
cd variables
type startprint
cd ..
echo Bootloader unlocking related 
echo ==============================
echo.
echo 1 - Bootloader Unlock Status
echo 2 - Bootloader Unlock (No code)
echo 3 - Bootloader Unlock (Code needed)
echo 4 - unlock.bin Unlock
echo R - Relock Bootloader
echo X - Back
echo.
set /P M="Input options shown above then press ENTER: "
if %M%==1 GOTO fastboot_unlock_stat
if %M%==2 GOTO fastboot_unlock_nocode
if %M%==3 GOTO fastboot_unlock_code
if %M%==4 GOTO fastboot_unlock_bin
if %M%==R GOTO fastboot_relockbl
if %M%==r GOTO fastboot_relockbl
if %M%==X GOTO menu
if %M%==x GOTO menu
cls
cd variables
type error1003
cd ..
choice /d y /t 2 > nul
set M=
goto fastboot_unlock

:fastboot_unlock_stat
cls
echo.
cd variables
type startprint
cd ..
echo Bootloader Unlock Status
echo ==============================
echo.
echo True means unlocked, False means not unlocked
cd bin 
fastboot.exe oem device-info
cd ..
choice /d y /t 2 > nul
goto fastboot_unlock

:fastboot_unlock_nocode
cls
echo.
cd variables
type startprint
cd ..
echo Bootloader Unlock (No code)
echo ==============================
echo.
cd bin
fastboot.exe oem unlock
cd ..
echo Done!
choice /d y /t 2 > nul
goto fastboot_unlock

:fastboot_unlock_code
set unlock_key=
cls
echo.
cd variables
type startprint
cd ..
echo Unlock Bootloader (Code needed)
echo ==============================
echo.
set /P unlock_key="Input the code you got for unlocking your device: "
set delworkingbat=1
    (
    echo type startprint
    echo echo Unlock Bootloader (Code needed)
    echo echo ==============================
    echo cd bin
    echo fastboot.exe oem-unlock %unlock_key%
    echo cd ..
    echo call delworking.bat
    echo cls
)>"working.bat"
call working.bat

:fastboot_unlock_bin
set unlock_bin=
cls
echo.
cd variables
type startprint
cd ..
echo unlock.bin Unlock
echo ==============================
echo.
set /P unlock_bin="Drag and drop the unlock.bin into our window and press ENTER: "
set delworkingbat=1
    (
    echo type type logo.ASART
    echo type startprint
    echo echo unlock.bin Unlock
    echo echo ==============================
    echo cd bin
    echo fastboot.exe flash unlock %unlock_bin%
    echo cd ..
    echo call delworking.bat
    echo cls
)>"working.bat"
call working.bat

:fastboot_relockbl
echo wip
choice /d y /t 2 > nul
goto menu

:fastboot_device_id
cls
echo.
cd variables
type startprint
cd ..
echo Get device-id
echo ==============================
echo.
cd bin
fastboot oem device-id
cd ..
pause
goto fastboot

:fastboot_flash
cls
echo.
cd variables
type startprint
cd ..
echo Flash image file
echo ==============================
echo.
set /P fastboot_flash_part="Type the partition you want to flash than press ENTER: "
set /P fastboot_flash_image="Drag and drop the image you want to flash than press ENTER: "
set delworkingbat=1
(
	echo cd variables
    echo type startprint
    echo cd ..
	echo echo unlock.bin Unlock
	echo echo ==============================
	echo echo.
	echo cd bin
	echo fastboot.exe flash %fastboot_flash_part% %fastboot_flash_image% 
	echo cd ..
	echo call delworking.bat
)>"working.bat"
call working.bat

:fastboot_charge
cls
echo.
cd variables
type startprint
cd ..
echo Enable Charge Screen
echo ==============================
echo.
set /P M="Contiune? (Y/N) "
if %M%==y GOTO fastboot_charge_y
if %M%==n GOTO fastboot
if %M%==Y GOTO fastboot_charge_y
if %M%==N GOTO fastboot
cls
cd variables
type error1003
cd ..
choice /d y /t 2 > nul
set M=
goto fastboot_charge

:fastboot_charge_y
cls
echo.
cd variables
type startprint
cd ..
echo Enable Charge Screen
echo ==============================
echo.
cd bin
call fastboot.exe oem enable-charger-screen
cd ..
goto fastboot

:exit
cls
set M=
echo.
cd variables
type startprint
cd ..
echo Exit
echo ==============================
echo.
echo Exiting in 2 seconds...
choice /d y /t 2 > nul
taskkill /im /f adb.exe
taskkill /im /f fastboot.exe
del working.bat
exit

:cmd
cls
set M=
echo.
cd variables
type startprint
cd ..
echo Command Line
echo ==============================
echo.
echo This will EzAdbTools, execute 'call eat.bat' to 
echo start this program again.
echo 
cd bin
cmd

:scrcpy
cls
set M=
echo.
cd variables
type startprint
cd ..
echo Display control
echo ==============================
echo.
echo 1 - Use scrcpy
echo X - Back
echo.
set /P M="Input options shown above then press ENTER: "
if %M%==1 GOTO use_scrcpy
if %M%==x GOTO menu
if %M%==X GOTO menu
cls
title EzAdbTools
cls
cd variables
type error1003
cd ..
choice /d y /t 2 > nul
set M=
goto scrcpy

:use_scrcpy
cls
set M=
echo.
cd variables
type startprint
cd ..
echo scrcpy
echo ==============================
echo.
echo Launching scrcpy...
echo.
cd bin
scrcpy
cd ..
goto scrcpy

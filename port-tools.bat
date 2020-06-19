@echo off
color 0a

set M=

goto :menu

:menu
title EzAdbTools
cls
set M=
echo.
type startprint
echo Port Tools
echo ==============================
echo.
echo 1 - Port boot image
echo X - Back
echo.
set /P M="Input options shown above then press ENTER: "
if %M%==1 GOTO boot
if %M%==X GOTO exit
if %M%==x GOTO exit
if %M%=show c GOTO elic
cls
title EzAdbTools
cls
echo You typed a incorrect command, try again.
choice /d y /t 2 > nul
set M=
goto menu

:boot
title EzAdbTools
cls
set M=
echo.
type startprint
echo Port Boot Image
echo ==============================
echo.
IF NOT EXIST input GOTO createdir
echo Please place your boot image in 
echo the "input" folder. 
echo.
echo Boot image with the name boot.img
echo is the only option for now.
pause
call unpack_img.bat boot.img input/

:createdir
IF EXIST input (
echo old folder exists, deleting...
del input
) ELSE (
mkdir input
goto boot
)

:exit
call start.bat
exit

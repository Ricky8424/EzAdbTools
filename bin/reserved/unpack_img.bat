@echo off
cd "%~dp0"
IF EXIST "%~dp0\bin" SET PATH=%PATH%;"%~dp0\bin"
Setlocal EnableDelayedExpansion
call start.bat
echo(
if "%~1" == "" goto noinput
if "%~2" == "" goto noinput
set "folder=%~n2"
cecho Your image:{0E} %folder%.img {#}{\n}
set "file=%~nx1"
:unpack
echo(
cecho Create the{0E} %~n2 {#}folder.{\n}
echo(
if exist "%folder%" rd /s/q "%folder%"
md %folder%
echo(
unpackbootimg -i %file% -o %folder%
:donecheck
cd %folder%
for %%a in ("%file%-ramdisk.*") do set ext=%%~xa
cecho Compression used:{0E} %ext:~1% {#}{\n}
type nul > %file%-ramdisk-compress
echo %ext:~1% > "%file%-ramdisk-compress"
echo(
md ramdisk
echo Unpacking the ramdisk....
echo(
goto %ext:~1%
echo(
:gz
cd ramdisk
gzip -dcv "../%file%-ramdisk.gz" | cpio -i
if %errorlevel% neq 0 goto ziperror
cd ..\
del "%file%-ramdisk.gz"
cd ..\
echo(
cecho Done. Your image is unpacked in{0E} %folder% {#}folder.{\n}
goto end
:lzma
cd ramdisk
xz -dcv "../%file%-ramdisk.lzma" | cpio -i
if %errorlevel% neq 0 goto ziperror
cd ..\
del "%file%-ramdisk.lzma"
cd ..\
echo(
cecho Done. Your image is unpacked in{0E} %folder% {#}folder.{\n}
goto end
:xz
cd ramdisk
xz -dcv "../%file%-ramdisk.xz" | cpio -i
if %errorlevel% neq 0 goto ziperror
cd ..\
del "%file%-ramdisk.xz"
cd ..\
echo(
cecho Done. Your image is unpacked in{0E} %folder% {#}folder.{\n}
goto end
:bz2
cd ramdisk
bzip2 -dcv "../%file%-ramdisk.bz2" | cpio -i
if %errorlevel% neq 0 goto ziperror
cd ..\
del "%file%-ramdisk.bz2"
cd ..\
echo(
cecho Done. Your image is unpacked in{0E} %folder% {#}folder.{\n}
goto end
:lz4
cd ramdisk
lz4 -dv "../%file%-ramdisk.lz4" stdout | cpio -i
if %errorlevel% neq 0 goto ziperror
cd ..\
del "%file%-ramdisk.lz4"
cd ..\
echo(
cecho Done. Your image is unpacked in{0E} %folder% {#}folder.{\n}
goto end
:lzo
cd ramdisk
lzop -dcv "../%file%-ramdisk.lzo" | cpio -i
if %errorlevel% neq 0 goto ziperror
cd ..\
del "%file%-ramdisk.lzo"
cd ..\
echo(
cecho Done. Your image is unpacked in{0E} %folder% {#}folder.{\n}
goto end
:ziperror
echo(
cecho {0C}Your ramdisk archive is corrupt or unknown format. Exit script.{#}{\n}
echo(
goto end
:noinput
echo(
cecho {0C}No image file selected. Exit script.{#}{\n}
echo(
:end
call port-tools2.bat

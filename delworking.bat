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

:: ==============================
:: EzAdbTools
:: Script 1 - Remove working.bat
:: ==============================

rem Actual script
echo ==============================
echo EzAdbTools Scripts
echo Script 1 - Remove working.bat
echo ==============================
echo 
echo Removing working.bat...
cd ..
del "working.bat"
set delworkingbat=0
call start.bat

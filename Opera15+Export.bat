echo off

:: bat variables
:: zzid- unique number
:: zztmpf- temporary unique file path
:: zname- file name of the bat file (no path info)

for %%t in (%0) do set zzname=%%~nt

set zzid=%zzname%%date:~6,4%%date:~3,2%%date:~0,2%%time:~0,2%%time:~3,2%%time:~6,2%%time:~9,2%
set zztmpf="%tmp%\%zzid%"


echo %0
echo version 1
echo OPERA v15 (or above) user settings, speed dials, stash preferences and other and data
echo to backup/export to archive or to migrate to a new computer
echo by Iani Ionidis, 2014
echo.
echo.

set v_name0=Opera Stable

for /f "delims=" %%i in ('dir "%appdata%\%v_name0%" /s /b /a:d') do set v_path=%%i
set v_date_id=%date:~6,4%%date:~3,2%%date:~0,2%

if exist "%v_name0%.%v_date_id%" (
	echo folder %v_name0%.%v_date_id% exists - exiting
	echo to remove, type: rmdir "%v_name0%.%v_date_id%" /q /s
	exit /b
)

if not exist "%v_name0%.%v_date_id%" (
	mkdir "%v_name0%.%v_date_id%"
)

set v_items="favorites.db" "History" "Local State" "Login Data" "Preferences" "session.db" "stash.db" "thumbnails.db" "Visited Links" "Web Data" "Extension Rules" "Extension State" "Local Storage"

for %%i in (%v_items%) do xcopy "%v_path%\%%~i" "%v_name0%.%v_date_id%\" /f /s /y /g

echo.
echo Folder %v_name0%.%v_date_id% created. 
echo To migrate to another computer, or to restore to this computer, just copy all the files in the folder to the "%v_name0%" folder on the target computer. You will find it in %%appdata%% ... Opera ...

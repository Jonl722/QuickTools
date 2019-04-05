@echo off

SETLOCAL
rem bat variables
rem zfn- file name of the bat file (no path info)
rem zfp- temporary unique file path
rem zid- unique number
rem ztc- timecode
for %%t in (%0) do set zfn=%%~nt
set ztc=%date:~6,4%%date:~3,2%%date:~0,2%%time:~0,2%%time:~3,2%%time:~6,2%%time:~9,2%
set zid=%ztc%%random%
set zfp="%tmp%\%zid%"

rem --- Main Body of BAT file

set ZTMP=2
set
echo %ZTMP%

rem --- End of BAT file

:end of script
if exist %zfp% del /q %zfp%
ENDLOCAL
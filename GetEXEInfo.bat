@echo off
    setlocal enableextensions

    set "file=%~1"
    if not defined file goto :eof
    if not exist "%file%" goto :eof

    set "vers="
    FOR /F "tokens=2 delims==" %%a in ('
        wmic datafile where name^="%file:\=\\%" get Version /value 
    ') do set "vers=%%a"

    echo(%file% = %vers% 

    endlocal

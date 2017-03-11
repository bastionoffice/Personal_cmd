REM 11:02 AM 6/4/2012
REM cleanup script for the IIS Logs (services the Exchange pages)
REM c:\admin\scripts\data_cleanup_IIS_logs_180days.cmd

pushd "pushd g:\logs\IIS\W3SVC1"
REM remove log files older than 6 months
forfiles /s /m *log /D -180 /c "cmd /c del @path"

REM ::: not needed :::
REM clean up empty folders recursively.
REM for /f "usebackq delims=" %%d in (`"dir /ad/b/s | sort /R"`) do rd "%%d"

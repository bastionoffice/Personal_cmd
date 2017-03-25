REM Updated 20170325
REM cleanup script for the IIS Logs (services the Exchange pages)
REM c:\admin\scripts\data_cleanup_IIS_logs_180days.cmd
set logdir=g:\logs\IIS\W3SVC1

REM remove log files older than 6 months
forfiles /p "%logdir%" /s /m *log /D -180 /c "cmd /c del @path"



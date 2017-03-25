@echo off
REM for adding pointers to localhost for unwanted domains
REM usually advertising sites
echo 127.0.0.1	%1 >> %systemroot%\system32\drivers\etc\hosts
type %systemroot%\system32\drivers\etc\hosts

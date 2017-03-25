@echo off
echo 127.0.0.1	%1 >> %systemroot%\system32\drivers\etc\hosts
type %systemroot%\system32\drivers\etc\hosts

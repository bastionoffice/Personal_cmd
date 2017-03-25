@echo off
@cls
if "%computername%"=="GANDALF" (set target=C:\bin) else (set target=e:\bin)
if "%computername%"=="TOLKIEN" (set target=f:\bin) 

echo current time is %time:~0,5%
if "%1"=="" goto :basic

pushd %target%\%1
goto :end

:basic
pushd %target%

:end

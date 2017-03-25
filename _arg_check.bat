@echo off
REM 4:23 PM 7/4/2012
REM c:\admin\scripts\galileo_setup.cmd
REM This is dependant on 
REM the default c:\fp folder structure from the default Galileo install
REM and that the "Client Identifier=xxxxxxx" lines exist in the c:\fp\machine\dat32com.ini

if "%1"=="" goto :usage
if "%2"=="" goto :usage
path=%path%;c:\admin\bin
set user=%1
set code=%2
REM echo %user%
REM echo %code%
set winfile=C:\Users\%user%\windows\win.ini
set datfile=C:\Users\%user%\fp\machine\dat32com.ini
set srcdat=c:\fp\machine\dat32com.ini
echo.
goto :display
:usage
echo.
echo We didn't get enough  arguments
echo.
echo USAGE
echo %0 Username ClientIdentifierCode
echo.
goto :eof
:display
echo.
echo We have arguments
echo.
echo user = %user% and code = %code%
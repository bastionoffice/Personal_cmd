
REM	stop all services
REM	10:21 PM 26/08/2006
REM	no error handling here
	for /f "tokens=*" %%i in ('net start') do (net stop "%%i")
			
		
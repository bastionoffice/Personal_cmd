
REM	stop all services
REM	26/08/2006
REM	no error handling here, so beware being able to reverse this
REM 	you may have to reboot
	for /f "tokens=*" %%i in ('net start') do (net stop "%%i")
			
		
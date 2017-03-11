REM \\vcserver\e$\admin\scripts\user_profile_cleanup.cmd
REM purges old internet cache, word, outlook files older than dd days
REM purging old word docs, path does not exist for all users 
set dd=28
REM user downloads
set dload=14
REM IE user cache
set ied=7
REM Windows temp
set dtemp=14
REM Windows Update
set dwu=14
REM service profiles
set dsvcprof=14
REM FSRM logs
set dfsrm=14
REM Recycle Bin
set drecyc=90

REM if 
set drv=\
if "%1"=="local" set drv=c:\
echo.

TITLE Trimming System Files 

:Recycle
forfiles /p \$recycle.bin /s /m $r* /d -%drecyc% /c "cmd /c del @path"
forfiles /p \$recycle.bin /s /m $r* /d -%drecyc% /c "cmd /c if @isdir==TRUE rd /s /q @path"
:WindowsUpdateCleanup
echo y | forfiles /p \windows\softwaredistribution\downloads /s /m * /d -%dwu% /c "cmd /c if @isdir==TRUE rd /s /q @path"
echo y | forfiles /p \windows\softwaredistribution\downloads /s /m * /d -%dwu% /c "cmd /c del @path"
:WindowsTemp
echo y | forfiles /p \windows\temp /s /m * /d -%dtemp% /c "cmd /c if @isdir==TRUE rd /s /q @path"
echo y | forfiles /p \windows\temp /s /m * /d -%dtemp% /c "cmd /c del @path"
:FSRMLogs
if not exist \StorageReports\Incident goto :FontCaches
echo y | forfiles /p \StorageReports\Incident /s /m * /d -%dfsrm% /c "cmd /c if @isdir==TRUE rd /s /q @path"
echo y | forfiles /p \StorageReports\Incident /s /m * /d -%dfsrm% /c "cmd /c del @path"
:FontCaches
echo y | forfiles /p \Windows\ServiceProfiles\LocalService\AppData\Local /s /m * /d -%dsvcprof% /c "cmd /c del @path"

:UserLoop
Echo.
TITLE Cleaning up all user accounts
Echo. 
REM Cycle into each user folder and purge their files older than XX days set at top of script
for /f "tokens=*" %%i in ('dir %drv%users /ad /b') do (set user=%%i & call :Users)
:Users
set user=%user: =%
if "%user%"=="AllUsers" goto :EXIT
if "%user%"=="DefaultUser" goto :EXIT
if "%user%"=="Public" goto :EXIT
TITLE Processing %User%
set fold=%drv%users\%user%\appdata
set IEfold="%fold%\Local\Microsoft\Windows\Temporary Internet Files\Low\Content.IE5"

	attrib  -s -h %fold%\* /s	
	REM these remove IE cache folders that haven't been modified (nor their contents)  in 60 days
	echo y | forfiles /p "%fold%\local\microsoft\windows\temporary internet files\low\content.ie5" /m * /d -%ied% /c "cmd /c if @isdir==TRUE rd /s /q @path"
	echo y | forfiles /p "%fold%\local\microsoft\windows\Inetcache\Low\ie" /m * /d -%ied% /c "cmd /c if @isdir==TRUE rd /s /q @path"
	echo y | forfiles /p "%fold%\local\microsoft\windows\temporary internet files\content.outlook" /m * /d -%dd% /c "cmd /c del @path"
	echo y | forfiles /p "%fold%\local\microsoft\windows\temporary internet files\content.outlook" /m * /d -%dd% /c "cmd /c if @isdir==TRUE rd /s /q @path")
	echo y | forfiles /p "%fold%\local\microsoft\windows\temporary internet files" /m olk*  /c "cmd /c if @isdir==TRUE rd /s /q @path"
	echo y | forfiles /p "%fold%\local\microsoft\windows\temporary internet files\content.mso" /m *.dot /d -%dd% /c "cmd /c attrib -r @path"
    echo y | forfiles /p "%fold%\local\microsoft\windows\temporary internet files\content.mso" /m * /d -%dd% /c "cmd /c del @path"
    echo y | forfiles /p "%fold%\local\microsoft\windows\temporary internet files\content.word" /m *.tmp /d -%dd% /c "cmd /c del @path"
	echo y | forfiles /p "%fold%\local\microsoft\windows\InetCache\content.mso" /m *.dot /d -%dd% /c "cmd /c attrib -r @path"
    echo y | forfiles /p "%fold%\local\microsoft\windows\InetCache\content.mso" /m * /d -%dd% /c "cmd /c del @path"
    echo y | forfiles /p "%fold%\local\microsoft\windows\InetCache\content.word" /m *.tmp /d -%dd% /c "cmd /c del @path"

	TITLE %user%  downloads
	echo y | forfiles /s /p "%fold%\..\downloads" /m * /d -%dload% /c "cmd /c del @path"
	TITLE %user%  logs
	echo y | forfiles /s /p "%fold%\local" /m *.log /d -%dd% /c "cmd /c del @path")
	TITLE %user% temp files
	forfiles /s /p "%fold%\local\temp" /m *.c* /d -%dd% /c "cmd /c del @path")
	forfiles /s /p "%fold%\local\temp" /m *.*o* /d -%dd% /c "cmd /c del @path")
	forfiles /s /p "%fold%\local\temp" /m *.log /d -%dd% /c "cmd /c del @path")
	forfiles /s /p "%fold%\local\temp" /m *.t* /d -%dd% /c "cmd /c del @path")
	forfiles /s /p "%fold%\local\temp" /m *.exe /d -%dd% /c "cmd /c del @path")
	forfiles /s /p "%fold%\local\google\chrome\user data\default\cache" /m * /d -%dd% /c "cmd /c del @path")
	TITLE %user%  Gotomeeting folders
	echo y | forfiles /s /p %fold%\local\citrix\gotomeeting /m  * /d -28 /c "cmd /c if @isdir==TRUE echo   @path"
	TITLE %user% Cookies
	forfiles /s /p "%fold%\Roaming\Microsoft\Windows\Cookies\Low" /m *.txt /d -545 /c "cmd /c del @path")
	forfiles /s /p "%fold%\Roaming\Microsoft\Windows\INetCookies" /m *.txt /d -545 /c "cmd /c del @path")
	forfiles /s /p "%fold%\Local\Microsoft\Windows\INetCookies" /m *.txt /d -545 /c "cmd /c del @path")
	TITLE  %user% old IE path
	@for /f %%q in ('dir /ad /b %IEfold%') do (echo y | forfiles /s /p %IEfold%\%%q /m * /d -%ied% /c "cmd /c del @path")
echo 	@for /f %%q in ('dir /ad /b %IEfold%') do (echo y | forfiles /s /p %IEfold%\%%q /m *  /c "cmd /c del @path")
    TITLE  %user% new IE path
	@for /f %%q in ('dir /ad /b %IEfold%\..\ie') do (echo y | forfiles /s /p %IEfold%\..\ie\%%q /m * /d -%ied% /c "cmd /c del @path")
	TITLE Done purging %user%
	popd
	)

:EXIT
dir %drv% | findstr free 


REM \\vcserver\e$\admin\scripts\user_profile_cleanup.cmd
REM purges old internet cache, word, outlook files older than dd days
REM purging old word docs, path does not exist for all users 
set dd=28
REM if 
set drv=\
if "%1"=="local" set drv=c:\
echo.
Goto :UserLoop

:Userprofiles_dd
REM for /f %%i in ('dir /ad /b %drv%users') do (forfiles /p "%drv%users\%%i\appdata\local\microsoft\windows\temporary internet files\content.mso" /m *.dot /d -%dd% /c "cmd /c attrib -r @path")
REM for /f %%i in ('dir /ad /b %drv%users') do (echo y | forfiles /p "%drv%users\%%i\appdata\local\microsoft\windows\temporary internet files\content.mso" /m * /d -%dd% /c "cmd /c del @path")
REM for /f %%i in ('dir /ad /b %drv%users') do (forfiles /p "%drv%users\%%i\appdata\local\microsoft\windows\temporary internet files\content.mso" /m *.d* /d -%dd% /c "cmd /c del @path")
REM for /f %%i in ('dir /ad /b %drv%users') do (forfiles /p "%drv%users\%%i\appdata\local\microsoft\windows\temporary internet files\content.mso" /m *.xls? /d -%dd% /c "cmd /c del @path")
REM for /f %%i in ('dir /ad /b %drv%users') do (forfiles /p "%drv%users\%%i\appdata\local\microsoft\windows\temporary internet files\content.mso" /m *.tmp /d -%dd% /c "cmd /c del @path")
REM for /f %%i in ('dir /ad /b %drv%users') do (forfiles /p "%drv%users\%%i\appdata\local\microsoft\windows\temporary internet files\content.mso" /m *.?mf /d -%dd% /c "cmd /c del @path")
REM for /f %%i in ('dir /ad /b %drv%users') do (forfiles /p "%drv%users\%%i\appdata\local\microsoft\windows\temporary internet files\content.word" /m *.tmp /d -%dd% /c "cmd /c del @path")
REM for /f %%i in ('dir /ad /b %drv%users') do (echo y | forfiles /p "%drv%users\%%i\appdata\local\microsoft\windows\temporary internet files\content.outlook" /m * /d -%dd% /c "cmd /c del @path")
for /f %%i in ('dir /ad /b %drv%users') do (echo y | forfiles /p "%drv%users\%%i\appdata\local\microsoft\windows\temporary internet files\content.outlook" /m * /d -%dd% /c "cmd /c if @isdir==TRUE rd /s /q @path")
REM for /f %%i in ('dir /ad /b %drv%users') do (forfiles /p "%drv%users\%%i\appdata\local\microsoft\windows\temporary internet files\content.outlook" /m *.p* /d -%dd% /c "cmd /c del @path")
REM for /f %%i in ('dir /ad /b %drv%users') do (forfiles /p "%drv%users\%%i\appdata\local\microsoft\windows\temporary internet files\content.outlook" /m *.d* /d -%dd% /c "cmd /c del @path")
REM for /f %%i in ('dir /ad /b %drv%users') do (forfiles /p "%drv%users\%%i\appdata\local\microsoft\windows\temporary internet files\content.outlook" /m *.x* /d -%dd% /c "cmd /c del @path")
for /f %%i in ('dir /ad /b %drv%users') do (echo y | forfiles /s /p "%drv%users\%%i\appdata\local" /m *.log /d -%dd% /c "cmd /c del @path")
for /f %%i in ('dir /ad /b %drv%users') do (echo y | forfiles /s /p "%drv%users\%%i\appdata\local\temp" /m *.c* /d -%dd% /c "cmd /c del @path")
for /f %%i in ('dir /ad /b %drv%users') do (echo y | forfiles /s /p "%drv%users\%%i\appdata\local\temp" /m *.*o* /d -%dd% /c "cmd /c del @path")
REM for /f %%i in ('dir /ad /b %drv%users') do (echo y | forfiles /s /p "%drv%users\%%i\appdata\local\temp" /m *.log /d -%dd% /c "cmd /c del @path")
for /f %%i in ('dir /ad /b %drv%users') do (echo y | forfiles /s /p "%drv%users\%%i\appdata\local\temp" /m *.t* /d -%dd% /c "cmd /c del @path")
for /f %%i in ('dir /ad /b %drv%users') do (echo y | forfiles /s /p "%drv%users\%%i\appdata\local\temp" /m *.exe /d -%dd% /c "cmd /c del @path")
for /f %%i in ('dir /ad /b %drv%users') do (echo y | forfiles /s /p "%drv%users\%%i\appdata\local\google\chrome\user data\default\cache" /m f* /d -%dd% /c "cmd /c del @path")
for /f %%i in ('dir /ad /b %drv%users') do (echo y | forfiles /s /p "%drv%users\%%i\AppData\Roaming\Microsoft\Windows\Cookies\Low" /m *.txt /d -545 /c "cmd /c del @path")
for /f %%i in ('dir /ad /b %drv%users') do (echo y | forfiles /s /p %fold%\appdata\local\citrix\gotomeeting /m  * /d -%dd% /c "cmd /c if @isdir==TRUE echo   @path") 
REM these remove IE cache folders that haven't been modified (nor their contents)  in 60 days
REM for /f %%i in ('dir %drv%users /ad /b') do (forfiles /p "%drv%users\%%i\appdata\local\microsoft\windows\temporary internet files\low\content.ie5" /m * /d -60 /c "cmd /c if @isdir==TRUE rd /s /q @path")
REM for /f %%i in ('dir %drv%users /ad /b') do (forfiles /p "%drv%users\%%i\appdata\local\microsoft\windows\temporary internet files" /m olk* /d -60 /c "cmd /c if @isdir==TRUE rd /s /q @path")
:UserDownloads_14
REM for /f %%i in ('dir /ad /b %drv%users') do (echo y | forfiles /s /p "%drv%users\%%i\downloads" /m * /d -14 /c "cmd /c del @path")
:Recycle_90
echo y | forfiles /p \$recycle.bin /s /m $r* /d -90 /c "cmd /c del @path"
echo y | forfiles /p \$recycle.bin /s /m $r* /d -90 /c "cmd /c if @isdir==TRUE rd /s /q @path"
:WindowsUpdateCleanup_10
echo y | forfiles /p \windows\softwaredistribution\downloads /s /m * /d -10 /c "cmd /c if @isdir==TRUE rd /s /q @path"
echo y | forfiles /p \windows\softwaredistribution\downloads /s /m * /d -10 /c "cmd /c del @path"
:WindowsTemp_14
echo y | forfiles /p \windows\temp /s /m * /d -14 /c "cmd /c if @isdir==TRUE rd /s /q @path"
echo y | forfiles /p \windows\temp /s /m * /d -14 /c "cmd /c del @path"
:FSRMLogs_14
echo y | forfiles /p \StorageReports\Incident /s /m * /d -14 /c "cmd /c if @isdir==TRUE rd /s /q @path"
echo y | forfiles /p \StorageReports\Incident /s /m * /d -14 /c "cmd /c del @path"
:FontCaches_14
echo y | forfiles /p \Windows\ServiceProfiles\LocalService\AppData\Local /s /m * /d -14 /c "cmd /c del @path"

:UserLoop
Echo.
Echo Looping through user accounts
Title Looping through user accounts
Echo. 
REM This cycles into each user folder and purges their IE cache files older than XX days
for /f %%i in ('dir %drv%users /ad /b') do (set user=%%i & call :IE5)

:IE5
set user=%user: =%
timeout /t 3
set IEfold="%drv%users\%user%\AppData\Local\Microsoft\Windows\Temporary Internet Files\Low\Content.IE5"
set fold=%drv%users\%user%
for /f %%q in ('dir /ad /b %IEfold%') do (
    attrib  -s -h %fold%\* /s
	timeout /t 7
	echo y | forfiles /s /p %IEfold%\%%q /m * /d -60 /c "cmd /c del @path"
	echo y | forfiles /s /p %fold%\appdata\local\citrix\gotomeeting /m  * /d -28 /c "cmd /c if @isdir==TRUE echo   @path"
	REM these remove IE cache folders that haven't been modified (nor their contents)  in 60 days
	echo y | forfiles /p "%fold%\appdata\local\microsoft\windows\temporary internet files\low\content.ie5" /m * /d -49 /c "cmd /c if @isdir==TRUE rd /s /q @path"
	echo y | forfiles /p "%fold%\appdata\local\microsoft\windows\temporary internet files\content.outlook" /m * /d -%dd% /c "cmd /c del @path"
	echo y | forfiles /p "%fold%\appdata\local\microsoft\windows\temporary internet files" /m olk* /d -60 /c "cmd /c if @isdir==TRUE rd /s /q @path"
	echo y | forfiles /p "%fold%\appdata\local\microsoft\windows\temporary internet files\content.mso" /m *.dot /d -%dd% /c "cmd /c attrib -r @path"
    echo y | forfiles /p "%fold%\appdata\local\microsoft\windows\temporary internet files\content.mso" /m * /d -%dd% /c "cmd /c del @path"
    echo y | forfiles /p "%fold%\appdata\local\microsoft\windows\temporary internet files\content.word" /m *.tmp /d -%dd% /c "cmd /c del @path"
	echo y | forfiles /s /p "%fold%\downloads" /m * /d -14 /c "cmd /c del @path"
	)

:EOF
dir %drv% | findstr free 


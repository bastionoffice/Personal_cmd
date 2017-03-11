REM ms_recommended_network_tuning.cmd
REM for virtualized environments
netsh int tcp set global chimney=disabled
netsh int tcp set global rss=disabled
netsh int ip set global taskoffload=disabled
netsh int tcp set global autotuninglevel=disabled
netsh int tcp set global congestionprovider=none
netsh int tcp set global ecncapability=disabled
netsh int tcp set global timestamps=disabled

@echo off

setlocal

rem **** Please edit these settings ****

set SAG_HOME=C:\SoftwareAG
set FILEBEAT_HOME=C:\SoftwareAG\filebeat-6.2.3
set SERVER_ID=dev1
set LOGSTASH_HOST=localhost
set LOGSTASH_PORT=5044
set SERVER_LOGFILE_PATH=%SAG_HOME%\IntegrationServer\instances\default\logs\server.log
set WRAPPER_LOGFILE_PATH=%SAG_HOME%\profiles\*\*\wrapper.log

rem **** END ****

%FILEBEAT_HOME%\filebeat.exe -c %~dp0WxMonitoring.yml

endlocal
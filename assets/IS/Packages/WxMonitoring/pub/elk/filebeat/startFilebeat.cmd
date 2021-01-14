@echo off

setlocal

rem **** Please edit these settings ****

set SAG_HOME=C:\SoftwareAG
set FILEBEAT_HOME=C:\WxMonitoring\filebeat-7.1.1
set SERVER_ID=localhost_DEV
set LOGSTASH_HOST=localhost
set LOGSTASH_PORT=5044
set SERVER_LOGFILE_PATH=C:\logs\isLog\server.log


rem set WRAPPER_LOGFILE_PATH=%SAG_HOME%\profiles\*\*\wrapper.log
rem set CUSTOM_LOGFILE_PATH=D:\logs\*.log

rem **** END ****

%FILEBEAT_HOME%\filebeat.exe -c %~dp0WxMonitoring.yml

endlocal
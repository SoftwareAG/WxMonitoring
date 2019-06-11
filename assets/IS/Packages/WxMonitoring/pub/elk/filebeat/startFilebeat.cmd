@echo off

setlocal

rem **** Please edit these settings ****

set SAG_HOME=C:\SAG103
set FILEBEAT_HOME=C:\work\local\filebeat-7.1.1-windows-x86_64
set SERVER_ID=dev1
set LOGSTASH_HOST=localhost
set LOGSTASH_PORT=5044
set SERVER_LOGFILE_PATH=%SAG_HOME%\IntegrationServer\instances\default\logs\server.log
set WRAPPER_LOGFILE_PATH=%SAG_HOME%\profiles\*\*\wrapper.log

rem **** END ****

%FILEBEAT_HOME%\filebeat.exe -c %~dp0WxMonitoring.yml

endlocal
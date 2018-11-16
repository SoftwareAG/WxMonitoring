@echo off

setlocal

set SAG_HOME=C:\sag910
set FILEBEAT_HOME=C:\work\local\filebeat-6.2.3
set SERVER_ID=dev1
set LOGSTASH_HOST=localhost
set LOGSTASH_PORT=5044
set SERVER_LOGFILE_PATH=%SAG_HOME%\IntegrationServer\instances\default\logs\server.log
set WRAPPER_LOGFILE_PATH=%SAG_HOME%\profiless\*\*\wrapper.log

%FILEBEAT_HOME%\filebeat.exe -c %~dp0WxMonitoring.yml

endlocal
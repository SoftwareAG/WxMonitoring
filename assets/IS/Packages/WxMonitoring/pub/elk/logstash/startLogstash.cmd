@echo off

setlocal

rem **** Please edit these settings ****

set SAG_HOME=D:\SoftwareAG
set LOGSTASH_HOME=D:\WxMonitoring\logstash-7.5.1
set LOGSTASH_PORT=5044
set LOGSTASH_HTTP_IMPORT_PORT=5045
set ELASTIC_SEARCH_ADDRESS=http://svawmn00cd:9200
set ELASTIC_SEARCH_LOGSTASH_USER=elastic
set ELASTIC_SEARCH_LOGSTASH_PASSWORD=etemdataundweb
set CURRENT_DIR=%~dp0
set LOGSTASH_CONFIG="%CURRENT_DIR%\*.conf"
rem set LOGSTASH_CONFIG="%CURRENT_DIR%\*.conf"

rem **** END ****

%LOGSTASH_HOME%\bin\logstash.bat --pipeline.id WxMonitoring -w 1 -f %LOGSTASH_CONFIG% --config.reload.automatic

endlocal	
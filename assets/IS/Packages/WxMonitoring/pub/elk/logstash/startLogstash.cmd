@echo off

setlocal

rem **** Please edit these settings ****

set SAG_HOME=C:\work\local\wMServiceDesigner
set LOGSTASH_HOME=C:\work\local\logstash-7.10.1
set LOGSTASH_PORT=5044
set LOGSTASH_HTTP_IMPORT_PORT=5045
set ELASTIC_SEARCH_ADDRESS=http://localhost:9200
set ELASTIC_SEARCH_LOGSTASH_USER=elastic
set ELASTIC_SEARCH_LOGSTASH_PASSWORD=elastic
set CURRENT_DIR=%~dp0
set LOGSTASH_CONFIG="%CURRENT_DIR%\*.conf"
rem set LOGSTASH_CONFIG="%CURRENT_DIR%\*.conf"

rem **** END ****

%LOGSTASH_HOME%\bin\logstash.bat --pipeline.id WxMonitoring -w 1 -f %LOGSTASH_CONFIG% --config.reload.automatic

endlocal	
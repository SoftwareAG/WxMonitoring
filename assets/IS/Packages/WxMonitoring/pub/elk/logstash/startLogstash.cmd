@echo off

setlocal

rem **** Please edit these settings ****

set SAG_HOME=C:\SoftwareAG910
set LOGSTASH_HOME=C:\SoftwareAG910\logstash-6.2.2
set LOGSTASH_PORT=5044
set LOGSTASH_HTTP_IMPORT_PORT=5045
set ELASTIC_SEARCH_ADDRESS=localhost:9200
set CURRENT_DIR=%~dp0
set LOGSTASH_CONFIG="%CURRENT_DIR%\*.conf"

rem **** END ****

%LOGSTASH_HOME%\bin\logstash.bat --pipeline.id WxMonitoring -w 1 -f %LOGSTASH_CONFIG% --config.reload.automatic

endlocal	
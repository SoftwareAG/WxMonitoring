@echo off

setlocal

rem **** Please edit these settings ****

set SAG_HOME=C:\SoftwareAG910
set LOGSTASH_HOME=C:\SoftwareAG910\elastic-stack\logstash\logstash-7.0.1
set LOGSTASH_PORT=5044
set LOGSTASH_HTTP_IMPORT_PORT=5045
set ELASTIC_SEARCH_ADDRESS=localhost:9200
set ELASTIC_SEARCH_LOGSTASH_USER=WxMonitoring_logstash_user
set ELASTIC_SEARCH_LOGSTASH_PASSWORD=logstash
set CURRENT_DIR=%~dp0
set LOGSTASH_CONFIG="%CURRENT_DIR%\*.conf"
rem set LOGSTASH_CONFIG="%CURRENT_DIR%\*.conf"

rem **** END ****

%LOGSTASH_HOME%\bin\logstash.bat --pipeline.id WxMonitoring -w 1 -f %LOGSTASH_CONFIG% --config.reload.automatic

endlocal	
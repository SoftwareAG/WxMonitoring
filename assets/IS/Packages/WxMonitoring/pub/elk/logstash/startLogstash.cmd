@echo off

setlocal

set SAG_HOME=c:\SoftwareAG
set LOGSTASH_HOME=C:\work\local\logstash-6.2.3
set LOGSTASH_PORT=5044
set LOGSTASH_HTTP_IMPORT_PORT=5045
set ELASTIC_SEARCH_ADDRESS=localhost:9200
set LOGSTASH_CONFIG=%~dp0WxMonitoring.conf

%LOGSTASH_HOME%\bin\logstash.bat --pipeline.id WxMonitoring -w 1 -f %LOGSTASH_CONFIG%s

endlocal	
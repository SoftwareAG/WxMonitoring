@echo off

setlocal

set SAG_HOME=C:\SoftwareAG910
set LOGSTASH_HOME=C:\SoftwareAG910\logstash-6.2.2
set LOGSTASH_PORT=5044
set ELASTIC_SEARCH_ADDRESS=localhost:9200

%LOGSTASH_HOME%\bin\logstash.bat --pipeline.id WxMonitoring -w 1 -f %~dp0WxMonitoring.conf

endlocal	
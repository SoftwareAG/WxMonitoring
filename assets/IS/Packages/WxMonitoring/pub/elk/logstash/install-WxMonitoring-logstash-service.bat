@echo off

set NSSM_PATH="D:\WxMonitoring\nssm-2.24\win64"

%NSSM_PATH%\nssm install logstash %~dp0startLogstash.cmd
%NSSM_PATH%\nssm set logstash Description Logstash

net start logstash
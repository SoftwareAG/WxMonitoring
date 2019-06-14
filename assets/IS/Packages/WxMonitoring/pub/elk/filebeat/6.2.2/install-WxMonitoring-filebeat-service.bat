@echo off

set NSSM_PATH="C:\Elastic\nssm-2.24\win64"

%NSSM_PATH%\nssm install filebeat %~dp0startFilebeat.cmd
%NSSM_PATH%\nssm set filebeat Description WxMonitoring Filebeat

net start filebeat
@echo off

set WORKING_DIR=%~dp0
call %WORKING_DIR%.\setenv.bat

setlocal

set REPOS_ESB=%WORKING_DIR%..\assets\IS\Packages
set ESB_PCKGS=%ESB_INSTANCE_HOME%\packages

echo *** link packages %REPOS_ESB% to ESB %ESB_INSTANCE_HOME%

mklink /J %ESB_PCKGS%\WxMonitoring %REPOS_ESB%\WxMonitoring
mklink /J %ESB_PCKGS%\WxMonitoring_CxExt %REPOS_ESB%\WxMonitoring_CxExt

:end

endlocal
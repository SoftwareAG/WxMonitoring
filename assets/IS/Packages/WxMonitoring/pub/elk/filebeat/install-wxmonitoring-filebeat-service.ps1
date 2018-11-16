# delete service if it already exists
if (Get-Service filebeat -ErrorAction SilentlyContinue) {
  $service = Get-WmiObject -Class Win32_Service -Filter "name='filebeat'"
  $service.StopService()
  Start-Sleep -s 1
  $service.delete()
}

$filebeat_home = "C:\SoftwareAG910\filebeat-6.2.2"
$workdir = Split-Path $MyInvocation.MyCommand.Path

# create new service
New-Service -name filebeat `
  -displayName filebeat `
  -binaryPathName "`"$filebeat_home\\filebeat.exe`" -c `"$workdir\\wxmonitoring_filebeat.yml`" -path.home `"$workdir`" -path.data `"C:\\ProgramData\\filebeat`" -path.logs `"C:\\ProgramData\\filebeat\logs`""
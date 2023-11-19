Set-ExecutionPolicy RemoteSigned -Scope Process -Force;
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072;
$uri = "https://github.com/SumoLogic/sumologic-otel-collector/releases/latest/download/install.ps1";
$path="${env:TEMP}\install.ps1"; (New-Object System.Net.WebClient).DownloadFile($uri, $path);
. $path -InstallationToken "U1VNT2ZHd2tFTzNvV3JmU3RwcUhpV1RzRFFBb1FUR0dodHRwczovL2NvbGxlY3RvcnMuc3Vtb2xvZ2ljLmNvbQ==" -Tags @{"host.group" = "SVA-PHXT-QA03"; "deployment.environment" = "qa3"} -InstallHostMetrics $True
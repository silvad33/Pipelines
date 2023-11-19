Set-TimeZone -Id "Eastern Standard Time"

$hostName = [System.Net.Dns]::GetHostName()

& cmd /c "C:\agent\config.cmd --unattended --url $Env:ADO_ORG_URL --auth pat --token $Env:ADO_PAT --agent $hostName --pool `"$Env:AGENT_POOL`""
& cmd /c "C:\agent\run.cmd"
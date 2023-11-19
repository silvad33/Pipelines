echo off
cd C:\temp\
SumoCollector.exe -console -q "-Vsumo.token_and_url=%SUMO_LOGIC_INSTALLER_TOKEN%" "-Vcollector.name=%COLLECTOR_NAME%" "-Vclobber=true"
ping -t localhost > NUL
$ProgressPreference = 'SilentlyContinue'
New-Item -Path c:\agent -Type Directory
New-Item -Path c:\temp -Type Directory

Write-Host 'Download VSTS Agent...'
Invoke-WebRequest https://vstsagentpackage.azureedge.net/agent/2.217.2/vsts-agent-win-x64-2.217.2.zip -OutFile C:\temp\vsts-agent.zip
Expand-Archive -Path c:\temp\vsts-agent.zip -DestinationPath c:\agent

Write-Host 'Download and Install DAC FX...'
Invoke-WebRequest https://aka.ms/dacfx-msi -OutFile C:\temp\DacFramework.msi
& cmd /c "msiexec /i c:\temp\DacFramework.msi /quiet /norestart"

Write-Host 'Download Sumo Logic Collector...'
Invoke-WebRequest https://collectors.sumologic.com/rest/download/win64 -OutFile C:\temp\SumoCollector.exe

Write-Host 'Download NT Rights...'
Invoke-WebRequest https://presidiopublic.blob.core.windows.net/public/ntrights.exe -OutFile C:\temp\ntrights.exe

foreach ($CipherSuite in $(Get-TlsCipherSuite).Name)
{
    if ( $CipherSuite.substring(0,7) -eq "TLS_DHE" )
    {
       Disable-TlsCipherSuite -Name $CipherSuite
    }
}

set-item WSMan:\localhost\Client\TrustedHosts -Value "10.10.10.170" -Concatenate -Force
set-item WSMan:\localhost\Client\TrustedHosts -Value "SVA-MO-DB01" -Concatenate -Force

New-Item 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.0\Server' -Force
New-Item 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.0\Client' -Force
New-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.0\Server' -name 'Enabled' -value '0' -PropertyType 'DWORD'
New-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.0\Server' -name 'DisabledByDefault' -value '1' -PropertyType 'DWORD'
New-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.0\Client' -name 'Enabled' -value '0' -PropertyType 'DWORD'
New-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.0\Client' -name 'DisabledByDefault' -value '1' -PropertyType 'DWORD'

New-Item 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.1\Server' -Force
New-Item 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.1\Client' -Force
New-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.1\Server' -name 'Enabled' -value '0' -PropertyType 'DWORD'
New-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.1\Server' -name 'DisabledByDefault' -value '1' -PropertyType 'DWORD'
New-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.1\Client' -name 'Enabled' -value '0' -PropertyType 'DWORD'
New-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.1\Client' -name 'DisabledByDefault' -value '1' -PropertyType 'DWORD'

New-Item 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Server' -Force
New-Item 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Client' -Force
New-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Server' -name 'Enabled' -value '1' -PropertyType 'DWORD'
New-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Server' -name 'DisabledByDefault' -value '0' -PropertyType 'DWORD'
New-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Client' -name 'Enabled' -value '1' -PropertyType 'DWORD'
New-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Client' -name 'DisabledByDefault' -value '0' -PropertyType 'DWORD'

New-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Services\RasMan\PPP\EAP\13' -Name 'TlsVersion'  -value '0' -PropertyType 'DWORD'
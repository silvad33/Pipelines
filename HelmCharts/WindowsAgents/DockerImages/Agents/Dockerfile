FROM mcr.microsoft.com/windows/servercore:ltsc2022

COPY *.ps1 C:/
COPY *.json C:/sources/

RUN powershell ./dockerinit.ps1

ENTRYPOINT ["powershell.exe", ".\\dockerentry.ps1"]
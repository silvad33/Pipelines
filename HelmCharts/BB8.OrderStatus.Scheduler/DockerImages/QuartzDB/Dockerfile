FROM mcr.microsoft.com/mssql-tools

COPY bb8OrderStatus.sql /bb8OrderStatus.sql
COPY poststart.sh /poststart.sh

RUN chmod +x /bb8OrderStatus.sql \
 && chmod +x /poststart.sh

ENTRYPOINT ["/bin/bash", "poststart.sh"]
echo 1048576 > /proc/sys/fs/aio-max-nr
sed -i 's@MSSQL_QUARTZ_PASSWORD@'"$MSSQL_QUARTZ_PASSWORD"'@g' $QUARTZ_DB_CREATION_SCRIPT
sleep 60
/opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P $MSSQL_SA_PASSWORD -i $QUARTZ_DB_CREATION_SCRIPT
sleep infinity
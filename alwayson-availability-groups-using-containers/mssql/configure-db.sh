#!/bin/bash

# Wait for SQL Server to start up by ensuring that
# calling SQLCMD does not return an error code, which will ensure that sqlcmd is accessible
# and that system and user databases return "0" which means all databases are in an "online" state
# https://docs.microsoft.com/en-us/sql/relational-databases/system-catalog-views/sys-databases-transact-sql?view=sql-server-2017

DBSTATUS=1
ERRCODE=1
i=0

TIMEOUT=60

sleep 90s
echo ":: $(date '+%F %T') Waiting for SQL Server to start"

while [[ $DBSTATUS -ne 0 ]] && [[ $i -lt $TIMEOUT ]] && [[ $ERRCODE -ne 0 ]]; do
    i=$i+1
    DBSTATUS=$(/opt/mssql-tools18/bin/sqlcmd -h -1 -t 1 -C -U sa -P $MSSQL_SA_PASSWORD -Q "SET NOCOUNT ON; select SUM(state) from sys.databases" | tr -d '[:space:]')
    ERRCODE=$?
    sleep 1
done

if [[ $DBSTATUS -ne 0 ]] || [[ $ERRCODE -ne 0 ]]; then
    echo ":: $(date '+%F %T') SQL Server took more than ${TIMEOUT} seconds to start up or one or more databases are not in an ONLINE state"
    exit 1
fi

echo ":: $(date '+%F %T') Setting up the Availability Group"
# We run this only from the first node that will be the primary
if [[ $(hostname -s) = "sql_node_01" ]]; then
    /opt/mssql-tools18/bin/sqlcmd -S localhost -C -U sa -P $MSSQL_SA_PASSWORD -d master -i /usr/config/ag.sql
    /opt/mssql-tools18/bin/sqlcmd -S localhost -C -U sa -P $MSSQL_SA_PASSWORD -d master -i /usr/config/ag-listener.sql
fi

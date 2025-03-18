#!/bin/bash

# Exit immediately if a command fails
set -e

echo "Granting execute permissions to SQL Server scripts..."
chmod +x /usr/config/entrypoint.sh
chmod +x /usr/config/configure-db.sh
chown -R mssql /usr/config

echo "Granting SQL Server permissions for non-root execution..."
setcap 'cap_net_bind_service+ep' /opt/mssql/bin/sqlservr

echo "Allowing dumps from non-root processes..."
setcap 'cap_sys_ptrace+ep' /opt/mssql/bin/paldumper
setcap 'cap_sys_ptrace+ep' /usr/bin/gdb

echo "Configuring dynamic linking for SQL Server..."
mkdir -p /etc/ld.so.conf.d
touch /etc/ld.so.conf.d/mssql.conf
echo -e "# mssql libs\n/opt/mssql/lib" > /etc/ld.so.conf.d/mssql.conf
ldconfig

echo "Enabling HADR (High Availability and Disaster Recovery)..."
/opt/mssql/bin/mssql-conf set hadr.hadrenabled 1

echo "Enabling SQL Agent..."
/opt/mssql/bin/mssql-conf set sqlagent.enabled true

echo "SQL Server configuration completed successfully."
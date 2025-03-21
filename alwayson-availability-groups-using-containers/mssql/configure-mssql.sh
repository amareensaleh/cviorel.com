#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

export DEBIAN_FRONTEND=noninteractive
export TZ=America/New_York

#echo "Updating system and installing required packages..."
#apt-get update && apt-get install -yq wget software-properties-common apt-transport-https tzdata locales libcap2-bin

echo "Setting up timezone..."
ln -snf /usr/share/zoneinfo/$TZ /etc/localtime
echo $TZ > /etc/timezone
dpkg-reconfigure --frontend noninteractive tzdata

echo "Setting locale..."
locale-gen en_US.UTF-8

echo "Cleaning up unused packages..."
apt-get clean && apt-get autoremove -y

#echo "Creating required directories..."
mkdir -p /var/opt/sqlserver/data /var/opt/sqlserver/log /var/opt/sqlserver/backup
chown -R mssql /var/opt/sqlserver
chown -R mssql /var/opt/mssql

echo "Granting permissions for non-root execution..."
setcap 'cap_net_bind_service+ep' /opt/mssql/bin/sqlservr
setcap 'cap_sys_ptrace+ep' /opt/mssql/bin/paldumper
setcap 'cap_sys_ptrace+ep' /usr/bin/gdb

echo "Setting up dynamic linking for SQL Server..."
mkdir -p /etc/ld.so.conf.d
echo -e "# mssql libs\n/opt/mssql/lib" > /etc/ld.so.conf.d/mssql.conf
ldconfig

echo "Enabling HADR and SQL Agent..."
/opt/mssql/bin/mssql-conf set hadr.hadrenabled  1
/opt/mssql/bin/mssql-conf set sqlagent.enabled true

echo "Installation and configuration completed successfully."
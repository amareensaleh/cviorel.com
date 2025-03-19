
:SETVAR node_01 "sql_node_01"
:SETVAR node_02 "sql_node_02"
:SETVAR node_03 "sql_node_03"
:SETVAR sa_user "sa"

:r /usr/config/miscpassword.env

/*
create login, master key and certificate on primary
*/
:CONNECT $(node_01) -U $(sa_user) -P $(sa_password)
USE master
GO

ALTER AVAILABILITY GROUP [AG1]
    ADD LISTENER 'AG1_Listener' (WITH IP(('172.16.238.30', '255.255.255.0')), PORT = 1500);
GO


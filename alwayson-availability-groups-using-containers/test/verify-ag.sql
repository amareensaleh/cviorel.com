SELECT *
FROM sys.availability_groups;

SELECT *
FROM sys.availability_replicas;

SELECT *
FROM sys.dm_hadr_database_replica_states

SELECT *
FROM sys.dm_xe_sessions
WHERE name = 'AlwaysOn_health';

SELECT *
FROM sys.availability_group_listeners;

SELECT ag.name, ar.replica_server_name, ars.role_desc, ars.synchronization_health_desc
FROM sys.dm_hadr_availability_replica_states ars
         JOIN sys.availability_replicas ar ON ars.replica_id = ar.replica_id
         JOIN sys.availability_groups ag ON ar.group_id = ag.group_id;

SELECT name, state_desc, is_encryption_enabled, type_desc
FROM sys.database_mirroring_endpoints;

SELECT * FROM sys.tcp_endpoints WHERE name = 'Hadr_endpoint';

SELECT * FROM sys.certificates WHERE name = 'dbm_certificate';

SELECT database_name FROM sys.availability_databases_cluster;

SELECT group_id, replica_id, * FROM sys.availability_replicas;

SELECT *
FROM sys.dm_hadr_database_replica_states;

SELECT ag.name, ar.replica_server_name, ars.role_desc, ars.synchronization_health_desc
FROM sys.dm_hadr_availability_replica_states ars
         JOIN sys.availability_replicas ar ON ars.replica_id = ar.replica_id
         JOIN sys.availability_groups ag ON ar.group_id = ag.group_id;
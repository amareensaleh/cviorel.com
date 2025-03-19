SELECT resource_group_id
FROM sys.availability_groups;

SELECT *
FROM sys.availability_replicas;

SELECT *
FROM sys.dm_hadr_database_replica_states

SELECT *
FROM sys.dm_hadr_availability_replica_states

SELECT *
FROM sys.dm_xe_sessions
WHERE name = 'AlwaysOn_health';

-- Check availability group listeners
select *
from sys.availability_group_listener_ip_addresses

SELECT *
FROM sys.availability_group_listeners;

SELECT *
FROM sys.dm_tcp_listener_states;

-- Check availability group health and roles
SELECT distinct ag.name as vailability_group_name, ar.replica_server_name replica_server_name, ars.role_desc as role, drs.synchronization_state_desc as sync, ars.synchronization_health_desc as health
FROM sys.dm_hadr_availability_replica_states ars
         JOIN sys.availability_replicas ar ON ars.replica_id = ar.replica_id
         JOIN sys.dm_hadr_database_replica_states drs ON ars.replica_id = ar.replica_id
         JOIN sys.availability_groups ag ON ar.group_id = ag.group_id;

-- Check HA endpoint
SELECT name, state_desc, is_encryption_enabled, type_desc
FROM sys.database_mirroring_endpoints;

SELECT * FROM sys.tcp_endpoints as tcpe WHERE name = 'Hadr_endpoint';

-- check certificates
SELECT * FROM sys.certificates

-- Check availability database
SELECT * FROM sys.availability_databases_cluster;
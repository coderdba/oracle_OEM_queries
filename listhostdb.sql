set lines 120
set pages 1000

column target_type format a20
column cluster_name format a20
column host_name format a25
column target_name format a25
column database_name format a25
column component_version format a10
column component_base_version format a10


spool listhostdb

/*
select distinct a.composite_target_name cluster_name, b.host_name, b.target_name database_name, c.component_version
from   mgmt_target_memberships a,
       mgmt$target b,
       mgmt$target_components c
where  a.member_target_name = b.host_name
and    a.composite_target_type='cluster'
and    a.member_target_type = 'host'
and    c.target_type='oracle_database'
and    c.host_name= b.host_name
order by 1, 2, 3;
*/

select a.composite_target_name cluster_name, b.host_name, b.target_name, b.component_version
from   mgmt_target_memberships a,
(select distinct target_type, host_name, target_name, component_version
from MGMT$TARGET_COMPONENTS where target_type='oracle_database'
) b
where a.member_target_name = b.host_name
and a.composite_target_type='cluster'
and a.member_target_type = 'host'
order by 1, 2, 4, 3
;

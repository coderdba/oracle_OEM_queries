spool greenpiedb

set lines 120
set pages 1000

-- INFO - TARGET_TYPE  of oracle_database denotes instance

column target_type format a25
column target_name format a25
column os format a15
column host_name format a35
column availability_status format a20


prompt ===========================
prompt INFO - ALL COUNTS by status
prompt ===========================

select availability_status, count(*)
from  mgmt$availability_current
where target_type = 'oracle_database'
group by availability_status
order by availability_status;

select a.availability_status, 'AIX' os, count(*)
from  mgmt$availability_current a,
      mgmt$target b,
      mgmt$os_hw_summary c
where a.target_type = 'oracle_database'
and   a.target_name = b.target_name
and   b.host_name = c.host_name
and   c.os_summary like 'AIX%'
group by a.availability_status
order by a.availability_status;


select a.availability_status, 'Red Hat' os, count(*)
from  mgmt$availability_current a,
      mgmt$target b,
      mgmt$os_hw_summary c
where a.target_type = 'oracle_database'
and   a.target_name = b.target_name
and   b.host_name = c.host_name
and   c.os_summary like 'Red%'
group by a.availability_status
order by a.availability_status;

select a.availability_status, 'Sun Solaris' os, count(*)
from  mgmt$availability_current a,
      mgmt$target b,
      mgmt$os_hw_summary c
where a.target_type = 'oracle_database'
and   a.target_name = b.target_name
and   b.host_name = c.host_name
and   c.os_summary like 'Sun%'
group by a.availability_status
order by a.availability_status;


select a.availability_status, substr(c.os_summary, 1, 15) os, count(*)
from  mgmt$availability_current a,
      mgmt$target b,
      mgmt$os_hw_summary c
where a.target_type = 'oracle_database'
and   a.target_name = b.target_name
and   b.host_name = c.host_name
group by substr(c.os_summary, 1, 15), a.availability_status
order by substr(c.os_summary, 1, 15), a.availability_status;



prompt ===========================
prompt INFO - RAC PROD
prompt ===========================
prompt
prompt INFO - Count by status
prompt

select 'RAC PROD',
availability_status, count(*)
from  mgmt$availability_current
where target_type = 'oracle_database'
and   target_name like 'RACPROD%'
group by 'RAC PROD', availability_status
order by availability_status;

prompt
prompt INFO - List of NOT-UP databases
prompt

--select target_name,
----target_type,
--availability_status
--from  mgmt$availability_current
--where target_type = 'oracle_database'
--and   availability_status != 'Target Up'
--and   target_name like 'RACPROD%'
--order by availability_status, target_name;

select a.target_name, a.availability_status, b.host_name, substr(c.os_summary, 1, 15) os
from  mgmt$availability_current a,
      mgmt$target b,
      mgmt$os_hw_summary c
where a.target_type = 'oracle_database'
and   a.availability_status != 'Target Up'
and   a.target_name like 'RACPROD%'
and   a.target_name = b.target_name
and   b.host_name = c.host_name
order by a.availability_status, a.target_name;


prompt ===========================
prompt INFO - AIX PROD
prompt ===========================
prompt
prompt INFO - Count by status
prompt

select 'AIX PROD',
availability_status, count(*)
from  mgmt$availability_current
where target_type = 'oracle_database'
and   (target_name like 'ABCP%'
 or    target_name like 'PQRP%'
)
group by 'AIX PROD', availability_status
order by availability_status;

prompt
prompt INFO - List of NOT-UP databases
prompt

select a.target_name, a.availability_status, b.host_name, substr(c.os_summary, 1, 15) os
from  mgmt$availability_current a,
      mgmt$target b,
      mgmt$os_hw_summary c
where a.target_type = 'oracle_database'
and   a.availability_status != 'Target Up'
and   a.target_name = b.target_name
and   b.host_name = c.host_name
and   (a.target_name like 'ABCP%'
 or    a.target_name like 'PQRP%'
)
order by a.availability_status, a.target_name;

prompt ===========================
prompt INFO - RAC NON PROD
prompt ===========================
prompt
prompt INFO - Count by status
prompt

select 'RAC NON PROD',
availability_status, count(*)
from  mgmt$availability_current
where target_type = 'oracle_database'
and   target_name like 'RACPROD%'
group by 'RAC NON PROD', availability_status
order by availability_status;

prompt
prompt INFO - List of NOT-UP databases
prompt

select a.target_name, a.availability_status, b.host_name, substr(c.os_summary, 1, 15) os
from  mgmt$availability_current a,
      mgmt$target b,
      mgmt$os_hw_summary c
where a.target_type = 'oracle_database'
and   a.availability_status != 'Target Up'
and   a.target_name = b.target_name
and   b.host_name = c.host_name
and   a.target_name like 'RACNP%'
order by a.availability_status, a.target_name;

prompt ===========================
prompt INFO - NON RAC PROD
prompt ===========================
prompt
prompt INFO - Count by status
prompt

select 'NON RAC PROD',
availability_status, count(*)
from  mgmt$availability_current
where target_type = 'oracle_database'
and   target_name like '___P%'
group by 'NON RAC PROD', availability_status
order by availability_status;

prompt
prompt INFO - List of NOT-UP databases
prompt

select a.target_name, a.availability_status, b.host_name, substr(c.os_summary, 1, 15) os
from  mgmt$availability_current a,
      mgmt$target b,
      mgmt$os_hw_summary c
where a.target_type = 'oracle_database'
and   a.availability_status != 'Target Up'
and   a.target_name = b.target_name
and   b.host_name = c.host_name
and   a.target_name like '___P%'
order by a.availability_status, a.target_name;

/*

-- MGMT_TARGET_OBJ
-- MGMT$TARGET

SELECT target_type, availability_status, COUNT(*)
FROM   mgmt$availability_current
group by target_type, availability_status
order by 1,2;



SELECT aggregate_target_type, availability_status, COUNT(*)
FROM   mgmt$availability_current
group by target_type, availability_status
order by 1,2;


select AGGREGATE_TARGET_NAME, MEMBER_TARGET_TYPE, MEMBER_TARGET_NAME, availability_status
from mgmt$availability_current ac,
     mgmt$target_members tm
where ac.TARGET_GUID=tm.MEMBER_TARGET_GUID
  and ac.availability_status != 'Target Up'
  and tm.AGGREGATE_TARGET_TYPE='oracle_dbsys'
order by 1,2
;



SQL> select target_name, instance_name from MGMT$DB_DBNINSTANCEINFO  where target_name like 'RP10DB1%' order by 1, 2;

*/


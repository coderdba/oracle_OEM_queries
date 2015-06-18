set linesize 132 pagesize 10000 head off
col host_name for a30
col target_name for a20
col tablespace_name for a20
col "TOTAL SIZE (GB)" for 9999999.99
col "USED (GB)" for  9999999.99
--report round ("TOTAL SIZE (GB)",2)
--report round ("USED (GB)",2)
select sum(t.TABLESPACE_SIZE/1024/1024/1024)
from
sysman.mgmt$db_tablespaces t,
sysman.mgmt$target tt
where
tt.type_qualifier3='DB' and
tt.target_name=t.target_name
;

set linesize 132 pagesize 10000 head off
set feedback off
col host_name for a30
col target_name for a20
col tablespace_name for a20
col TOTAL_GB for 9999999.99
col USED_GB for  9999999.99
--report round ("TOTAL SIZE (GB)",2)
--report round ("USED (GB)",2)
spool /opt/oracle/inf/storage/tablespace_info.log
select t.HOST_NAME||','||t.TARGET_NAME||','||t.TABLESPACE_NAME||','||round(t.TABLESPACE_SIZE/1024/1024/1024,2)||','||round(t.TABLESPACE_USED_SIZE/1024/1024/1024,2)||','||tt.LAST_METRIC_LOAD_TIME
from
sysman.mgmt$db_tablespaces t,
sysman.mgmt$target tt
where
tt.type_qualifier3='DB' and
tt.target_name=t.target_name
--and rownum < 10
order by t.host_name, t.target_name, t.tablespace_name;
spool off
exit;
/

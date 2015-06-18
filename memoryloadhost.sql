spool memoryloadhost

set lines 100
set pages 1000
column target_name format a30
column cluster_name format a30
column host_name format a30
column column_label format a30
column avg format 90.99
column min format 90.99
column max format 90.99
column stdev format 90.99

prompt ==================================
prompt    DAILY MEMORY LOAD OF RAC HOSTS
prompt ==================================

select upper(a.composite_target_name) cluster_name, a.member_target_name host_name,
       b.rollup_timestamp, b.average avg, b.minimum min, b.maximum max, b.standard_deviation stdev
from   mgmt_target_memberships a,
       mgmt$metric_daily b
where a.composite_target_type='cluster'
and   a.member_target_type = 'host'
and   a.member_target_name = b.target_name
and   b.metric_name = 'Load'
and   b.metric_column = 'memUsedPct'
order by 1,2,3;

spool off


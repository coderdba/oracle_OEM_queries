spool rachostsummary

-- http://superuser.com/questions/311777/proc-cpuinfo-gives-cpu-info-per-core-or-per-thread

set lines 150
set pages 1500

column cluster_name  format a16
column num_hosts     format 999
column host_name     format a25
column system_config format a30
column freq          format 999999
column freq_avg      format 999999
column mem           format 999999999
column disk          format 999999
column cpu_count     format 99990
column cores         format 99990
column phy_cpu       format 99990
column logical_cpu   format 99990
column RAC_HOST_COUNT_TOTAL   format 99999999999999999990


prompt
prompt=============================================
prompt RAC Clusters - Hardware Summary GRAND TOTAL
prompt=============================================
prompt

select count(*) num_hosts,
       sum(b.mem) mem,
       sum(b.cpu_count) cpu_count,
       sum(b.total_cpu_cores) cores,
       sum(b.physical_cpu_count) phy_cpu,
       sum(b.logical_cpu_count) logical_cpu,
       avg(freq) freq_avg
from   mgmt_target_memberships a,
       mgmt$os_hw_summary b
where a.composite_target_type='cluster'
and   a.member_target_type = 'host'
and   a.member_target_name = b.host_name
;


prompt
prompt======================================
prompt RAC Clusters - Cluster Count TOTAL
prompt======================================
prompt

select count(*) RAC_CLUSTER_COUNT_TOTAL
from   mgmt$target a
where  a.target_type='cluster'
;


prompt
prompt======================================
prompt RAC Clusters - Cluster List
prompt======================================
prompt

select target_name CLUSTER_NAME
from   mgmt$target a
where  a.target_type='cluster'
order by 1
;


prompt
prompt======================================
prompt RAC Clusters - Host Count TOTAL
prompt======================================
prompt

select count(*) RAC_HOST_COUNT_TOTAL
from   mgmt_target_memberships a,
       mgmt$os_hw_summary b
where a.composite_target_type='cluster'
and   a.member_target_type = 'host'
and   a.member_target_name = b.host_name
;

prompt
prompt======================================
prompt RAC Clusters - Host Details
prompt======================================
prompt

select upper(a.composite_target_name) cluster_name, a.member_target_name host_name,
       b.system_config, b.freq, b.mem, b.disk, b.cpu_count, b.total_cpu_cores cores, b.physical_cpu_count phy_cpu, b.logical_cpu_count logical_cpu, b.virtual
from   mgmt_target_memberships a,
       mgmt$os_hw_summary b
where a.composite_target_type='cluster'
and   a.member_target_type = 'host'
and   a.member_target_name = b.host_name
order by 1,2;


prompt
prompt======================================
prompt RAC Clusters - Cluster level summary
prompt======================================
prompt

select upper(a.composite_target_name) cluster_name,
count(*) num_hosts,
--b.system_config,
--b.freq,
       sum(b.mem) mem,
       sum(b.cpu_count) cpu_count,
       sum(b.total_cpu_cores) cores,
       sum(b.physical_cpu_count) phy_cpu,
       sum(b.logical_cpu_count) logical_cpu,
       avg(freq) freq_avg
from   mgmt_target_memberships a,
       mgmt$os_hw_summary b
where a.composite_target_type='cluster'
and   a.member_target_type = 'host'
and   a.member_target_name = b.host_name
group by  upper(a.composite_target_name)
--, b.system_config
--,b.freq
order by 1,2;



spool off

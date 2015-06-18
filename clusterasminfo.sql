set linesize 132 pagesize 10000 head off
set feedback off
spool /opt/oracle/inf/storage/cluster_asm_info.log
select upper(replace(TARGET_NAME,'+ASM_',''))||','||DISKGROUP||','||
round(TOTAL_MB/1024,2) ||','||
round(FREE_MB/1024,2) ||','||
round((TOTAL_MB/1024-FREE_MB/1024),2) ||','||
round(PERCENT_USED,2) ||','||
(case
        when PERCENT_USED >= 85 then 'ALERT'
        when PERCENT_USED >= 70 then 'WARNING'
        else 'FINE'
        END
) ||','||sysdate
 from
(Select t.target_name,key_value as "DISKGROUP",metric_column,value,t.load_timestamp
from mgmt_metrics m1 , mgmt_current_metrics m2,mgmt_targets t
where m1.metric_guid = m2.metric_guid
and (key_value like '%DATA_DG%' or key_value like '%FRA_DG%')
and m2.target_guid = t.target_guid
and m1.metric_name = 'DiskGroup_Usage'
and (m1.metric_column = 'free_mb' or m1.metric_column = 'total_mb' or m1.metric_column ='percent_used')
and m1.target_type = 'osm_cluster'
and m1.type_meta_ver = t.type_meta_ver
group by key_value ,t.target_name,metric_column,value,t.load_timestamp)
pivot(sum(value) for (metric_column) in ('total_mb' as TOTAL_MB,'free_mb' as FREE_MB,'percent_used' as PERCENT_USED));
spool off
exit;
/

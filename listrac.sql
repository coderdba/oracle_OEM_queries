select 'RAC PROD LISTENER',
a.AVAILABILITY_STATUS, count(*)
from  mgmt$availability_current a,
      mgmt$target b
where a.target_type = 'oracle_listener'
and   a.target_name = b.target_name
and   a.target_guid = b.target_guid
--and   availability_status != 'Target Up'
and   b.host_name in
(select host_name
   from mgmt$target
  where target_name like 'RP%'
    and target_type = 'oracle_database'
)
group by 'RAC PROD LISTENER', a.AVAILABILITY_STATUS
order by a.AVAILABILITY_STATUS;

select 'RAC PROD LISTENER',
a.AVAILABILITY_STATUS, count(*)
from  mgmt$availability_current a,
      mgmt$target b
where a.target_type = 'oracle_listener'
and   a.target_name = b.target_name
and   a.target_guid = b.target_guid
and   b.host_name in
(select host_name
   from mgmt$target
  where target_name like 'RP%'
    and target_type = 'oracle_database'
)
group by 'RAC PROD LISTENER', a.AVAILABILITY_STATUS
order by a.AVAILABILITY_STATUS;


prompt
prompt INFO - List of NOT-UP listener
prompt

select a.target_name, b.host_name,
       a.AVAILABILITY_STATUS
from  mgmt$availability_current a,
      mgmt$target b
where a.target_type = 'oracle_listener'
and   a.target_name = b.target_name
and   a.target_guid = b.target_guid
and   availability_status != 'Target Up'
and   b.host_name in
(select host_name
   from mgmt$target
  where target_name like 'RP%'
    and target_type = 'oracle_database'
)
order by 3,2,1;

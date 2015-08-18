-- Lifecycle status of all targets 
-- CAUTION - this lists for each DB its rac-database, instances etc as well)
select t.target_name, t.target_type,  d.property_name,
       d.property_display_name, p.property_value
     from mgmt$target t,
          mgmt$target_properties p,
          mgmt$all_target_prop_defs d
     where t.target_guid=p.target_guid
       and p.property_name=d.property_name
       and p.property_value is not null
       and d.property_display_name = 'LifeCycle Status';


-- Lifecycle status for DB's only (distinct by instance)
-- CAUTION - this may list one db twice if primary and standby are created on different dates
--           WORKAROUND - remove 'creation date' from the select list
select distinct a.database_name, a.creation_date, d.property_display_name, p.property_value
from  mgmt$db_dbninstanceinfo a,  mgmt$target t, mgmt$target_properties p, mgmt$all_target_prop_defs d
where a.target_guid = t.target_guid and a.database_name= 'RP16DB2'
       and t.target_guid=p.target_guid
       and p.property_name=d.property_name
       and p.property_value is not null
       and d.property_display_name = 'LifeCycle Status';
       


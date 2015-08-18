--https://oramanageability.wordpress.com/2013/10/07/leverage-sysman-schema-database-inventory-and-target-lifecycles/

select distinct database_name, trim(host_name), instance_name, creation_date
from mgmt$db_dbninstanceinfo where DATABASE_NAME = 'a db name'
order by 1,3;

select a.TARGET_NAME, a.database_name, b.target_name, b.target_type 
from  mgmt$db_dbninstanceinfo a,  mgmt$target b
where a.target_guid = b.target_guid and a.database_name= 'a db name';


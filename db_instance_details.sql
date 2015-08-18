--https://oramanageability.wordpress.com/2013/10/07/leverage-sysman-schema-database-inventory-and-target-lifecycles/

select distinct database_name, trim(host_name), instance_name, creation_date
from mgmt$db_dbninstanceinfo where DATABASE_NAME like '<a non-rac db name>%' or DATABASE_NAME like '<<a rac db name>>%'
order by 1,3;

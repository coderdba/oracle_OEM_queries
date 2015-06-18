select target_name from sysman.mgmt$target_components where TARGET_TYPE='oracle_database'; -- returns the list of the databases.

select HOST_NAME,TARGET_NAME,TABLESPACE_NAME,TABLESPACE_SIZE,TABLESPACE_USED_SIZE from sysman.mgmt$db_tablespaces
;

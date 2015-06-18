spool greenpiedb

set lines 100
set pages 1000

-- INFO - TARGET_TYPE  of oracle_database denotes instance

column target_type format a25
column target_name format a25
column AVAILABILITY_STATUS format a40


prompt ===========================
prompt INFO - ALL COUNTS by status
prompt ===========================

select
--target_type,
AVAILABILITY_STATUS, count(*)
from  mgmt$availability_current
where target_type = 'oracle_database'
--and   availability_status != 'Target Up'
group by AVAILABILITY_STATUS
order by AVAILABILITY_STATUS;


prompt ===========================
prompt INFO - RAC PROD
prompt ===========================
prompt
prompt INFO - Count by status
prompt

select 'RAC PROD',
--target_type,
AVAILABILITY_STATUS, count(*)
from  mgmt$availability_current
where target_type = 'oracle_database'
--and   availability_status != 'Target Up'
and   target_name like 'RACPROD%'
group by 'RAC PROD', AVAILABILITY_STATUS
order by AVAILABILITY_STATUS;

prompt
prompt INFO - List of NOT-UP databases
prompt

select target_name,
--target_type,
AVAILABILITY_STATUS
from  mgmt$availability_current
where target_type = 'oracle_database'
and   availability_status != 'Target Up'
and   target_name like 'RACPROD%'
order by AVAILABILITY_STATUS, target_name;



prompt ===========================
prompt INFO - AIX PROD
prompt ===========================
prompt
prompt INFO - Count by status
prompt

select 'AIX PROD',
--target_type,
AVAILABILITY_STATUS, count(*)
from  mgmt$availability_current
where target_type = 'oracle_database'
--and   availability_status != 'Target Up'
and   (target_name like 'ABC%'
 or    target_name like 'PQR%'

)
group by 'AIX PROD', AVAILABILITY_STATUS
order by AVAILABILITY_STATUS;

prompt
prompt INFO - List of NOT-UP databases
prompt

select target_name,
--target_type,
AVAILABILITY_STATUS
from  mgmt$availability_current
where target_type = 'oracle_database'
and   availability_status != 'Target Up'
and   (target_name like 'ABC%'
 or    target_name like 'PQR%'
)
order by AVAILABILITY_STATUS, target_name;



prompt ===========================
prompt INFO - RAC NON PROD
prompt ===========================
prompt
prompt INFO - Count by status
prompt

select 'RAC NON PROD',
--target_type,
AVAILABILITY_STATUS, count(*)
from  mgmt$availability_current
where target_type = 'oracle_database'
--and   availability_status != 'Target Up'
and   target_name like 'RACNP%'
group by 'RAC NON PROD', AVAILABILITY_STATUS
order by AVAILABILITY_STATUS;

prompt
prompt INFO - List of NOT-UP databases
prompt

select target_name,
--target_type,
AVAILABILITY_STATUS
from  mgmt$availability_current
where target_type = 'oracle_database'
and   availability_status != 'Target Up'
and   target_name like 'RACNP%'
order by AVAILABILITY_STATUS, target_name;


prompt ===========================
prompt INFO - NON RAC PROD
prompt ===========================
prompt
prompt INFO - Count by status
prompt

select 'NON RAC PROD',
--target_type,
AVAILABILITY_STATUS, count(*)
from  mgmt$availability_current
where target_type = 'oracle_database'
--and   availability_status != 'Target Up'
and   target_name like '___P%'
group by 'NON RAC PROD', AVAILABILITY_STATUS
order by AVAILABILITY_STATUS;

prompt
prompt INFO - List of NOT-UP databases
prompt

select target_name,
--target_type,
AVAILABILITY_STATUS
from  mgmt$availability_current
where target_type = 'oracle_database'
and   availability_status != 'Target Up'
and   target_name like '___P%'
order by AVAILABILITY_STATUS, target_name;


prompt ===========================
prompt INFO - REMAINING ONES
prompt ===========================
prompt
prompt INFO - Count by status
prompt

select 'REMAINING ONES',
--target_type,
AVAILABILITY_STATUS, count(*)
from  mgmt$availability_current
where target_type = 'oracle_database'
--and   availability_status != 'Target Up'
and   target_name not like 'RACPROD%'
and   target_name not like 'RACNP%'
and   target_name not like '___P%'
and   target_name not like '____'
and   (target_name not like 'ABC%'
 or    target_name not like 'PQR%'
)
group by 'REMAINING ONES', AVAILABILITY_STATUS
order by AVAILABILITY_STATUS;

prompt
prompt INFO - List of NOT-UP databases
prompt

select target_name,
--target_type,
AVAILABILITY_STATUS
from  mgmt$availability_current
where target_type = 'oracle_database'
and   availability_status != 'Target Up'
and   target_name not like 'RACPROD%'
and   target_name not like 'RACNP%'
and   target_name not like '___P%'
and   target_name not like '____'
and   (target_name not like 'ABC%'
 or    target_name not like 'PQR%'
)
order by AVAILABILITY_STATUS, target_name;


/*

-- MGMT_TARGET_OBJ
-- MGMT$TARGET

SELECT target_type, availability_status, COUNT(*)
FROM   mgmt$availability_current
group by target_type, availability_status
order by 1,2;



SELECT aggregate_target_type, availability_status, COUNT(*)
FROM   mgmt$availability_current
group by target_type, availability_status
order by 1,2;


select AGGREGATE_TARGET_NAME, MEMBER_TARGET_TYPE, MEMBER_TARGET_NAME, AVAILABILITY_STATUS
from mgmt$availability_current ac,
     mgmt$target_members tm
where ac.TARGET_GUID=tm.MEMBER_TARGET_GUID
  and ac.AVAILABILITY_STATUS != 'Target Up'
  and tm.AGGREGATE_TARGET_TYPE='oracle_dbsys'
order by 1,2
;



SQL> select target_name, instance_name from MGMT$DB_DBNINSTANCEINFO  where target_name like 'RP10DB1%' order by 1, 2;

-- Required views
--MGMT$DB_DBNINSTANCEINFO
-- SQL> desc MGMT$DB_DBNINSTANCEINFO
--  Name                                                  Null?    Type
--  ===========================-------------------------- -------- ===========================---------
--  HOST_NAME                                                      VARCHAR2(256)
--  TARGET_NAME                                           NOT NULL VARCHAR2(256)
--  TARGET_TYPE                                           NOT NULL VARCHAR2(64)
--  TARGET_GUID                                                    RAW(16)
--  COLLECTION_TIMESTAMP                                  NOT NULL DATE
--  DATABASE_NAME                                                  VARCHAR2(9)
--  GLOBAL_NAME                                                    VARCHAR2(4000)
--  BANNER                                                         VARCHAR2(80)
--  HOST                                                           VARCHAR2(64)
--  INSTANCE_NAME                                                  VARCHAR2(16)
--  STARTUP_TIME                                                   DATE
--  LOGINS                                                         VARCHAR2(10)
--  LOG_MODE                                                       VARCHAR2(12)
--  OPEN_MODE                                                      VARCHAR2(10)
--  DEFAULT_TEMP_TABLESPACE                                        VARCHAR2(30)
--  CHARACTERSET                                                   VARCHAR2(64)
--  NATIONAL_CHARACTERSET                                          VARCHAR2(64)
--  DV_STATUS_CODE                                                 NUMBER(1)
--  CREATION_DATE                                                  DATE
--  RELEASE                                                        VARCHAR2(64)
--  EDITION                                                        VARCHAR2(64)
--  DBVERSION                                                      VARCHAR2(20)
--  IS_64BIT                                                       VARCHAR2(1)
--  REL_STATUS                                                     VARCHAR2(64)
--  SUPPLEMENTAL_LOG_DATA_MIN                                      VARCHAR2(8)

--MGMT$AVAILABILITY_CURRENT
-- SQL> desc  mgmt$availability_current
--  Name                                      Null?    Type
--  ===========================-------------- -------- ===========================-
--  TARGET_NAME                               NOT NULL VARCHAR2(256)
--  TARGET_TYPE                               NOT NULL VARCHAR2(64)
--  TARGET_GUID                               NOT NULL RAW(16)
--  START_TIMESTAMP                           NOT NULL DATE
--  AVAILABILITY_STATUS                                VARCHAR2(15)
--  AVAILABILITY_STATUS_CODE                  NOT NULL NUMBER
--  TYPE_DISPLAY_NAME                                  VARCHAR2(128)
--
-- SQL> !pwd
-- /opt/oracle/gowrish
--
-- SQL> c/availability_status/target_type
-- SP2-0023: String not found.
-- SQL> /
--
-- AVAILABILITY_ST
-- ---------------
-- Metric Error
-- Target Up
-- Blackout
-- Target Down
-- Pending/Unknown
-- Unreachable
--
-- 6 rows selected.
--
-- SQL> select distinct TARGET_TYPE from mgmt$availability_current;
--
-- TARGET_TYPE
-- ======================================================----------
-- oracle_listener
-- osm_cluster
-- rac_database
-- has
-- weblogic_j2eeserver
-- oracle_apache
-- cluster
-- oracle_oms
-- j2ee_application
-- oracle_oms_console
-- oracle_beacon
--
-- TARGET_TYPE
-- ======================================================----------
-- oracle_emsvrs_sys
-- oracle_dbsys
-- oracle_oms_pbs
-- oracle_em_service
-- oracle_emd
-- oracle_database
-- host
-- osm_instance
-- oracle_emrep
--
-- 20 rows selected.

--MGMT$DB_DBNINSTANCEINFO

*/

spool off

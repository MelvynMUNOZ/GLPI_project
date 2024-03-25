--Ce fichier contient le setup de la base de donnees

ALTER SESSION SET "_ORACLE_SCRIPT"=true;


------------ DROPS --------------

DROP TABLESPACE GLPI INCLUDING CONTENTS AND DATAFILES;

DROP USER GLPI_CERGY CASCADE;
DROP USER GLPI_PAU CASCADE;
DROP USER GLPI CASCADE;

DROP DATABASE LINK db_cergy;
DROP DATABASE LINK db_pau;


-------- TABLESPACE & ADMINS --------------

CREATE TABLESPACE GLPI
DATAFILE 'C:\Oracle\21c\oradata\XE\GLPI.DBF'
SIZE 500M;

-- Global central database
CREATE USER GLPI 
IDENTIFIED BY admin 
DEFAULT TABLESPACE GLPI;

GRANT dba TO GLPI;

-- Cergy Database (admin)
CREATE USER GLPI_CERGY 
IDENTIFIED BY admin_cergy
DEFAULT TABLESPACE GLPI;

GRANT dba TO GLPI_CERGY;

-- Pau Database (admin) 
CREATE USER GLPI_PAU 
IDENTIFIED BY admin_pau
DEFAULT TABLESPACE GLPI;

GRANT dba TO GLPI_PAU;


-------- DATABASES SETUP --------------

-- Setup database Cergy
connect GLPI_CERGY/admin_cergy
@table.sql
@view.sql
@procedure.sql
@sequence.sql
@trigger.sql
@role.sql

-- Setup database Pau
connect GLPI_PAU/admin_pau
@table.sql
@view.sql
@procedure.sql
@sequence.sql
@trigger.sql
@role.sql

-- Setup global central database
connect GLPI/admin
create database link db_cergy connect to GLPI_CERGY identified by admin_cergy using 'XE';
create database link db_pau connect to GLPI_PAU identified by admin_pau using 'XE';
@admin_view.sql --TODO: FIX errors
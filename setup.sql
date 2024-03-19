--Ce fichier contient le setup de la base de donnees

ALTER SESSION SET "_ORACLE_SCRIPT"=true;


------------ DROPS --------------

DROP TABLESPACE GLPI INCLUDING CONTENTS AND DATAFILES;

DROP USER GLPIADMIN CASCADE;


-------- TABLESPACE & ADMIN --------------

CREATE TABLESPACE GLPI 
DATAFILE 'C:\Oracle\21c\oradata\XE\GLPI.DBF' 
SIZE 500M;

CREATE USER GLPIADMIN 
IDENTIFIED BY admin 
DEFAULT TABLESPACE GLPI;

GRANT dba TO GLPIADMIN;

connect GLPIADMIN/admin
@table.sql
@procedure.sql
@sequence.sql
@trigger.sql
@role.sql


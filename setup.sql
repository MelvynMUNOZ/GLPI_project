alter session set "_ORACLE_SCRIPT"=true;

drop tablespace glpi;

create tablespace glpi 
datafile 'C:\Oracle\21c\oradata\XE\glpi.DBF' 
size 500M;

drop user glpiadmin;

create user glpiadmin 
identified by admin 
default tablespace users;

grant dba to glpiadmin;
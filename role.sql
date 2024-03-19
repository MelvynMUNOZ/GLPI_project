alter session set "_ORACLE_SCRIPT"=true; 

-- Suppression des anciens roles (si creation deja realisee)

-- Création des roles pour les differents utilisateurs

-- Role admin
create role role_admin;

-- autorisation du role
grant dba to role_admin;

-------------------------------------

-- Role user
create role role_user;

-- autorisation du role
grant connect to role_user;
grant select, insert on GLPI_TICKET to role_user;

-------------------------------------

-- Role Operator
create role role_operator;

-- autorisation du role
grant connect to role_operator;
grant select, insert on GLPI_TICKET to role_operator;
grant update on VIEW_OPERATOR_GLPI_TICKET to role_operator;
grant select, insert on GLPI_TICKET_TASK to role_operator;
grant select, insert on GLPI_TICKET_SOLUTION to role_operator;

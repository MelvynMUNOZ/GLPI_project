-- Suppression des anciens roles (si creation deja realisee)

-- Création des roles pour les differents utilisateurs

-- Role admin
create role admin;

-- autorisation du role
grant dba to admin;

-------------------------------------

-- Role user
create role user;

-- autorisation du role
grant connect to user;
grant select, insert on GLPI_TICKET to user;

-------------------------------------

-- Role Operator
create role operator;

-- autorisation du role
grant connect to operator;
grant select, insert on GLPI_TICKET to operator;
grant update on VIEW_OPERATOR_GLPI_TICKET to operator;
grant select, insert on GLPI_TICKET_TASK to operator;
grant select, insert on GLPI_TICKET_SOLUTION to operator;

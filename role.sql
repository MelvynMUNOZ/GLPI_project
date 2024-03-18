-- Suppression des anciens roles (si creation deja realisee)



-- Création des roles pour les differents utilisateurs

-- Role admin
CREATE ROLE admin;

-- autorisation du role
GRANT dba TO admin;

-------------------------------------

-- Role user
CREATE ROLE user;

-- autorisation du role
GRANT CONNECT TO user;
GRANT SELECT, INSERT on GLPI_TICKET TO user;

-------------------------------------

-- Role Operator
CREATE ROLE operator;

-- autorisation du role
GRANT CONNECT TO operator;
GRANT SELECT, INSERT ON GLPI_TICKET TO operator;
GRANT update ON VIEW_OPERATOR_GLPI_TICKET TO operator;
GRANT SELECT, INSERT ON GLPI_TICKET_TASK TO operator;
GRANT SELECT, INSERT ON GLPI_TICKET_SOLUTION TO operator;

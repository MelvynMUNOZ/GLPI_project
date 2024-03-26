----- DROPS -----

DROP VIEW view_admin_glpi_ticket;
DROP VIEW view_admin_glpi_user;


----- VIEWS -----

-- Vue global sur les tickets
CREATE VIEW view_admin_glpi_ticket
    AS
    SELECT * FROM view_glpi_ticket@db_cergy
        UNION
    SELECT * FROM view_glpi_ticket@db_pau;

-- Vue global sur les users
CREATE VIEW view_admin_glpi_user
    AS
    SELECT * FROM glpi_user@db_cergy
        UNION
    SELECT * FROM glpi_user@db_pau;
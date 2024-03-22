
CREATE MATERIALIZED VIEW view_admin_glpi AS
    SELECT * FROM view_glpi_ticket@db_pau
        UNION
    SELECT * FROM view_glpi_ticket@db_cergy;

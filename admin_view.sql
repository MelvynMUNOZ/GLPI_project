CREATE MATERIALIZED VIEW LOG ON view_admin_glpi@db_pau;
CREATE MATERIALIZED VIEW LOG ON view_admin_glpi@db_cergy;


CREATE MATERIALIZED VIEW view_admin_glpi
    REFRESH FAST ON COMMIT
    AS
    SELECT * FROM view_glpi_ticket@db_pau
        UNION
    SELECT * FROM view_glpi_ticket@db_cergy;

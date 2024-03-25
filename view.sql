-------------- DROPS --------------

DROP VIEW view_glpi_ticket;


-------------- VIEWS --------------

CREATE VIEW view_glpi_ticket AS
    SELECT id, type, category, priority, status,
           owner_id, operator_id, title, description,
           date_created, date_updated, date_closed
    FROM GLPI_TICKET;
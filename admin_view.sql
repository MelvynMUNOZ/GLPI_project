
CREATE MATERIALIZED VIEW view_admin_glpi_ticket AS
    SELECT id, type, category, priority, status,
           owner_id, operator_id, title, description,
           date_created, date_updated, date_closed
    FROM glpi_ticket_task@db_pau
        UNION
    SELECT id, type, category, priority, status,
           owner_id, operator_id, title, description,
           date_created, date_updated, date_closed
    FROM glpi_ticket_task@db_cergy;
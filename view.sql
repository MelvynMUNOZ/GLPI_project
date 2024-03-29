-------------- DROPS --------------

DROP VIEW view_glpi_ticket;
DROP VIEW view_glpi_ticket_waiting;
DROP VIEW view_glpi_ticket_attributed;
DROP VIEW view_glpi_ticket_resolved;
DROP VIEW view_glpi_ticket_closed;
DROP VIEW view_glpi_ticket_deleted;
DROP VIEW view_glpi_ticket_active;


-------------- VIEWS --------------

CREATE VIEW view_glpi_ticket AS
    SELECT id, type, category, priority, status,
           owner_id, operator_id, title, description,
           date_created, date_updated, date_closed
    FROM GLPI_TICKET;


CREATE VIEW view_glpi_ticket_waiting AS
    SELECT id, type, category, priority, status,
           owner_id, operator_id, title, description,
           date_created, date_updated, date_closed
    FROM GLPI_TICKET WHERE status = 'Waiting';


CREATE VIEW view_glpi_ticket_attributed AS
    SELECT id, type, category, priority, status,
           owner_id, operator_id, title, description,
           date_created, date_updated, date_closed
    FROM GLPI_TICKET WHERE status = 'Attributed';


CREATE VIEW view_glpi_ticket_resolved AS
    SELECT id, type, category, priority, status,
           owner_id, operator_id, title, description,
           date_created, date_updated, date_closed
    FROM GLPI_TICKET WHERE status = 'Resolved';


CREATE VIEW view_glpi_ticket_closed AS
    SELECT id, type, category, priority, status,
           owner_id, operator_id, title, description,
           date_created, date_updated, date_closed
    FROM GLPI_TICKET WHERE status = 'Closed';


CREATE VIEW view_glpi_ticket_deleted AS
    SELECT id, type, category, priority, status,
           owner_id, operator_id, title, description,
           date_created, date_updated, date_closed
    FROM GLPI_TICKET WHERE status = 'Deleted';

CREATE VIEW view_glpi_ticket_active AS
   SELECT id, type, category, priority, status,
           owner_id, operator_id, title, description,
           date_created, date_updated, date_closed
    FROM GLPI_TICKET WHERE status <> 'Deleted';
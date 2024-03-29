----- DROPS -----

DROP VIEW view_admin_glpi_ticket;
DROP VIEW view_admin_glpi_ticket_waiting;
DROP VIEW view_admin_glpi_ticket_attributed;
DROP VIEW view_admin_glpi_ticket_resolved;
DROP VIEW view_admin_glpi_ticket_closed;
DROP VIEW view_admin_glpi_ticket_deleted;
DROP VIEW view_admin_glpi_ticket_active;
DROP VIEW view_admin_glpi_user;
DROP VIEW view_admin_glpi_software_inventories;
DROP VIEW view_admin_glpi_hardware_inventories;
DROP VIEW view_admin_glpi_ticket_clean;


----- VIEWS -----

-- Vue global sur les tickets
CREATE VIEW view_admin_glpi_ticket
    AS
    SELECT * FROM view_glpi_ticket@db_cergy
        UNION
    SELECT * FROM view_glpi_ticket@db_pau;

-- Vue global sur les tickets par status

CREATE VIEW view_admin_glpi_ticket_waiting
    AS
    SELECT * FROM view_glpi_ticket_waiting@db_cergy
        UNION
    SELECT * FROM view_glpi_ticket_waiting@db_pau;

CREATE VIEW view_admin_glpi_ticket_attributed
    AS
    SELECT * FROM view_glpi_ticket_attributed@db_cergy
        UNION
    SELECT * FROM view_glpi_ticket_attributed@db_pau;

CREATE VIEW view_admin_glpi_ticket_resolved
    AS
    SELECT * FROM view_glpi_ticket_resolved@db_cergy
        UNION
    SELECT * FROM view_glpi_ticket_resolved@db_pau;

CREATE VIEW view_admin_glpi_ticket_closed
    AS
    SELECT * FROM view_glpi_ticket_closed@db_cergy
        UNION
    SELECT * FROM view_glpi_ticket_closed@db_pau;

CREATE VIEW view_admin_glpi_ticket_deleted
    AS
    SELECT * FROM view_glpi_ticket_deleted@db_cergy
        UNION
    SELECT * FROM view_glpi_ticket_deleted@db_pau;

CREATE VIEW view_admin_glpi_ticket_active
    AS
    SELECT * FROM view_glpi_ticket_active@db_cergy
        UNION
    SELECT * FROM view_glpi_ticket_active@db_pau;

-- Vue global sur les users
CREATE VIEW view_admin_glpi_user
    AS
    SELECT * FROM glpi_user@db_cergy
        UNION
    SELECT * FROM glpi_user@db_pau;


-- vue sur inventaire software

CREATE VIEW view_admin_glpi_software_inventories
    AS
    select glpi_user.NAME, glpi_inventory.ID,glpi_inventory.REFERENCE 
    from glpi_user@db_cergy, glpi_inventory@db_cergy 
    where glpi_inventory.CATEGORY='Software' 
    and glpi_user.ID=glpi_inventory.OWNER_ID 
    and glpi_user.ROLE='User'
        UNION
    select glpi_user.NAME, glpi_inventory.ID,glpi_inventory.REFERENCE 
    from glpi_user@db_pau, glpi_inventory@db_pau 
    where glpi_inventory.CATEGORY='Software' 
    and glpi_user.ID=glpi_inventory.OWNER_ID 
    and glpi_user.ROLE='User';


--vue sur inventaire hardware

CREATE VIEW view_admin_glpi_hardware_inventories
    AS
    select glpi_user.NAME, glpi_inventory.ID,glpi_inventory.REFERENCE 
    from glpi_user@db_cergy, glpi_inventory@db_cergy 
    where glpi_inventory.CATEGORY='Hardware' 
    and glpi_user.ID=glpi_inventory.OWNER_ID 
    and glpi_user.ROLE='User'
        UNION
    select glpi_user.NAME, glpi_inventory.ID,glpi_inventory.REFERENCE 
    from glpi_user@db_pau, glpi_inventory@db_pau 
    where glpi_inventory.CATEGORY='Hardware' 
    and glpi_user.ID=glpi_inventory.OWNER_ID 
    and glpi_user.ROLE='User';


-- vue sur tickets plus propre

CREATE VIEW view_admin_glpi_ticket_clean
    AS
    SELECT title,description,category FROM view_glpi_ticket@db_cergy
        UNION
    SELECT title,description,category FROM view_glpi_ticket@db_pau;
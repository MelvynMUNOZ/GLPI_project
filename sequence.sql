----------- DROPS -----------

DROP SEQUENCE seq_glpi_user_id;
DROP SEQUENCE seq_glpi_ticket_id;
DROP SEQUENCE seq_glpi_ticket_task_id;
DROP SEQUENCE seq_glpi_ticket_solution_id;
DROP SEQUENCE seq_glpi_notification_id;
DROP SEQUENCE seq_glpi_inventory_item_id;


----------- SEQUENCES -----------

-- Sequences for primary key of tables

CREATE SEQUENCE seq_glpi_user_id
INCREMENT BY 1
START WITH 1
NOCACHE
NOCYCLE;

CREATE SEQUENCE seq_glpi_ticket_id
INCREMENT BY 1
START WITH 1
NOCACHE
NOCYCLE;

CREATE SEQUENCE seq_glpi_ticket_task_id
INCREMENT BY 1
START WITH 1
NOCACHE
NOCYCLE;

CREATE SEQUENCE seq_glpi_ticket_solution_id
INCREMENT BY 1
START WITH 1
NOCACHE
NOCYCLE;

CREATE SEQUENCE seq_glpi_notification_id
INCREMENT BY 1
START WITH 1
NOCACHE
NOCYCLE;

CREATE SEQUENCE seq_glpi_inventory_item_id
INCREMENT BY 1
START WITH 1
NOCACHE
NOCYCLE;

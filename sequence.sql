----------- DROPS -----------

DROP SEQUENCE seq_glpi_user_id;
DROP SEQUENCE seq_glpi_ticket_id;
DROP SEQUENCE seq_glpi_ticket_task_id;
DROP SEQUENCE seq_glpi_ticket_solution_id;
DROP SEQUENCE seq_glpi_notifcation_id;
DROP SEQUENCE seq_glpi_journal_id;
DROP SEQUENCE seq_glpi_inventory_id;


----------- SEQUENCES -----------

CREATE SEQUENCE seq_glpi_ticket_id
INCREMENT BY 1
START WITH 1
NOCACHE
NOCYCLE;

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

CREATE SEQUENCE seq_glpi_notifcation_id
INCREMENT BY 1
START WITH 1
NOCACHE
NOCYCLE;

CREATE SEQUENCE seq_glpi_journal_id
INCREMENT BY 1
START WITH 1
NOCACHE
NOCYCLE;

CREATE SEQUENCE seq_glpi_inventory_id
INCREMENT BY 1
START WITH 1
NOCACHE
NOCYCLE;

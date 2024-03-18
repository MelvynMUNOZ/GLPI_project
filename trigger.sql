--Ce fichier contient les triggers stockées pour la gestion des tickets

--------- TRIGGERS -------------

--Trigger pour affecter un id valide aux lignes de la table GLPI_USER
CREATE OR REPLACE TRIGGER trig_user_set_id
BEFORE INSERT ON GLPI_USER
FOR EACH ROW
BEGIN
    :NEW.ID := 'u' || seq_glpi_user_id.NEXTVAL;
END;
/

--Trigger pour affecter un id valide aux lignes de la table GLPI_TICKET
CREATE OR REPLACE TRIGGER trig_ticket_set_id
BEFORE INSERT ON GLPI_TICKET
FOR EACH ROW
BEGIN
    :NEW.ID := 't' || seq_glpi_ticket_id.NEXTVAL;
END;
/

--Trigger pour affecter un id valide aux lignes de la table GLPI_TICKET_TASK
CREATE OR REPLACE TRIGGER trig_ticket_task_set_id
BEFORE INSERT ON GLPI_TICKET_TASK
FOR EACH ROW
BEGIN
    :NEW.ID := 'tt' || seq_glpi_ticket_task_id.NEXTVAL;
END;
/

--Trigger pour affecter un id valide aux lignes de la table GLPI_TICKET_SOLUTION
CREATE OR REPLACE TRIGGER trig_ticket_solution_set_id
BEFORE INSERT ON GLPI_TICKET_SOLUTION
FOR EACH ROW
BEGIN
    :NEW.ID := 'ts' || seq_glpi_ticket_solution_id.NEXTVAL;
END;
/

--Trigger pour affecter un id valide aux lignes de la table GLPI_NOTIFICATION
CREATE OR REPLACE TRIGGER trig_notification_set_id
BEFORE INSERT ON GLPI_NOTIFICATION
FOR EACH ROW
BEGIN
    :NEW.ID := 'n' || seq_glpi_notification_id.NEXTVAL;
END;
/

--Trigger pour affecter un id valide aux lignes de la table GLPI_JOURNAL
CREATE OR REPLACE TRIGGER trig_journal_set_id
BEFORE INSERT ON GLPI_JOURNAL
FOR EACH ROW
BEGIN
    :NEW.ID := 'j' || seq_glpi_journal_id.NEXTVAL;
END;
/

--Trigger pour affecter un id valide aux lignes de la table GLPI_INVENTORY
CREATE OR REPLACE TRIGGER trig_inventory_set_id
BEFORE INSERT ON GLPI_INVENTORY
FOR EACH ROW
BEGIN
    :NEW.ID := 'i' || seq_glpi_inventory_id.NEXTVAL;
END;
/


--Trigger pour l'envoie de notification lors du changement de statut
CREATE OR REPLACE TRIGGER trig_notify_ticket_status_changed
AFTER UPDATE OF STATUS ON GLPI_TICKET
FOR EACH ROW
BEGIN
    IF :NEW.STATUS <> :OLD.STATUS THEN -- Si le statut a changé
        -- Appelle la procédure fn_notify_ticket_status_changed avec l'ID de l'utilisateur
        fn_notify_ticket_status_changed(:NEW.OWNER_ID, :NEW.OPERATOR_ID,:NEW.ID, :OLD.STATUS, :NEW.STATUS);
    END IF;
END;
/

--Trigger pour la gestion des priorités
CREATE OR REPLACE TRIGGER trig_ticket_set_priority
BEFORE INSERT OR UPDATE OF IMPACT, URGENCY ON GLPI_TICKET
FOR EACH ROW
DECLARE
    v_calculated_priority VARCHAR2(10); -- Variable pour stocker la priorité calculée
BEGIN
    fn_get_ticket_priority(:NEW.IMPACT, :NEW.URGENCY, v_calculated_priority); -- Appelle la procédure fn_get_ticket_priority pour calculer la priorité
    :NEW.PRIORITY := v_calculated_priority; -- Affecte la priorité calculée à la priorité du ticket
END;
/

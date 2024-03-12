
---------Trigger-------------
CREATE OR REPLACE TRIGGER trig_notify_ticket_status_changed
AFTER UPDATE OF STATUS ON GLPI_TICKET
FOR EACH ROW
BEGIN
     IF :NEW.STATUS <> :OLD.STATUS THEN -- Si le statut a changé
        -- Appelle la procédure fn_notify_ticket_status_changed avec l'ID de l'utilisateur
        fn_notify_ticket_status_changed(:NEW.OWNER_ID, :NEW.ID, :OLD.STATUS, :NEW.STATUS);
    END IF;
END;
/

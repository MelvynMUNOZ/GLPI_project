
---------Trigger-------------
CREATE OR REPLACE TRIGGER trig_notify_ticket_status_changed
AFTER UPDATE OF STATUS ON GLPI_TICKET
FOR EACH ROW
BEGIN
    -- Appelle la procédure fn_notify_ticket_status_changed avec l'ID de l'utilisateur
    fn_notify_ticket_status_changed(:NEW.OPERATOR_ID, :NEW.ID, :OLD.STATUS, :NEW.STATUS);
END;
/

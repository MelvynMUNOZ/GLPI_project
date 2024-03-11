CREATE OR REPLACE TRIGGER trig_notify_ticket_status_changed
AFTER UPDATE OF STATUS ON GLPI_TICKET
FOR EACH ROW
WHEN (OLD.STATUS != NEW.STATUS) -- Vérifier si le statut a changé
BEGIN
    -- Passer :OLD.STATUS et :NEW.STATUS pour vérifier et notifier le changement de statut
    fn_notify_ticket_status_changed(:NEW.ID, :OLD.STATUS, :NEW.STATUS);
END;
/

--Ce fichier contient les triggers stockées pour la gestion des tickets
---------Trigger-------------
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

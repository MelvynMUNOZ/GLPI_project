-- Ce fichier répertorie les procédures stockées qui seront utilisées dans le projet
-------------- Procédure --------------

-- Procédure pour notifier un utilisateur lorsqu'un ticket change de statut
CREATE OR REPLACE PROCEDURE fn_notify_ticket_status_changed (
    p_user_id NUMBER,
    p_ticket_id NUMBER,
    p_old_status VARCHAR2,
    p_new_status VARCHAR2
) AS
BEGIN
    INSERT INTO NOTIFICATIONS (USER_ID, TICKET_ID, MESSAGE, STATUS, DATE_CREATED)
    VALUES (p_user_id, p_ticket_id, 'Statut changé de ' || p_old_status || ' à ' || p_new_status, p_new_status, SYSDATE);
END;
/


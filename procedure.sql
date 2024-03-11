-- Ce fichier répertorie les procédures stockées qui seront utilisées dans le projet
-------------- Procédure --------------

CREATE OR REPLACE PROCEDURE fn_notify_ticket_status_changed(
    ticket_id IN NUMBER,
    old_status IN VARCHAR2,
    new_status IN VARCHAR2
)
AS
    creator_id NUMBER;
BEGIN
    -- Vérifier si le statut du ticket a réellement changé
    IF old_status != new_status THEN
        -- Trouver l'ID de l'utilisateur qui a créé le ticket
        SELECT OWNER_ID INTO creator_id
        FROM GLPI_TICKET
        WHERE ID = ticket_id;

        -- Insérer une nouvelle notification dans la table NOTIFICATIONS
        INSERT INTO NOTIFICATIONS(USER_ID, TICKET_ID, MESSAGE, STATUS)
        VALUES (
            creator_id,
            ticket_id,
            'Le statut de votre ticket a changé : ' || old_status || ' -> ' || new_status,
            'Attente'
        );
    END IF;
END;
/
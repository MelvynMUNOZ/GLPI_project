-- Ce fichier répertorie les procédures stockées qui seront utilisées dans le projet

-------------- PROCEDURES --------------

DROP PROCEDURE fn_notify_ticket_status_changed;
DROP PROCEDURE fn_get_ticket_priority;
DROP PROCEDURE close_ticket;
DROP PROCEDURE fn_insert_glpi_user;



-- Procédure pour notifier un utilisateur lorsqu'un ticket change de statut
CREATE OR REPLACE PROCEDURE fn_notify_ticket_status_changed (
    p_user_id VARCHAR2,
    p_operator_id VARCHAR2,
    p_ticket_id VARCHAR2,
    p_old_status VARCHAR2,
    p_new_status VARCHAR2
) AS
BEGIN
    INSERT INTO GLPI_NOTIFICATION (USER_ID, OPERATOR_ID, TICKET_ID, MESSAGE, STATUS, DATE_CREATED)
    VALUES (p_user_id, p_operator_id,p_ticket_id, 'Statut changé de ' || p_old_status || ' à ' || p_new_status, p_new_status, SYSDATE);
END;
/

-- Procédure pour calculer la priorité d'un ticket
CREATE OR REPLACE PROCEDURE fn_get_ticket_priority(
    p_new_impact VARCHAR2,
    p_new_urgency VARCHAR2,
    p_priority OUT VARCHAR2
) IS
    v_impact_num NUMBER;
    v_urgency_num NUMBER;
    v_somme NUMBER;
BEGIN
    CASE p_new_impact
        WHEN 'High' THEN v_impact_num := 3;
        WHEN 'Medium' THEN v_impact_num := 2;
        WHEN 'Low' THEN v_impact_num := 1;
    END CASE;

    CASE p_new_urgency
        WHEN 'High' THEN v_urgency_num := 3;
        WHEN 'Medium' THEN v_urgency_num := 2;
        WHEN 'Low' THEN v_urgency_num := 1;
    END CASE;

    v_somme := v_impact_num + v_urgency_num;

    IF v_somme >= 5 THEN
        p_priority := 'High';
    ELSIF v_somme = 4 THEN
        p_priority := 'Medium';
    ELSE
        p_priority := 'Low';
    END IF;
END;
/

CREATE OR REPLACE PROCEDURE close_ticket(
    p_ticket_id IN VARCHAR2
) AS
    v_approval_status NUMBER;
BEGIN
    -- Vérifier l'état d'approbation du ticket dans GLPI_TICKET_SOLUTION
    SELECT approval
    INTO v_approval_status
    FROM GLPI_TICKET_SOLUTION
    WHERE ID = p_ticket_id;

    -- Si l'approbation n'est pas à 1, lever une exception
    IF v_approval_status != 1 THEN
        RAISE_APPLICATION_ERROR(-20002, 'Le ticket n''est pas approuvé pour fermeture.');
    END IF;

    -- Mise à jour du ticket spécifié pour le marquer comme fermé
    UPDATE GLPI_TICKET
    SET status = 'Closed',
        date_closed = SYSDATE
    WHERE ID = p_ticket_id;

    -- Gérer les erreurs potentielles ou les cas où le ticket n'existe pas ou est déjà fermé
    IF SQL%ROWCOUNT = 0 THEN
        -- Aucune ligne mise à jour, ce qui peut signifier que le ticket n'existe pas ou est déjà fermé
        RAISE_APPLICATION_ERROR(-20001, 'Le ticket spécifié ne peut être fermé ou n''existe pas.');
    END IF;

    -- Valider la transaction
    COMMIT;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20003, 'Le ticket spécifié n''existe pas dans GLPI_TICKET_SOLUTION ou n''est pas approuvé.');
    WHEN OTHERS THEN
        -- En cas d'erreur, annuler les modifications
        ROLLBACK;
        -- Relancer l'erreur
        RAISE;
END close_ticket;
/

-- Procédure d'insertion dans la table GLPI_USER
CREATE OR REPLACE PROCEDURE fn_insert_glpi_user (
    p_name  IN  VARCHAR2,
    p_email IN  VARCHAR2
)
AS
BEGIN
    -- Insérer les données
    INSERT INTO GLPI_USER (NAME, EMAIL)
    VALUES (p_name, p_email);
    
    COMMIT;

EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20001, 'Erreur lors de l''insertion : Cet utilisateur existe déjà');
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20002, 'Erreur lors de l''insertion : ' || SQLERRM);
    
END fn_insert_glpi_user;
/



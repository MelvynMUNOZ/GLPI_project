-- Ce fichier répertorie les procédures stockées qui seront utilisées dans le projet

-------------- PROCEDURES --------------

DROP PROCEDURE fn_notify_ticket_status_changed;
DROP PROCEDURE fn_get_ticket_priority;
DROP PROCEDURE close_ticket;
DROP PROCEDURE fn_insert_glpi_user;
DROP PROCEDURE fn_attribute_ticket;



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

CREATE OR REPLACE PROCEDURE fn_close_ticket(
    p_ticket_id IN VARCHAR2,
    p_solution_id IN VARCHAR2
) AS
    v_approval_status NUMBER;
BEGIN
    -- Vérifier l'état d'approbation du ticket dans GLPI_TICKET_SOLUTION
    SELECT approval
    INTO v_approval_status
    FROM GLPI_TICKET_SOLUTION
    WHERE ID_TICKET = p_ticket_id;

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
END fn_close_ticket;
/

-- Procédure d'insertion dans la table GLPI_USER
CREATE OR REPLACE PROCEDURE fn_insert_glpi_user (
    p_name  IN  VARCHAR2,
    p_email IN  VARCHAR2,
    p_role  IN  VARCHAR2
) AS
BEGIN
    -- Insérer les données
    INSERT INTO GLPI_USER (NAME, EMAIL, ROLE)
    VALUES (p_name, p_email, p_role);
    
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

CREATE OR REPLACE PROCEDURE fn_attribute_ticket (
    p_ticket_id IN VARCHAR2,
    p_operator_id IN VARCHAR2
)
AS
BEGIN
    -- Insérer les données
    UPDATE GLPI_TICKET
    SET status = 'Attributed',
        OPERATOR_ID = p_operator_id
    WHERE ID = p_ticket_id;

COMMIT ;
END fn_attribute_ticket;
/



CREATE OR REPLACE PROCEDURE fn_insert_glpi_ticket (
    p_type         IN VARCHAR2,
    p_category     IN VARCHAR2,
    p_impact       IN VARCHAR2,
    p_urgency      IN VARCHAR2,
    p_priority     IN VARCHAR2,
    p_title        IN VARCHAR2,
    p_description  IN VARCHAR2,
    p_owner_id     IN VARCHAR2,
    p_inventory_item_id IN VARCHAR2
)
AS
BEGIN
    INSERT INTO GLPI_TICKET (
        TYPE,
        CATEGORY,
        IMPACT,
        STATUS,
        URGENCY,
        PRIORITY,
        TITLE,
        DESCRIPTION,
        OWNER_ID,
        INVENTORY_ITEM_ID
    ) VALUES (
        p_type,
        p_category,
        p_impact,
        'Waiting',
        p_urgency,
        p_priority,
        p_title,
        p_description,
        p_owner_id,
        p_inventory_item_id
    );
    
    COMMIT;
    
    DBMS_OUTPUT.PUT_LINE('Data inserted successfully.');
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20001, 'Error inserting data: ' || SQLERRM);
END fn_insert_glpi_ticket;
/



CREATE OR REPLACE PROCEDURE fn_insert_glpi_inventory (
    p_category  IN VARCHAR2,
    p_reference IN VARCHAR2,
    p_owner_id  IN VARCHAR2
)
AS
BEGIN
    INSERT INTO GLPI_INVENTORY ( CATEGORY, REFERENCE, OWNER_ID)
    VALUES ( p_category, p_reference, p_owner_id);
    
    COMMIT;
    
    DBMS_OUTPUT.PUT_LINE('Data inserted successfully.');
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20001, 'Error inserting data: ' || SQLERRM);
END fn_insert_glpi_inventory;
/

CREATE OR REPLACE PROCEDURE fn_resolved_ticket (
    p_ticket_id IN VARCHAR2
)AS
  solution_count NUMBER;
BEGIN
  -- Compter le nombre de solutions pour l'ID de ticket donné.
  SELECT COUNT(*)
  INTO solution_count
  FROM GLPI_TICKET_SOLUTION
  WHERE ID_TICKET = p_ticket_id;

  -- Vérifier s'il existe au moins une solution pour ce ticket.
  IF solution_count > 0 THEN
    -- Mise à jour de l'état du ticket à 'Resolved'.
    UPDATE GLPI_TICKET
    SET STATUS = 'Resolved'
    WHERE ID = p_ticket_id;
  ELSE
    -- Lever une exception si aucune solution n'est trouvée pour ce ticket.
    RAISE_APPLICATION_ERROR(-20004, 'Aucune solution trouvée pour ce ticket, impossible de le résoudre.');
  END IF;

  -- Appliquer les modifications.
  COMMIT;
END fn_resolved_ticket;
/

CREATE OR REPLACE PROCEDURE fn_approve_ticket (
    p_ticket_id IN VARCHAR2,
    p_solution_id IN VARCHAR2
)AS
    ticket_status VARCHAR2(16);
BEGIN
    -- Récupérer le statut actuel du ticket.
    SELECT STATUS
    INTO ticket_status
    FROM GLPI_TICKET
    WHERE ID = p_ticket_id;

    -- Vérifier si le ticket est actuellement en attente d'approbation.
    IF ticket_status = 'Resolved' THEN
        -- Approuver la solution.
        UPDATE GLPI_TICKET_SOLUTION
        SET APPROVAL = 1
        WHERE ID = p_solution_id;
        fn_close_ticket(p_ticket_id, p_solution_id);
    ELSE
        -- Lever une exception si le ticket n'est pas en attente d'approbation.
        RAISE_APPLICATION_ERROR(-20007, 'Le ticket n''est pas en attente d''approbation.');
    END IF;

    -- Appliquer les modifications.
    COMMIT;
END fn_approve_ticket;
/

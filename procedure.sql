-- Ce fichier répertorie les procédures stockées qui seront utilisées dans le projet

-------------- PROCEDURES --------------

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

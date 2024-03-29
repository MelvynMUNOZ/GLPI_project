-- USERS --

exec fn_insert_glpi_user( 'Olivia Garcia', 'olivia.garcia@example.com','User' );
exec fn_insert_glpi_user( 'William Martinez', 'william.martinez@example.com','User');
exec fn_insert_glpi_user( 'Sophia Taylor', 'sophia.taylor@example.com' ,'User');
exec fn_insert_glpi_user( 'Alexander Brown', 'alexander.brown@example.com','User');
exec fn_insert_glpi_user( 'Charlotte Davis', 'charlotte.davis@example.com','User');
exec fn_insert_glpi_user( 'Ethan Johnson', 'ethan.johnson@example.com','Operator');
exec fn_insert_glpi_user( 'Ava Wilson', 'ava.wilson@example.com','Operator' );

-- INVENTORY --

exec fn_insert_glpi_inventory('Software','RStudio','u1');
exec fn_insert_glpi_inventory('Software','Photoshop','u1');
exec fn_insert_glpi_inventory('Software','Illustrator','u1');
exec fn_insert_glpi_inventory('Software','VsCode','u2');
exec fn_insert_glpi_inventory('Software','Eclipse','u3');
exec fn_insert_glpi_inventory('Software','IntelliJ','u3');
exec fn_insert_glpi_inventory('Software','PyCharm','u3');
exec fn_insert_glpi_inventory('Hardware','Clavier','u3');
exec fn_insert_glpi_inventory('Hardware','Souris','u3');
exec fn_insert_glpi_inventory('Hardware','Ecran','u4');
exec fn_insert_glpi_inventory('Hardware','Ordinateur','u4');
exec fn_insert_glpi_inventory('Software','Microsoft Suite','u4');
exec fn_insert_glpi_inventory('Software','Adobe Suite','u5');
exec fn_insert_glpi_inventory('Hardware','Ordinateur','u5');
exec fn_insert_glpi_inventory('Hardware','Ecran','u5');

-- TICKETS --

exec fn_insert_glpi_ticket ('Incident','Software','Low','Low','Low','RStudio non fonctionnel','RStudio ne se lance pas et emet une erreur 42','u1','i1');
exec fn_insert_glpi_ticket ('Incident','Software','Low','Low','Low','Photoshop non fonctionnel','Photoshop ne sauvegarde pas les fichiers','u1','i2');
exec fn_insert_glpi_ticket ('Incident','Hardware','Low','Low','High','Clavier non fonctionnel','La touche fleche droite ne marche pas','u3','i8');

-- TICKETS OPERATIONS --

exec fn_attribute_ticket ('t1','u6');
exec fn_attribute_ticket ('t2','u6');

-- TICKETS TASK --

exec fn_insert_glpi_task('t1','Réinstallation de RStudio');
exec fn_insert_glpi_task('t1','Mise à jour de RStudio');

-- TICKETS SOLUTION --

exec fn_insert_glpi_solution('t1','Mise à jour de RStudio, le logiciel fonctionne');
exec fn_insert_glpi_solution('t1','Supprimer le logiciel RStudio');

-- TICKETS CHANGE --

exec fn_resolve_ticket('t1');


-- TICKETS APPROVAL --

exec fn_approve_ticket('t1','ts1');








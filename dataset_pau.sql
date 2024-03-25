-- USERS --

exec fn_insert_glpi_user('John Doe', 'john.doe@example.com', 'Cergy','User');
exec fn_insert_glpi_user('Jane Smith', 'jane.smith@example.com','User');
exec fn_insert_glpi_user('Alice Smith', 'alice.smith@example.com','User' );
exec fn_insert_glpi_user('Sarah Johnson', 'sarah.johnson@example.com','User');
exec fn_insert_glpi_user('Michael Brown', 'michael.brown@example.com' ,'User');
exec fn_insert_glpi_user('Emily Wilson', 'emily.wilson@example.com','Operator');
exec fn_insert_glpi_user('David Martinez', 'david.martinez@example.com','Operator' );

-- INVENTORY --

exec fn_insert_glpi_inventory('Software','DataGrip','u1');
exec fn_insert_glpi_inventory('Software','Word','u1');
exec fn_insert_glpi_inventory('Software','Bloc note','u1');
exec fn_insert_glpi_inventory('Software','Steam','u3');
exec fn_insert_glpi_inventory('Hardware','Clavier','u3');
exec fn_insert_glpi_inventory('Hardware','Souris','u3');
exec fn_insert_glpi_inventory('Hardware','Ecran','u4');
exec fn_insert_glpi_inventory('Hardware','Ordinateur','u4');
exec fn_insert_glpi_inventory('Software','Bananasplit','u4');
exec fn_insert_glpi_inventory('Software','Adobe Suite','u5');
exec fn_insert_glpi_inventory('Hardware','Ordinateur','u5');
exec fn_insert_glpi_inventory('Hardware','Ecran','u5');

-- TICKETS --

exec fn_insert_glpi_ticket ('Incident','Software','Low','Low','Low','DataGrip non fonctionnel','DataGrip ne se lance pas et emet une erreur 42','u1','i1');
exec fn_insert_glpi_ticket ('Incident','Software','Low','Low','Low','Word non fonctionnel','Word ne sauvegarde pas les fichiers','u1','i2');
exec fn_insert_glpi_ticket ('Incident','Hardware','Low','Low','High','Clavier non fonctionnel','La touche fleche droite ne marche pas','u3','i8');

-- TICKETS OPERATIONS --

exec fn_attribute_ticket ('t1','u6');





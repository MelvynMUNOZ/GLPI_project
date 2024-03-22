-- USERS --

exec fn_insert_glpi_user('John Doe', 'john.doe@example.com', 'Cergy');
exec fn_insert_glpi_user('Jane Smith', 'jane.smith@example.com');
exec fn_insert_glpi_user('Alice Smith', 'alice.smith@example.com' );
exec fn_insert_glpi_user('Sarah Johnson', 'sarah.johnson@example.com');
exec fn_insert_glpi_user('Michael Brown', 'michael.brown@example.com' );
exec fn_insert_glpi_user('Emily Wilson', 'emily.wilson@example.com');
exec fn_insert_glpi_user('David Martinez', 'david.martinez@example.com' );
exec fn_insert_glpi_user('Jennifer Taylor', 'jennifer.taylor@example.com');
exec fn_insert_glpi_user('Daniel Garcia', 'daniel.garcia@example.com' );
exec fn_insert_glpi_user( 'Jessica Davis', 'jessica.davis@example.com');
exec fn_insert_glpi_user( 'Emma Thompson', 'emma.thompson@example.com');
exec fn_insert_glpi_user( 'James Wilson', 'james.wilson@example.com');
exec fn_insert_glpi_user( 'Olivia Garcia', 'olivia.garcia@example.com' );
exec fn_insert_glpi_user( 'William Martinez', 'william.martinez@example.com');
exec fn_insert_glpi_user( 'Sophia Taylor', 'sophia.taylor@example.com' );
exec fn_insert_glpi_user( 'Alexander Brown', 'alexander.brown@example.com');
exec fn_insert_glpi_user( 'Charlotte Davis', 'charlotte.davis@example.com');
exec fn_insert_glpi_user( 'Ethan Johnson', 'ethan.johnson@example.com');
exec fn_insert_glpi_user( 'Ava Wilson', 'ava.wilson@example.com' );
exec fn_insert_glpi_user( 'Logan Garcia', 'logan.garcia@example.com');
exec fn_insert_glpi_user( 'Mia Martinez', 'mia.martinez@example.com' );
exec fn_insert_glpi_user( 'Benjamin Thompson', 'benjamin.thompson@example.com');
exec fn_insert_glpi_user( 'Harper Wilson', 'harper.wilson@example.com' );
exec fn_insert_glpi_user( 'Evelyn Garcia', 'evelyn.garcia@example.com');
exec fn_insert_glpi_user( 'Sebastian Taylor', 'sebastian.taylor@example.com' );
exec fn_insert_glpi_user( 'Camila Brown', 'camila.brown@example.com');
exec fn_insert_glpi_user( 'Liam Davis', 'liam.davis@example.com' );
exec fn_insert_glpi_user( 'Zoe Johnson', 'zoe.johnson@example.com');
exec fn_insert_glpi_user( 'Elijah Wilson', 'elijah.wilson@example.com');
exec fn_insert_glpi_user( 'Nora Garcia', 'nora.garcia@example.com');

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


exec fn_insert_glpi_ticket ('Incident','Software','Low','Low','Low','RStudio non fonctionnel','RStudio ne se lance pas et emet une erreur 42','u1','i1');
exec fn_insert_glpi_ticket ('Incident','Software','Low','Low','Low','Photoshop non fonctionnel','Photoshop ne sauvegarde pas les fichiers','u1','i2');
exec fn_insert_glpi_ticket ('Incident','Hardware','Low','Low','High','Clavier non fonctionnel','La touche fleche droite ne marche pas','u3','i8');

exec fn_attribute_ticket ('t1','u6');





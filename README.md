# GLPI_project
Projet BDD : gestion ticket

## Prerecquis

Oracle Database XE 21c

## Execution

Lancer `sqlplus` dans le repertoire des scripts sql.

Se connecter avec `system`. Executer le script `setup.sql` :

```sql
@setup.sql
```

Utiliser la database Cergy. Se connecter avec `GLPI_CERGY` :

```sql
connect GLPI_CERGY/admin_cergy;
```

Utiliser la database Pau. Se connecter avec `GLPI_PAU` :

```sql
connect GLPI_PAU/admin_pau;
```
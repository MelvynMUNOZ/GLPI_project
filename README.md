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

Pour utiliser la database Cergy : se connecter avec `GLPI_CERGY` :

```sql
connect GLPI_CERGY/admin_cergy
```

Pour utiliser la database Pau : se connecter avec `GLPI_PAU` :

```sql
connect GLPI_PAU/admin_pau
```

## Auteurs
Raphael CAUSSE
Lucas COTOT
Thomas GONS
Melvyn MUNOZ
Mathéo PEREIRA
# Créer et administrer une base de donner avec PostgreSQl 14.0.

- Modélisation de la base de données sous forme de MCD & MLD avec la méthode Merise.
- Ecriture des différents scripts SQL de création sécurisée de base de données et de ses tables ainsi que des relations et contraintes entre elles.
- Remplissage des tables avec de fausses données.
- Gestion des rôles et sécurité

### Sauvegardes
`pg_dumpall` est un outil d'extraction (« sauvegarde ») de toutes les bases de données PostgreSQL de l'instance vers un fichier script. Celui-ci contient les commandes SQL utilisables pour restaurer les bases de données avec `psql`.

Créer un répertoire `backups` dans le répertoire `home` de postgres pour y déposer les fichiers d’export.

```
postgres@skynet:~$ cd ~postgres
postgres@skynet:~$ mkdir backups
```

À l’aide de `pg_dumpall`, sauvegarder toutes les bases de données de l’instance PostgreSQL dans le fichier `~postgres/backups/base_all.sql`.
```
postgres@skynet:~$ pg_dumpall > ~postgres/backups/base_all.sql
```

Consulter le contenu du fichier de sauvegarde

```
postgres@skynet:~$ less ~postgres/backups/base_all.sql
```
Le fichier contient en clair des ordres SQL :

- d’abord du paramétrage destiné à la restauration
- la déclaration des rôles avec des mots de passe hachés, et les affectations des groupes
- des ordres de création des bases
- es ordres pour se connecter à chaque base et y déclarer des objets
- les données elles-mêmes, sous formes d’ordres `COPY`
- ainsi que divers ordres comme des contraintes ou des créations d’index

### Restauration
L'outil `psql` permet de restaurer le fichier de script SQL généré par le `pg_dumpall`.

```
postgres@skynet:~$ psql -U postgres -f base_all.sql
```

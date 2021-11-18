
### Installation postgreSQL under linux Ubuntu
(https://www.postgresql.org/download/linux/ubuntu/)

Create the file repository configuration:

```sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'```

Import the repository signing key:

```wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -```

Update the package lists:

```sudo apt-get update```

Install the latest version of PostgreSQL.

```sudo apt-get -y install postgresql```



### Check that the postgresql server is started.

```
sandrine@skynet:~$ service postgresql status  
● postgresql.service - PostgreSQL RDBMS  
     Loaded: loaded (/lib/systemd/system/postgresql.service; enabled; vendor preset: enabled)  
     Active: active (exited) since Wed 2021-11-17 16:18:05 CET; 1min 58s ago  
    Process: 6297 ExecStart=/bin/true (code=exited, status=0/SUCCESS)  
   Main PID: 6297 (code=exited, status=0/SUCCESS)  
  
nov. 17 16:18:05 skynet systemd[1]: Starting PostgreSQL RDBMS...  
nov. 17 16:18:05 skynet systemd[1]: Finished PostgreSQL RDBMS.
```

### Connection with the postgres system user (peer method)

```
sandrine@skynet:~$ sudo -i -u postgres
[sudo] Mot de passe de sandrine : 
postgres@skynet:~$
```

### Interact with psql, the PostgreSQL command line interface.

``` 
postgres@skynet:~$ psql
psql (14.0 (Ubuntu 14.0-1.pgdg20.04+1))
Saisissez « help » pour l'aide.

postgres=# 
```

```
postgres=# help
Vous utilisez psql, l'interface en ligne de commande de PostgreSQL.
Saisissez:
    \copyright pour les termes de distribution
    \h pour l'aide-mémoire des commandes SQL
    \? pour l'aide-mémoire des commandes psql
    \g ou point-virgule en fin d'instruction pour exécuter la requête
    \q pour quitter
postgres=# 
 
```

### Create cinema database

```
postgres=# CREATE DATABASE cinema;
CREATE DATABASE
postgres=#
```

### Create new user

```
postgres=# \h CREATE USER
Commande :    CREATE USER
Description : définir un nouveau rôle
Syntaxe :
CREATE USER nom [ [ WITH ] option [ ... ] ]

où option peut être :

      SUPERUSER | NOSUPERUSER
    | CREATEDB | NOCREATEDB
    | CREATEROLE | NOCREATEROLE
    | INHERIT | NOINHERIT
    | LOGIN | NOLOGIN
    | REPLICATION | NOREPLICATION
    | BYPASSRLS | NOBYPASSRLS
    | CONNECTION LIMIT limite_de_connexion
    | [ ENCRYPTED ] PASSWORD 'mot_de_passe' | PASSWORD NULL
    | VALID UNTIL 'horodatage'
    | IN ROLE nom_rôle [, ...]
    | IN GROUP nom_rôle [, ...]
    | ROLE nom_rôle [, ...]
    | ADMIN nom_rôle [, ...]
    | USER nom_rôle [, ...]
    | SYSID uid

URL: https://www.postgresql.org/docs/14/sql-createuser.html

postgres=# CREATE USER sandrine WITH CREATEDB CREATEROLE ENCRYPTED PASSWORD 'password';
CREATE ROLE
postgres=# \du
                                              Liste des rôles
 Nom du rôle |                                    Attributs                                    | Membre de
-------------+---------------------------------------------------------------------------------+-----------
 postgres    | Superutilisateur, Créer un rôle, Créer une base, Réplication, Contournement RLS | {}
 sandrine    | Créer un rôle, Créer une base                                                   | {}

postgres=# \l
                                  Liste des bases de données
    Nom    | Propriétaire | Encodage | Collationnement | Type caract. |    Droits d'accès
-----------+--------------+----------+-----------------+--------------+-----------------------
 cinema    | postgres     | UTF8     | fr_FR.UTF-8     | fr_FR.UTF-8  |
 postgres  | postgres     | UTF8     | fr_FR.UTF-8     | fr_FR.UTF-8  |
 template0 | postgres     | UTF8     | fr_FR.UTF-8     | fr_FR.UTF-8  | =c/postgres          +
           |              |          |                 |              | postgres=CTc/postgres
 template1 | postgres     | UTF8     | fr_FR.UTF-8     | fr_FR.UTF-8  | =c/postgres          +
           |              |          |                 |              | postgres=CTc/postgres
(4 lignes)
```

### Change the owner of the cinema database

```
postgres=# ALTER DATABASE cinema OWNER TO sandrine;
ALTER DATABASE
postgres=# \l
                                  Liste des bases de données
    Nom    | Propriétaire | Encodage | Collationnement | Type caract. |    Droits d'accès
-----------+--------------+----------+-----------------+--------------+-----------------------
 cinema    | sandrine     | UTF8     | fr_FR.UTF-8     | fr_FR.UTF-8  |
 postgres  | postgres     | UTF8     | fr_FR.UTF-8     | fr_FR.UTF-8  |
 template0 | postgres     | UTF8     | fr_FR.UTF-8     | fr_FR.UTF-8  | =c/postgres          +
           |              |          |                 |              | postgres=CTc/postgres
 template1 | postgres     | UTF8     | fr_FR.UTF-8     | fr_FR.UTF-8  | =c/postgres          +
           |              |          |                 |              | postgres=CTc/postgres
(4 lignes)
```

### Connect with the new user

```
postgres=# \q
postgres@skynet:~$ psql -h 127.0.0.1 -U sandrine
Mot de passe pour l'utilisateur sandrine :
psql: erreur : la connexion au serveur sur « 127.0.0.1 », port 5432 a échoué : FATAL:  la base de données « sandrine » n'existe pas
postgres@skynet:~$ psql -h 127.0.0.1 -U sandrine -d cinema
Mot de passe pour l'utilisateur sandrine :
psql (14.0 (Ubuntu 14.0-1.pgdg20.04+1))
Connexion SSL (protocole : TLSv1.3, chiffrement : TLS_AES_256_GCM_SHA384, bits : 256, compression : désactivé)
Saisissez « help » pour l'aide.

cinema=>
```

### Create tables (exemples)

```
cinema=# CREATE TABLE administrators(
administrator_id INT PRIMARY KEY,
administrator_last_name VARCHAR(255) NOT NULL,
administrator_first_name VARCHAR(255) NOT NULL,
administrator_password VARCHAR(255) NOT NULL);
CREATE TABLE
cinema=# \d administrators
                               Table « public.administrators »
         Colonne          |          Type          | Collationnement | NULL-able | Par défaut
--------------------------+------------------------+-----------------+-----------+------------
 administrator_id         | integer                |                 | not null  |
 administrator_last_name  | character varying(255) |                 | not null  |
 administrator_first_name | character varying(255) |                 | not null  |
 administrator_password   | character varying(255) |                 | not null  |
Index :
    "administrators_pkey" PRIMARY KEY, btree (administrator_id)
```
```
cinema=# CREATE TABLE cinemas_complex(
cinema_complex_id INT PRIMARY KEY,
cinema_complex_name VARCHAR(255) NOT NULL,
CONSTRAINT fk_info
FOREIGN KEY (info_id)
REFERENCES infos(info_id),
CONSTRAINT fk_administrator
FOREIGN KEY (administrator_id)
REFERENCES administrators(administrator_id),
info_id INT NOT NULL,
administrator_id INT NOT NULL);
CREATE TABLE
cinema=# \d cinemas_complex
                            Table « public.cinemas_complex »
       Colonne       |          Type          | Collationnement | NULL-able | Par défaut
---------------------+------------------------+-----------------+-----------+------------
 cinema_complex_id   | integer                |                 | not null  |
 cinema_complex_name | character varying(255) |                 | not null  |
 info_id             | integer                |                 | not null  |
 administrator_id    | integer                |                 | not null  |
Index :
    "cinemas_complex_pkey" PRIMARY KEY, btree (cinema_complex_id)
Contraintes de clés étrangères :
    "fk_administrator" FOREIGN KEY (administrator_id) REFERENCES administrators(administrator_id)
    "fk_info" FOREIGN KEY (info_id) REFERENCES infos(info_id)
```

### Tables list

```
cinema=> \dt
                   Liste des relations
 Schéma |           Nom            | Type  | Propriétaire 
--------+--------------------------+-------+--------------
 public | administrators           | table | sandrine
 public | cinemas_complex          | table | sandrine
 public | customers                | table | sandrine
 public | infos                    | table | sandrine
 public | movies                   | table | sandrine
 public | movies_theaters          | table | sandrine
 public | movies_theaters_sessions | table | sandrine
 public | payments                 | table | sandrine
 public | prices_list              | table | sandrine
 public | sessions                 | table | sandrine
(10 lignes)

```
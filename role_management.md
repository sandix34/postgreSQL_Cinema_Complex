### Check that the postgresql server is started.

``` 
sandrine@skynet:~$ service postgresql status
● postgresql.service - PostgreSQL RDBMS
     Loaded: loaded (/lib/systemd/system/postgresql.service; enabled; vendor preset: enabled)
     Active: active (exited) since Wed 2021-11-24 11:12:30 CET; 30min ago
    Process: 2403 ExecStart=/bin/true (code=exited, status=0/SUCCESS)
   Main PID: 2403 (code=exited, status=0/SUCCESS)

nov. 24 11:12:30 skynet systemd[1]: Starting PostgreSQL RDBMS...
nov. 24 11:12:30 skynet systemd[1]: Finished PostgreSQL RDBMS.
```

### Access to the instance
By default, the instance is only accessible by the `postgres` system user, who does not have a password (
it is possible to add a password to the `postgres` user of the instance). A detour by sudo is necessary:
```
sandrine@skynet:~$ sudo -i -u postgres
[sudo] Mot de passe de sandrine : 
postgres@skynet:~$ psql
psql (14.0 (Ubuntu 14.0-1.pgdg20.04+1))
Saisissez « help » pour l'aide.

postgres=# 
```

### Create a role representing the `cinema_admin` group
```
postgres=# CREATE ROLE cinema_admin;
```
### Create a new user paul

```postgres=# CREATE ROLE paul WITH LOGIN ENCRYPTED PASSWORD 'passwordpaul' IN ROLE cinema_admin;
CREATE ROLE
postgres=# 
```

List users: 

```
postgres=# \du
                                                 Liste des rôles
 Nom du rôle  |                                    Attributs                                    |   Membre de    
--------------+---------------------------------------------------------------------------------+----------------
 cinema_admin | Ne peut pas se connecter                                                        | {}
 jean         |                                                                                 | {cinema_admin}
 louis        |                                                                                 | {cinema_admin}
 paul         |                                                                                 | {cinema_admin}
 pierre       |                                                                                 | {cinema_admin}
 postgres     | Superutilisateur, Créer un rôle, Créer une base, Réplication, Contournement RLS | {}
 sandrine     | Créer un rôle, Créer une base                                                   | {}

postgres=# 
```

### Access authorization for all users of the `cinema_group` group and `sandrine` user to the` cinema` database
Edit the `pg_hba.conf` file.

```
postgres=# \q
postgres@skynet:~$ vim /etc/postgresql/14/main/pg_hba.conf
postgres@skynet:~$
```


```
 DO NOT DISABLE!
# If you change this first entry you will need to make sure that the
# database superuser can access the database using some other method.
# Noninteractive access to all databases is required during automatic
# maintenance (custom daily cronjobs, replication, and similar tasks).
#
# Database administrative login by Unix domain socket
local   all             postgres                                peer

# TYPE  DATABASE        USER            ADDRESS                 METHOD

# "local" is for Unix domain socket connections only
local   all             all                                     peer
# IPv4 local connections:
host    cinema          sandrine, +cinema_admin       127.0.0.1/32            scram-sha-256
# IPv6 local connections:
host    all             all             ::1/128                 scram-sha-256
# Allow replication connections from localhost, by a user with the
# replication privilege.
local   replication     all                                     peer
host    replication     all             127.0.0.1/32            scram-sha-256
host    replication     all             ::1/128                 scram-sha-256
"/etc/postgresql/14/main/pg_hba.conf" 104L, 5016C                               
```

Restart postgresql server

```
postgres@skynet:~$ service postgresql restart
spostgres@skynet:~$ service postgresql status
● postgresql.service - PostgreSQL RDBMS
     Loaded: loaded (/lib/systemd/system/postgresql.service; enabled; vendor preset: enabled)
     Active: active (exited) since Wed 2021-11-24 13:15:48 CET; 17s ago
    Process: 3217 ExecStart=/bin/true (code=exited, status=0/SUCCESS)
   Main PID: 3217 (code=exited, status=0/SUCCESS)
postgres@skynet:~$ 
```

### Connect with `louis` user for example

```
postgres@skynet:~$ psql -h 127.0.0.1 -U louis -d cinema
Mot de passe pour l'utilisateur louis : 
psql (14.0 (Ubuntu 14.0-1.pgdg20.04+1))
Connexion SSL (protocole : TLSv1.3, chiffrement : TLS_AES_256_GCM_SHA384, bits : 256, compression : désactivé)
Saisissez « help » pour l'aide.

cinema=> 
```

### Define the access rights on the tables

```
cinema=> SELECT * FROM movies;
ERREUR:  droit refusé pour la table infos
cinema=> 
```
Give all privileges to the user `sandrine`
```
postgres=# GRANT pg_read_all_data TO sandrine;
GRANT ROLE
postgres=# GRANT pg_write_all_data TO sandrine;
GRANT ROLE
postgres=# \q
postgres@skynet:~$ psql -h 127.0.0.1 -U sandrine -d cinema
Mot de passe pour l'utilisateur sandrine : 
psql (14.0 (Ubuntu 14.0-1.pgdg20.04+1))
Connexion SSL (protocole : TLSv1.3, chiffrement : TLS_AES_256_GCM_SHA384, bits : 256, compression : désactivé)
Saisissez « help » pour l'aide.

cinema=> SELECT * FROM infos;
 info_id |  info_phone  |     info_address      | info_postal_code |    info_city    
---------+--------------+-----------------------+------------------+-----------------
       1 | 932-782-0987 | 019 Victoria Road     |            89129 | Reggio Calabria
       2 | 460-567-4096 | 5 Arizona Way         |             3899 | Zeewolde
       3 | 326-183-3347 | 73 Hooker Avenue      |            89563 | Koysinceq
       4 | 611-261-7537 | 6 Knutson Terrace     |            65412 | Huế
       5 | 796-412-6763 | 41 Hollow Ridge Lane  |            31524 | Kryevidh
       6 | 205-125-3577 | 71323 Steensland Hill |            35244 | Birmingham
       7 | 329-876-4206 | 61771 Hagan Trail     |            85478 | Sungai Iyu
       8 | 646-964-8450 | 20 Southridge Place   |             4521 | Mingshan
       9 | 799-355-5038 | 946 Caliangt Avenue   |               31 | Gweedore
      10 | 465-429-9641 | 64925 Prentice Drive  |             1057 | Mixco
(10 lignes)
```

Give rights to the `cinema_admin` group on 4 tables

```
postgres=# \c cinema postgres
Vous êtes maintenant connecté à la base de données « cinema » en tant qu'utilisateur « postgres ».
cinema=# GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE movies, movies_theaters, movies_theaters_sessions, sessions TO cinema_admin;
GRANT
```

test access rights

```
postgres@skynet:~$ psql -h 127.0.0.1 -U paul -d cinema
Mot de passe pour l'utilisateur paul : 
psql (14.0 (Ubuntu 14.0-1.pgdg20.04+1))
Connexion SSL (protocole : TLSv1.3, chiffrement : TLS_AES_256_GCM_SHA384, bits : 256, compression : désactivé)
Saisissez « help » pour l'aide.

cinema=> SELECT * FROM infos;
ERREUR:  droit refusé pour la table infos
cinema=> SELECT * FROM movies;
 movie_id |               movie_name               | time_movie 
----------+----------------------------------------+------------
        2 | Marianne & Juliane (Die Bleierne Zeit) | 22:55:00
        3 | Wrestling Queens                       | 06:24:00
        4 | Once You                               | 20:01:00
        5 | Suspended Animation                    | 13:04:00
        1 | November                               | 16:00:00
(5 lignes)
```



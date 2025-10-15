PS C:\Users\user> psql -U postgres -h localhost -p 5432
Password for user postgres:

psql (17.6)
Type "help" for help.

postgres=# CREATE TABLE bt21_lab9 ( char_id SERIAL PRIMARY KEY, name VARCHAR(30), creator VARCHAR(30), species VARCHAR(30) );
CREATE TABLE
postgres=# INSERT INTO bt21_lab9 (name, creator, species) VALUES ('TATA', 'V', 'Alien'), ('CHIMMY', 'Jimin', 'Puppy'), ('COOKY', 'Jungkook', 'Bunny'), ('RJ', 'Jin', 'Alpaca'), ('SHOOKY', 'Suga', 'Cookie'), ('MANG', 'J-Hope', 'Horse'), ('KOYA', 'RM', 'Koala');
INSERT 0 7
postgres=# SELECT * FROM bt21_lab9;
 char_id |  name  | creator  | species
---------+--------+----------+---------
       1 | TATA   | V        | Alien
       2 | CHIMMY | Jimin    | Puppy
       3 | COOKY  | Jungkook | Bunny
       4 | RJ     | Jin      | Alpaca
       5 | SHOOKY | Suga     | Cookie
       6 | MANG   | J-Hope   | Horse
       7 | KOYA   | RM       | Koala
(7 rows)


postgres=# UPDATE bt21_lab9
postgres-# SET species = 'Masked Dancer'
postgres-# WHERE name = 'MANG';
UPDATE 1
postgres=# DELETE FROM bt21_lab9
postgres-# WHERE name = 'SHOOKY';
DELETE 1
postgres=# SELECT * FROM bt21_lab9;
 char_id |  name  | creator  |    species
---------+--------+----------+---------------
       1 | TATA   | V        | Alien
       2 | CHIMMY | Jimin    | Puppy
       3 | COOKY  | Jungkook | Bunny
       4 | RJ     | Jin      | Alpaca
       7 | KOYA   | RM       | Koala
       6 | MANG   | J-Hope   | Masked Dancer
(6 rows)


postgres=#
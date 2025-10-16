PS C:\Users\user> psql -U postgres -h localhost -p 5432
Password for user postgres:

psql (17.6)
Type "help" for help.

postgres=# \c mydb
You are now connected to database "mydb" as user "postgres".
mydb=# CREATE TABLE fans_lab14 ( fan_id SERIAL PRIMARY KEY, name TEXT, balance INT );
CREATE TABLE
mydb=# CREATE TABLE albums_lab14 ( album_id SERIAL PRIMARY KEY, title TEXT, stock INT, price INT );
CREATE TABLE
mydb=# INSERT INTO fans_lab14 (name, balance) VALUES
mydb-# ('Jimin', 100), ('Lisa', 80), ('Taehyung', 50);
INSERT 0 3
mydb=# INSERT INTO albums_lab14 ( title, stock, price) VALUES ('Dynamite', 4, 30), ('ETA', 3, 25);
INSERT 0 2
mydb=# BEGIN;
BEGIN
mydb=*# UPDATE fans_lab14 SET balance = balance - 30 WHERE name = 'Jimin';
UPDATE 1
mydb=*# UPDATE albums_lab14 SET stock = stock - 1 WHERE title = 'Dynamite';
UPDATE 1
mydb=*# COMMIT;
COMMIT
mydb=# BEGIN;
BEGIN
mydb=*# UPDATE fans_lab14 SET balance = balance - 100 WHERE name = 'Taehyung';
UPDATE 1
mydb=*# UPDATE albums_lab14 SET stock = stock - 1 WHERE title = 'Dynamite';
UPDATE 1
mydb=*# ROLLBACK;
ROLLBACK
mydb=#
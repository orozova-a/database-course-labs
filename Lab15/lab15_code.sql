
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
mydb=# \q
PS C:\Users\user> psql -U postgres -h localhost -p 5432
Password for user postgres:

psql (17.6)
Type "help" for help.

postgres=# \c mydb
You are now connected to database "mydb" as user "postgres".
mydb=# CREATE TABLE albums (
mydb(#     album_id SERIAL PRIMARY KEY,
mydb(#     group_name TEXT,
mydb(#     album_title TEXT,
mydb(#     price INT
mydb(# );
ОШИБКА:  отношение "albums" уже существует
mydb=# CREATE TABLE merch (
mydb(#     merch_id SERIAL PRIMARY KEY,
mydb(#     group_name TEXT,
mydb(#     item_name TEXT,
mydb(#     price INT
mydb(# );
CREATE TABLE
mydb=# INSERT INTO merch (group_name, item_name, price) VALUES
mydb-# ('BTS', 'Army Bomb Lightstick', 55),
mydb-# ('Stray Kids', 'SKZ Light Ring', 48),
mydb-# ('NewJeans', 'Bunny Hat', 25),
mydb-# ('TXT', 'Photocard Set', 18);
INSERT 0 4
mydb=# COPY merch TO '/tmp/kpop_merch.csv' WITH CSV HEADER;
ОШИБКА:  не удалось открыть файл "/tmp/kpop_merch.csv" для записи: No such file or directory
HINT:  COPY TO указывает серверному процессу PostgreSQL записать данные в файл. Возможно, на самом деле вам нужно клиентское средство, например, \copy в psql.
mydb=# \copy merch TO 'C:\\Users\\user\\OneDrive\\Документы\\Database\\Labs\\kpop_merch.csv' WITH CSV HEADER;
COPY 4
mydb=# CREATE TABLE kpop_groups (
mydb(#     group_id SERIAL PRIMARY KEY,
mydb(#     group_name VARCHAR(50) NOT NULL,
mydb(#     debut_year INT,
mydb(#     company VARCHAR(50)
mydb(# );
CREATE TABLE
mydb=# DROP TABLE IF EXISTS merch;
DROP TABLE
mydb=# INSERT INTO kpop_groups (group_name, debut_year, company)
mydb-# VALUES
mydb-# ('BTS', 2013, 'HYBE Entertainment'),
mydb-# ('BLACKPINK', 2016, 'YG Entertainment'),
mydb-# ('Stray Kids', 2018, 'JYP Entertainment'),
mydb-# ('NewJeans', 2022, 'ADOR'),
mydb-# ('EXO', 2012, 'SM Entertainment');
INSERT 0 5
mydb=# COMMIT;
ПРЕДУПРЕЖДЕНИЕ:  нет незавершённой транзакции
COMMIT
mydb=# \copy kpop_groups TO 'C:\\Users\\user\\OneDrive\\Документы\\Database\\Labs\\kpop_groups.csv' WITH CSV HEADER;
COPY 5
mydb=# SELECT * FROM kpop_groups ORDER BY group_name;
 group_id | group_name | debut_year |      company
----------+------------+------------+--------------------
        2 | BLACKPINK  |       2016 | YG Entertainment
        1 | BTS        |       2013 | HYBE Entertainment
        5 | EXO        |       2012 | SM Entertainment
        4 | NewJeans   |       2022 | ADOR
        3 | Stray Kids |       2018 | JYP Entertainment
(5 rows)


mydb=#  \copy (SELECT group_name, debut_year FROM kpop_groups WHERE company = 'HYBE') TO 'C:\\Users\\user\\OneDrive\\Документы\\Database\\Labs\\kpop_groups.csv' WITH CSV HEADER;
COPY 0
mydb=#
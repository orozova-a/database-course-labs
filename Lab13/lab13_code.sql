mydb=# CREATE TABLE groups ( group_id SERIAL PRIMARY KEY, group_name VARCHAR(50), debut_year INT );
CREATE TABLE
mydb=# CREATE TABLE members (member_id SERIAL PRIMARY KEY, member_name VARCHAR(50), group_id INT REFERENCES groups(group_id), position VARCHAR(50), age INT );
CREATE TABLE
mydb=# CREATE TABLE albums ( album_id SERIAL PRIMARY KEY, group_id INT REFERENCES groups(group_id), album_name VARCHAR(100), release_year INT, sales_million NUMERIC(4,2) );
CREATE TABLE
mydb=# INSERT INTO groups_lab9 (group_name, debut_year) VALUES
mydb-# ('BTS', 2013),
mydb-# ('Stray Kids', 2018),
mydb-# ;
ОШИБКА:  ошибка синтаксиса (примерное положение: ";")
LINE 4: ;
        ^
mydb=# INSERT INTO groups (group_name, debut_year) VALUES
mydb-# ('BTS', 2013),
mydb-# ('Stray Kids', 2018),
mydb-# ('TXT', 2019);
INSERT 0 3
mydb=# INSERT INTO members (member_name, group_id, position, age) VALUES
mydb-# ('RM', 1, 'Leader', 30),
mydb-# ('Jungkook', 1, 'Vocalist', 27),
mydb-# ('Bang Chan', 2, 'Leader', 27),
mydb-# ('Hyunjin', 2, 'Dancer', 24),
mydb-# ('Yeonjun', 3, 'Vocalist', 25),
mydb-# ('Soobin', 3, 'Leader', 24);
INSERT 0 6
mydb=# INSERT INTO albums (group_id, album_name, release_year, sales_million) VALUES
mydb-# (1, 'Proof', 2022, 3.0),
mydb-# (1, 'BE', 2020, 2.8),
mydb-# (2, '5-Star', 2023, 2.5),
mydb-# (3, 'The Name Chapter', 2023, 1.8);
INSERT 0 4

mydb=# SELECT group_name
mydb-# FROM groups g
mydb-# WHERE g.group_id IN (
mydb(#     SELECT group_id
mydb(#     FROM albums
mydb(# GROUP BY group_id
mydb(#     HAVING AVG(sales_million) > (
mydb(#         SELECT AVG(sales_million) FROM albums ) );
 group_name
------------
 BTS
(1 row)


mydb=# WITH total_sales AS (
mydb(#     SELECT group_id, SUM(sales_million) AS total_group_sales
mydb(#     FROM albums
mydb(#     GROUP BY group_id )
mydb-# SELECT g.group_name, a.album_name, total_group_sales
mydb-# FROM groups g
mydb-# JOIN albums a ON g.group_id = a.group_id
mydb-# JOIN total_sales t ON g.group_id = t.group_id;
 group_name |    album_name    | total_group_sales
------------+------------------+-------------------
 BTS        | Proof            |              5.80
 BTS        | BE               |              5.80
 Stray Kids | 5-Star           |              2.50
 TXT        | The Name Chapter |              1.80
(4 rows)


mydb=# SELECT
mydb-#     album_name,
mydb-#     group_id,
mydb-#     sales_million,
mydb-#     RANK() OVER (ORDER BY sales_million DESC) AS sales_rank
mydb-# FROM albums;
    album_name    | group_id | sales_million | sales_rank
------------------+----------+---------------+------------
 Proof            |        1 |          3.00 |          1
 BE               |        1 |          2.80 |          2
 5-Star           |        2 |          2.50 |          3
 The Name Chapter |        3 |          1.80 |          4
(4 rows)


mydb=# SELECT member_name, position FROM members WHERE position = 'Leader'
mydb-# UNION
mydb-# SELECT member_name, position FROM members WHERE position = 'Vocalist';
 member_name | position
-------------+----------
 Bang Chan   | Leader
 Jungkook    | Vocalist
 RM          | Leader
 Soobin      | Leader
 Yeonjun     | Vocalist
(5 rows)


mydb=# WITH RECURSIVE influence AS (
mydb(#     SELECT group_id, group_name, debut_year
mydb(#     FROM groups
mydb(#     WHERE group_name = 'BTS'
mydb(#     UNION ALL
mydb(#     SELECT g.group_id, g.group_name, g.debut_year
mydb(#     FROM groups g
mydb(#     JOIN influence i ON g.debut_year > i.debut_year )
mydb-# SELECT * FROM influence;
 group_id | group_name | debut_year
----------+------------+------------
        1 | BTS        |       2013
        2 | Stray Kids |       2018
        3 | TXT        |       2019
        3 | TXT        |       2019
(4 rows)


mydb=#
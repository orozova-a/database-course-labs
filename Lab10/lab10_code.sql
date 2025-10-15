postgres=# \c mydb
You are now connected to database "mydb" as user "postgres".
mydb=# CREATE TABLE kdramas_lab10 ( drama_id SERIAL PRIMARY KEY, title VARCHAR(60), lead_actor VARCHAR(50), rating NUMERIC(3,1) );
CREATE TABLE

mydb=# INSERT INTO kdramas_lab10 (title, lead_actor, rating) VALUES ('Goblin', 'Gong Yoo', 9.0), ('Vincenzo', 'Song Joon-ki', 8.8), ('True Beauty', 'Cha Eun-Woo', 8.3), ('My Demon', 'Song Kang', 8.5);
INSERT 0 4
mydb=# SELECT * FROM kdramas_lab10;
 drama_id |    title    |  lead_actor  | rating
----------+-------------+--------------+--------
        1 | Goblin      | Gong Yoo     |    9.0
        2 | Vincenzo    | Song Joon-ki |    8.8
        3 | True Beauty | Cha Eun-Woo  |    8.3
        4 | My Demon    | Song Kang    |    8.5
(4 rows)


mydb=# SELECT title, rating FROM kdramas_lab10;
    title    | rating
-------------+--------
 Goblin      |    9.0
 Vincenzo    |    8.8
 True Beauty |    8.3
 My Demon    |    8.5
(4 rows)


mydb=# SELECT title, rating, rating * 10 AS popularity_points
mydb-# FROM kdramas_lab10;
    title    | rating | popularity_points
-------------+--------+-------------------
 Goblin      |    9.0 |              90.0
 Vincenzo    |    8.8 |              88.0
 True Beauty |    8.3 |              83.0
 My Demon    |    8.5 |              85.0
(4 rows)


mydb=# SELECT title
mydb-# FROM kdramas_lab10
mydb-# WHERE rating > 8.8;
 title
--------
 Goblin
(1 row)


mydb=# SELECT title, lead_actor
mydb-# FROM kdramas_lab10
mydb-# WHERE lead_actor ILIKE 'Song%';
  title   |  lead_actor
----------+--------------
 Vincenzo | Song Joon-ki
 My Demon | Song Kang
(2 rows)


mydb=# SELECT title, rating
mydb-# FROM kdramas_lab10
mydb-# WHERE rating BETWEEN 8.5 AND 9.0
mydb-# ;
  title   | rating
----------+--------
 Goblin   |    9.0
 Vincenzo |    8.8
 My Demon |    8.5
(3 rows)


mydb=# SELECT title, rating,
mydb-# CASE
mydb-# WHEN rating >= 9.0 THEN 'Masterpiece'
mydb-# WHEN rating >= 8.5 THEN 'Popular'
mydb-# ELSE 'Average'
mydb-# END AS category
mydb-# FROM kdramas_lab10;
    title    | rating |  category
-------------+--------+-------------
 Goblin      |    9.0 | Masterpiece
 Vincenzo    |    8.8 | Popular
 True Beauty |    8.3 | Average
 My Demon    |    8.5 | Popular
(4 rows)


mydb=# WITH avg_rate AS ( SELECT AVG(rating) AS avg_rating FROM kdramas_lab10 )
mydb-# SELECT title, rating
mydb-# FROM kdramas_lab10, avg_rate
mydb-# WHERE rating > avg_rate.avg_rating;
  title   | rating
----------+--------
 Goblin   |    9.0
 Vincenzo |    8.8
(2 rows)


mydb=#
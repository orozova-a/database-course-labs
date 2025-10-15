mydb=#  CREATE TABLE Songs (song_id SERIAL PRIMARY KEY, title VARCHAR(100), release_year INT, main_artist_id INT REFERENCES Artists(artist_id) );
CREATE TABLE
mydb=# CREATE TABLE Collabs ( song_id INT REFERENCES Songs(song_id), artist_id INT REFERENCES Artists(artist_id) );
CREATE TABLE
mydb=# INSERT INTO Artists (name, agency) VALUES ('BTS', 'HYBE'), ('Halsey', 'Capitol Records'), ('Coldplay', 'Parlophpne'), ('NewJeans', 'ADOR'), ('IU', 'EDAM');
INSERT 0 5
mydb=# INSERT INTO Songs (title, release_year, main_artist_id) VALUES
mydb-# ('Boy With Luv', 2019, 1),
mydb-# ('My Universe', 2021, 3),
mydb-# ('ETA', 2023, 4),
mydb-# ('Eight', 2020, 5);
INSERT 0 4
mydb=# INSERT INTO Collabs (song_id, artist_id) VALUES
mydb-# (1, 2), (2, 1), (4, 1);
INSERT 0 3
mydb=# SELECT s.title, s.release_year, a.name AS main_artist
mydb-# FROM Songs s
mydb-# INNER JOIN Artists a ON s.main_artist_id = a.artist_id;
    title     | release_year | main_artist
--------------+--------------+-------------
 Boy With Luv |         2019 | BTS
 My Universe  |         2021 | Coldplay
 ETA          |         2023 | NewJeans
 Eight        |         2020 | IU
(4 rows)


mydb=# SELECT a.name, s.title
mydb-# FROM Artists a
mydb-# LEFT JOIN Songs s ON a.artist_id = s.main_artist_id;
   name   |    title
----------+--------------
 BTS      | Boy With Luv
 Coldplay | My Universe
 NewJeans | ETA
 IU       | Eight
 Halsey   |
(5 rows)


mydb=# SELECT s.title, a.name AS main_artist
mydb-# FROM Artists a
mydb-# RIGHT JOIN Songs s ON a.artist_id = s.main_artist_id;
    title     | main_artist
--------------+-------------
 Boy With Luv | BTS
 My Universe  | Coldplay
 ETA          | NewJeans
 Eight        | IU
(4 rows)


mydb=# SELECT a.name AS artist, s.title
mydb-# FROM Artists a
mydb-# FULL OUTER JOIN Songs s ON a.artist_id = s.main_artist_id;
  artist  |    title
----------+--------------
 BTS      | Boy With Luv
 Coldplay | My Universe
 NewJeans | ETA
 IU       | Eight
 Halsey   |
(5 rows)


mydb=# SELECT
mydb-#     s.title,
mydb-#     main.name AS main_artist,
mydb-#     feat.name AS featured_artist
mydb-# FROM Songs s
mydb-# JOIN Artists main ON s.main_artist_id = main.artist_id
mydb-# JOIN Collabs c ON s.song_id = c.song_id
mydb-# JOIN Artists feat ON c.artist_id = feat.artist_id;
    title     | main_artist | featured_artist
--------------+-------------+-----------------
 Boy With Luv | BTS         | Halsey
 My Universe  | Coldplay    | BTS
 Eight        | IU          | BTS
(3 rows)


mydb=#
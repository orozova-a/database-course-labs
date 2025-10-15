mydb=# CREATE TABLE Streams ( id SERIAL PRIMARY KEY, song_name VARCHAR(50), album_name VARCHAR(50), artist VARCHAR(50), streams BIGINT, release_year INT );
CREATE TABLE
mydb=# INSERT INTO Streams (song_name, album_name, artist, streams, release_year) VALUES ('Dynamite', 'BE', 'BTS', 1350000000, 2020), ('Butter', 'Butter', 'BTS', 1200000000, 2021), ('Permission to Dance', 'Butter', 'BTS', 890000000, 2021), ('Euphoria', 'Love Yourself: Answer', 'Jungkook (BTS)', 760000000, 2018), ('Euphoria', 'Love Yourself: Answer', 'Jungkook (BTS)', 760000000, 2018), ('Seven', 'Seven', 'Jungkook (feat. Latto)', 1100000000, 2023), ('ETA', 'Get Up', 'NewJeans', 950000000, 2023), ('Love Dive', 'After Like', 'IVE', 880000000, 2022);
INSERT 0 8
mydb=# SELECT COUNT(*) AS total_songs
mydb-# FROM Streams;
 total_songs
-------------
           8
(1 row)


mydb=# SELECT SUM(streams) AS total_streams
mydb-# FROM Streams;
 total_streams
---------------
    7890000000
(1 row)


mydb=# SELECT AVG(streams) AS avg_streams
mydb-# FROM Streams;
    avg_streams
--------------------
 986250000.00000000
(1 row)


mydb=# SELECT
mydb-# MAX(streams) AS most_streamed,
mydb-# MIN(streams) AS least_streamed
mydb-# FROM Streams;
 most_streamed | least_streamed
---------------+----------------
    1350000000 |      760000000
(1 row)


mydb=# SELECT artist, SUM(streams) AS total_streams
mydb-# FROM Streams
mydb-# GROUP BY artist
mydb-# ORDER BY total_streams DESC;
         artist         | total_streams
------------------------+---------------
 BTS                    |    3440000000
 Jungkook (BTS)         |    1520000000
 Jungkook (feat. Latto) |    1100000000
 NewJeans               |     950000000
 IVE                    |     880000000
(5 rows)


mydb=# SELECT artist, SUM(streams) AS total_streams
mydb-# FROM Streams
mydb-# GROUP BY artist
mydb-# HAVING SUM(streams) > 1000000000;
         artist         | total_streams
------------------------+---------------
 BTS                    |    3440000000
 Jungkook (feat. Latto) |    1100000000
 Jungkook (BTS)         |    1520000000
(3 rows)


mydb=# SELECT album_name, STRING_AGG(song_name, ', ') AS songs
mydb-# FROM Streams
mydb-# GROUP BY album_name;
      album_name       |            songs
-----------------------+-----------------------------
 Butter                | Butter, Permission to Dance
 Get Up                | ETA
 BE                    | Dynamite
 Love Yourself: Answer | Euphoria, Euphoria
 Seven                 | Seven
 After Like            | Love Dive
(6 rows)


mydb=#
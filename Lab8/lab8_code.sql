mydb=# CREATE TABLE members_lab8 ( member_id SERIAL PRIMARY KEY, stage_name VARCHAR(50) NOT NULL, real_name VARCHAR(50), birth_date DATE );
CREATE TABLE
mydb=# \d members_lab8
                                         Table "public.members_lab8"
   Column   |         Type          | Collation | Nullable |                     Default
------------+-----------------------+-----------+----------+-------------------------------------------------
 member_id  | integer               |           | not null | nextval('members_lab8_member_id_seq'::regclass)
 stage_name | character varying(50) |           | not null |
 real_name  | character varying(50) |           |          |
 birth_date | date                  |           |          |
Indexes:
    "members_lab8_pkey" PRIMARY KEY, btree (member_id)


mydb=# CREATE TABLE albums_lab8 ( album_id SERIAL PRIMARY KEY, title VARCHAR(100) NOT NULL, release_year INT, label VARCHAR(100) );
CREATE TABLE
mydb=# \d albums_lab8
                                          Table "public.albums_lab8"
    Column    |          Type          | Collation | Nullable |                    Default
--------------+------------------------+-----------+----------+-----------------------------------------------
 album_id     | integer                |           | not null | nextval('albums_lab8_album_id_seq'::regclass)
 title        | character varying(100) |           | not null |
 release_year | integer                |           |          |
 label        | character varying(100) |           |          |
Indexes:
    "albums_lab8_pkey" PRIMARY KEY, btree (album_id)


mydb=# CREATE TABLE songs_lab8 ( song_id SERIAL PRIMARY KEY, title VARCHAR(100) NOT NULL, duration INT, album_id INT REFERENCES albums_lab8(album_id), main_vocal_id INT REFERENCES members_lab8(member_id) );
CREATE TABLE
mydb=# \d songs_lab8
                                          Table "public.songs_lab8"
    Column     |          Type          | Collation | Nullable |                   Default
---------------+------------------------+-----------+----------+---------------------------------------------
 song_id       | integer                |           | not null | nextval('songs_lab8_song_id_seq'::regclass)
 title         | character varying(100) |           | not null |
 duration      | integer                |           |          |
 album_id      | integer                |           |          |
 main_vocal_id | integer                |           |          |
Indexes:
    "songs_lab8_pkey" PRIMARY KEY, btree (song_id)
Foreign-key constraints:
    "songs_lab8_album_id_fkey" FOREIGN KEY (album_id) REFERENCES albums_lab8(album_id)
    "songs_lab8_main_vocal_id_fkey" FOREIGN KEY (main_vocal_id) REFERENCES members_lab8(member_id)

mydb=# INSERT INTO members_lab8 (stage_name, real_name, birth_date)
mydb-# VALUES ('RM', 'Kim Namjoon', '1994-09-12'), ('Jin', 'Kim Seokjin', '1992-12-04'), ('Suga', 'Min Yoongi', '1993-03-09'), ('J-Hope', 'Jung Hoseok', '1994-02-18'), ('Jimin', 'Park Jimin', '1995-10-13'), ('V', 'Kim Taehyung', '1995-12-30'), ('Jungkook', 'Jeon Jungkook', '1997-09-01');
INSERT 0 7
mydb=# INSERT INTO albums_lab8 (title, release_year, label)
mydb-# VALUES ('Map of the Soul: 7', 2020, 'BigHit Entertainment'), ('BE', 2020, 'BigHit Entertainment'), ('Proof', 2022, 'HYBE');
INSERT 0 3
mydb=# INSERT INTO songs_lab8 (title, duration, album_id, main_vocal_id)
mydb-# VALUES ('Black Swan', 239, 1, 7), ('Life Goes On', 230, 2, 7), ('Butter', 164, 3, 7);
INSERT 0 3
mydb=# \dt
               List of relations
 Schema |        Name        | Type  |  Owner
--------+--------------------+-------+----------
 public | albums_lab8        | table | postgres
 public | course             | table | postgres
 public | course_enrollments | table | postgres
 public | courses            | table | postgres
 public | courses_lab7       | table | postgres
 public | customers          | table | postgres
 public | departments        | table | postgres
 public | enrollments        | table | postgres
 public | enrollments_lab7   | table | postgres
 public | members_lab8       | table | postgres
 public | orders             | table | postgres
 public | products           | table | postgres
 public | professors_lab7    | table | postgres
 public | songs_lab8         | table | postgres
 public | student_cards      | table | postgres
 public | students           | table | postgres
 public | students_a         | table | postgres
 public | students_a_named   | table | postgres
 public | students_a_no_pk   | table | postgres
 public | students_a_single  | table | postgres
 public | students_a_table   | table | postgres
 public | students_lab7      | table | postgres
(22 rows)


mydb=# \d members_lab8
                                         Table "public.members_lab8"
   Column   |         Type          | Collation | Nullable |                     Default
------------+-----------------------+-----------+----------+-------------------------------------------------
 member_id  | integer               |           | not null | nextval('members_lab8_member_id_seq'::regclass)
 stage_name | character varying(50) |           | not null |
 real_name  | character varying(50) |           |          |
 birth_date | date                  |           |          |
Indexes:
    "members_lab8_pkey" PRIMARY KEY, btree (member_id)
Referenced by:
    TABLE "songs_lab8" CONSTRAINT "songs_lab8_main_vocal_id_fkey" FOREIGN KEY (main_vocal_id) REFERENCES members_lab8(member_id)


mydb=# SELECT title, release_year FROM albums_lab8;
       title        | release_year
--------------------+--------------
 Map of the Soul: 7 |         2020
 BE                 |         2020
 Proof              |         2022
(3 rows)


mydb=# SELECT s.title AS song, a.title AS album, m.stage_name AS main_vocal
mydb-# FROM songs_lab8 s
mydb-# JOIN albums_lab8 a ON s.album_id = a.album_id
mydb-# JOIN members_lab8 m ON s.main_vocal_id = m.member_id;
     song     |       album        | main_vocal
--------------+--------------------+------------
 Black Swan   | Map of the Soul: 7 | Jungkook
 Life Goes On | BE                 | Jungkook
 Butter       | Proof              | Jungkook
(3 rows)

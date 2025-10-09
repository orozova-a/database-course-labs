PS C:\Users\user> psql -U postgres -h localhost -p 5432
Password for user postgres:

psql (17.6)
Type "help" for help.

postgres=# \c mydb
You are now connected to database "mydb" as user "postgres".
mydb=# DROP TABLE IF EXISTS students CASCADE;
DROP TABLE
mydb=# DROP TABLE IF EXISTS courses CASCADE;
ЗАМЕЧАНИЕ:  таблица "courses" не существует, пропускается
DROP TABLE
mydb=# DROP TABLE IF EXISTS enrollments CASCADE;
ЗАМЕЧАНИЕ:  таблица "enrollments" не существует, пропускается
DROP TABLE
mydb=# CREATE TABLE students ( student_id SERIAL PRIMARY KEY, name VARCHAR(100) NOT NULL );
CREATE TABLE
mydb=# CREATE TABLE courses ( course_id SERIAL PRIMARY KEY, title VARCHAR(100) NOT NULL );
CREATE TABLE
mydb=# CREATE TABLE enrollments (enrollments_id SERIAL PRIMARY KEY, student_id INT, course_id INT, CONSTRAINT fk_student FOREIGN KEY (student_id) REFERENCES studemts(student_id), CONSTRAINT fk_course FOREIGN KEY (course_id) REFERENCES courses(course_id) );
ОШИБКА:  отношение "studemts" не существует
mydb=#  CREATE TABLE enrollments (enrollments_id SERIAL PRIMARY KEY, student_id INT, course_id INT, CONSTRAINT fk_student FOREIGN KEY (student_id) REFERENCES students(student_id), CONSTRAINT fk_course FOREIGN KEY (course_id) REFERENCES courses(course_id) );
CREATE TABLE
mydb=# ALTER TABLE enrollments
mydb-# DROP CONSTRAINT fk_student,
mydb-# ADD CONSTRAINT fk_student FOREIGN KEY (student_id) REFERENCES students(student_id)
mydb-# ON DELETE CASCADE;
ALTER TABLE
mydb=# CREATE TABLE student_cards ( card_id SERIAL PRIMARU KEY, student_id INT UNIQUE, issue_date DATE NOT NULL, CONSTRAINT fk_card_student FOREIGN KEY (student_id) REFERENCES students(student_id)
mydb(# CREATE TABLE student_cards ( card_id SERIAL PRIMARU KEY, student_id INT UNIQUE, issue_date DATE NOT NULL, CONSTRAINT fk_card_student FOREIGN KEY (student_id) REFERENCES students(student_id) );
mydb(# );
ОШИБКА:  ошибка синтаксиса (примерное положение: "PRIMARU")
LINE 1: CREATE TABLE student_cards ( card_id SERIAL PRIMARU KEY, stu...
                                                    ^
mydb=# CREATE TABLE student_cards ( card_id SERIAL PRIMARU KEY, student_id INT UNIQUE, issue_date DATE NOT NULL, CONSTRAINT fk_card_student FOREIGN KEY (student_id) REFERENCES students(student_id) );
ОШИБКА:  ошибка синтаксиса (примерное положение: "PRIMARU")
LINE 1: CREATE TABLE student_cards ( card_id SERIAL PRIMARU KEY, stu...
                                                    ^
mydb=# CREATE TABLE student_cards ( card_id SERIAL PRIMARY KEY, student_id INT UNIQUE, issue_date DATE NOT NULL, CONSTRAINT fk_card_student FOREIGN KEY (student_id) REFERENCES students(student_id) );
CREATE TABLE
mydb=# CREATE TABLE enrollments ( student_id INT, course_id INT, PRIMARY KEY(student_id, course_id), FOREIGN KEY (student_id) REFERENCES students(student_id) ON DELETE CASCADE, FOREIGN KEY (course_id) REFERENCES courses(course_id) ON DELETE CASCADE );
ОШИБКА:  отношение "enrollments" уже существует
mydb=# DROP TABLE IF EXISTS enrollments CASCADE;
DROP TABLE
mydb=#  CREATE TABLE enrollments ( student_id INT, course_id INT, PRIMARY KEY(student_id, course_id), FOREIGN KEY (student_id) REFERENCES students(student_id) ON DELETE CASCADE, FOREIGN KEY (course_id) REFERENCES courses(course_id) ON DELETE CASCADE );
CREATE TABLE
mydb=# INSERT INTO students (name) VAKUES ('Alice'), ('Bob');
ОШИБКА:  ошибка синтаксиса (примерное положение: "VAKUES")
LINE 1: INSERT INTO students (name) VAKUES ('Alice'), ('Bob');
                                    ^
mydb=# INSERT INTO students (name) VALUES ('Alice'), ('Bob');
INSERT 0 2
mydb=# INSERT INTO courses (title) VALUES ('Databases'), ('Algorithms');
INSERT 0 2
mydb=# INSERT INTO enrollments(srudent_id, course_id) VALUES (1, 1);
ОШИБКА:  столбец "srudent_id" в таблице "enrollments" не существует
LINE 1: INSERT INTO enrollments(srudent_id, course_id) VALUES (1, 1)...
                                ^
mydb=# INSERT INTO enrollments(student_id, course_id) VALUES (1, 1);
INSERT 0 1
mydb=# DELETE FROM students WHERE student_id = 1;
DELETE 1
mydb=# \q
PS C:\Users\user>

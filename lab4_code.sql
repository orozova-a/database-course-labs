PS C:\Users\user> psql -U postgres -h localhost -p 5432
Пароль пользователя postgres:

psql (17.6)
ПРЕДУПРЕЖДЕНИЕ: Кодовая страница консоли (866) отличается от основной
                страницы Windows (1251).
                8-битовые (русские) символы могут отображаться некорректно.
                Подробнее об этом смотрите документацию psql, раздел
                "Notes for Windows users".
Введите "help", чтобы получить справку.

postgres=# CREATE DATABASE mydb; \c mydb
ОШИБКА:  база данных "mydb" уже существует
Вы подключены к базе данных "mydb" как пользователь "postgres".
mydb=# CREATE TABLE students (student_id SERIAL PRIMARY KEY, first_name VARCHAR(50) NOT NULL, last_name VARCHAR(50) NOT NULL, email VARCHAR(100) UNIQUE NOT NULL, faculty VARCHAR(100) );
ОШИБКА:  отношение "students" уже существует
mydb=# CREATE TABLE student (student_id SERIAL PRIMARY KEY, first_name VARCHAR(50) NOT NULL, last_name VARCHAR(50) NOT NULL, email VARCHAR(100) UNIQUE NOT NULL, faculty VARCHAR(100) );
CREATE TABLE
mydb=# \dt
            ╤яшёюъ юЄэю°хэшщ
 ╤їхьр  |   ╚ь     |   ╥шя   | ┬ырфхыхЎ
--------+----------+---------+----------
 public | student  | ЄрсышЎр | postgres
 public | students | ЄрсышЎр | postgres
(2 ёЄЁюъш)


mydb=# CREATE TABLE course (course_id SERIAL PRIMARY KEY, course_name VARCHAR(100) NOT NULL, credits INTEGER CHECK(credits > 0 AND credits <= 6) );
CREATE TABLE
mydb=# \dt
            ╤яшёюъ юЄэю°хэшщ
 ╤їхьр  |   ╚ь     |   ╥шя   | ┬ырфхыхЎ
--------+----------+---------+----------
 public | course   | ЄрсышЎр | postgres
 public | student  | ЄрсышЎр | postgres
 public | students | ЄрсышЎр | postgres
(3 ёЄЁюъш)


mydb=# CREATE TABLE enrollment (enrollment_id SERIAL PRIMARY KEY, student_id INT REFERENCES student(student_id), course_id INT REFERENCES course(course_id), grade INT CHECK (grade BETWEEN 0 AND 100) );
CREATE TABLE
mydb=# \dt
             ╤яшёюъ юЄэю°хэшщ
 ╤їхьр  |    ╚ь      |   ╥шя   | ┬ырфхыхЎ
--------+------------+---------+----------
 public | course     | ЄрсышЎр | postgres
 public | enrollment | ЄрсышЎр | postgres
 public | student    | ЄрсышЎр | postgres
 public | students   | ЄрсышЎр | postgres
(4 ёЄЁюъш)


mydb=# ALTER TABLE student ADD COLUMN phone_number VARCHAR(15);
ALTER TABLE
mydb=# ALTER TABLE student RENAME COLUMN email TO email_address;
ALTER TABLE
mydb=# \d student
                                                   ╥рсышЎр "public.student"
    ╤ЄюысхЎ    |          ╥шя           | ╧Ёртшыю ёюЁЄшЁютъш | ─юяєёЄшьюёЄ№ NULL |                ╧ю єьюыўрэш■
---------------+------------------------+--------------------+-------------------+---------------------------------------------
 student_id    | integer                |                    | not null          | nextval('student_student_id_seq'::regclass)
 first_name    | character varying(50)  |                    | not null          |
 last_name     | character varying(50)  |                    | not null          |
 email_address | character varying(100) |                    | not null          |
 faculty       | character varying(100) |                    |                   |
 phone_number  | character varying(15)  |                    |                   |
╚эфхъё√:
    "student_pkey" PRIMARY KEY, btree (student_id)
    "student_email_key" UNIQUE CONSTRAINT, btree (email_address)
╤ё√ыъш шчтэх:
    TABLE "enrollment" CONSTRAINT "enrollment_student_id_fkey" FOREIGN KEY (student_id) REFERENCES student(student_id)


mydb=# \d enrollment
                                             ╥рсышЎр "public.enrollment"
    ╤ЄюысхЎ    |   ╥шя   | ╧Ёртшыю ёюЁЄшЁютъш | ─юяєёЄшьюёЄ№ NULL |                   ╧ю єьюыўрэш■
---------------+---------+--------------------+-------------------+---------------------------------------------------
 enrollment_id | integer |                    | not null          | nextval('enrollment_enrollment_id_seq'::regclass)
 student_id    | integer |                    |                   |
 course_id     | integer |                    |                   |
 grade         | integer |                    |                   |
╚эфхъё√:
    "enrollment_pkey" PRIMARY KEY, btree (enrollment_id)
╬уЁрэшўхэш -яЁютхЁъш:
    "enrollment_grade_check" CHECK (grade >= 0 AND grade <= 100)
╬уЁрэшўхэш  тэх°эхую ъы■ўр:
    "enrollment_course_id_fkey" FOREIGN KEY (course_id) REFERENCES course(course_id)
    "enrollment_student_id_fkey" FOREIGN KEY (student_id) REFERENCES student(student_id)


mydb=# ALTER TABLE enrollment DROP COLUMN grade;
ALTER TABLE
mydb=# \d enrollment
                                             ╥рсышЎр "public.enrollment"
    ╤ЄюысхЎ    |   ╥шя   | ╧Ёртшыю ёюЁЄшЁютъш | ─юяєёЄшьюёЄ№ NULL |                   ╧ю єьюыўрэш■
---------------+---------+--------------------+-------------------+---------------------------------------------------
 enrollment_id | integer |                    | not null          | nextval('enrollment_enrollment_id_seq'::regclass)
 student_id    | integer |                    |                   |
 course_id     | integer |                    |                   |
╚эфхъё√:
    "enrollment_pkey" PRIMARY KEY, btree (enrollment_id)
╬уЁрэшўхэш  тэх°эхую ъы■ўр:
    "enrollment_course_id_fkey" FOREIGN KEY (course_id) REFERENCES course(course_id)
    "enrollment_student_id_fkey" FOREIGN KEY (student_id) REFERENCES student(student_id)


mydb=# DROP TABLE IF EXISTS student;
ОШИБКА:  удалить объект таблица student нельзя, так как от него зависят другие объекты
ПОДРОБНОСТИ:  ограничение enrollment_student_id_fkey в отношении таблица enrollment зависит от объекта таблица student
ПОДСКАЗКА:  Для удаления зависимых объектов используйте DROP ... CASCADE.
mydb=# DROP TABLE enrollment;
DROP TABLE
mydb=# DROP TABLE student;
DROP TABLE
mydb=# CREATE TEMP TABLE temp_grades (student_id INT, course_id INT, grade INT );
CREATE TABLE
mydb=# \d temp_grades
                       ╥рсышЎр "pg_temp_2.temp_grades"
  ╤ЄюысхЎ   |   ╥шя   | ╧Ёртшыю ёюЁЄшЁютъш | ─юяєёЄшьюёЄ№ NULL | ╧ю єьюыўрэш■
------------+---------+--------------------+-------------------+--------------
 student_id | integer |                    |                   |
 course_id  | integer |                    |                   |
 grade      | integer |                    |                   |


mydb=# \q
PS C:\Users\user>
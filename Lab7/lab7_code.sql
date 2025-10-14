PS C:\Users\user> psql -U postgres -h localhost -p 5432
Password for user postgres:

psql (17.6)
Type "help" for help.

postgres=# \c mydb
You are now connected to database "mydb" as user "postgres".
mydb=# CREATE TABLE students_lab7 ( student_id SERIAL PRIMARY KEY, first_name VARCHAR(50) NOT NULL, last_name VARCHAR(50) NOT NULL, email VARCHAR(100) UNIQUE NOT NULL, fate_of_birth DATE );
CREATE TABLE
mydb=# CREATE TABLE professors_lab7 ( professor_id SERIAL PRIMARY KEY, first_name VARCHAR(50) NOT NULL, last_name VARCHAR(50) NOT NULL, department VARCHAR(100) );
CREATE TABLE
mydb=# CREATE TABLE courses_lab7 (course_id SERIAL PRIMARY KEY, title VARCHAR(100) NOT NULL, credits INT CHECK (credits > 0), professor_id INT REFERENCES professors_lab7(professor_id) );
CREATE TABLE
mydb=# CREATE TABLE enrollments_lab7 ( enrollment_id SERIAL PRIMARY KEY, student_id INT REFERENCES students_lab7(student_id), course_id INT REFERENCES courses_lab7(course_id), Grade CHAR(2) );
CREATE TABLE
mydb=# \d students_lab7
                                           Table "public.students_lab7"
    Column     |          Type          | Collation | Nullable |                      Default
---------------+------------------------+-----------+----------+---------------------------------------------------
 student_id    | integer                |           | not null | nextval('students_lab7_student_id_seq'::regclass)
 first_name    | character varying(50)  |           | not null |
 last_name     | character varying(50)  |           | not null |
 email         | character varying(100) |           | not null |
 fate_of_birth | date                   |           |          |
Indexes:
    "students_lab7_pkey" PRIMARY KEY, btree (student_id)
    "students_lab7_email_key" UNIQUE CONSTRAINT, btree (email)
Referenced by:
    TABLE "enrollments_lab7" CONSTRAINT "enrollments_lab7_student_id_fkey" FOREIGN KEY (student_id) REFERENCES students_lab7(student_id)


mydb=# \d professors_lab7
                                            Table "public.professors_lab7"
    Column    |          Type          | Collation | Nullable |                        Default
--------------+------------------------+-----------+----------+-------------------------------------------------------
 professor_id | integer                |           | not null | nextval('professors_lab7_professor_id_seq'::regclass)
 first_name   | character varying(50)  |           | not null |
 last_name    | character varying(50)  |           | not null |
 department   | character varying(100) |           |          |
Indexes:
    "professors_lab7_pkey" PRIMARY KEY, btree (professor_id)
Referenced by:
    TABLE "courses_lab7" CONSTRAINT "courses_lab7_professor_id_fkey" FOREIGN KEY (professor_id) REFERENCES professors_lab7(professor_id)


mydb=# \d courses_lab7
                                          Table "public.courses_lab7"
    Column    |          Type          | Collation | Nullable |                     Default
--------------+------------------------+-----------+----------+-------------------------------------------------
 course_id    | integer                |           | not null | nextval('courses_lab7_course_id_seq'::regclass)
 title        | character varying(100) |           | not null |
 credits      | integer                |           |          |
 professor_id | integer                |           |          |
Indexes:
    "courses_lab7_pkey" PRIMARY KEY, btree (course_id)
Check constraints:
    "courses_lab7_credits_check" CHECK (credits > 0)
Foreign-key constraints:
    "courses_lab7_professor_id_fkey" FOREIGN KEY (professor_id) REFERENCES professors_lab7(professor_id)
Referenced by:
    TABLE "enrollments_lab7" CONSTRAINT "enrollments_lab7_course_id_fkey" FOREIGN KEY (course_id) REFERENCES courses_lab7(course_id)

mydb=# \d enrollments_lab7
                                        Table "public.enrollments_lab7"
    Column     |     Type     | Collation | Nullable |                         Default
---------------+--------------+-----------+----------+---------------------------------------------------------
 enrollment_id | integer      |           | not null | nextval('enrollments_lab7_enrollment_id_seq'::regclass)
 student_id    | integer      |           |          |
 course_id     | integer      |           |          |
 grade         | character(2) |           |          |
Indexes:
    "enrollments_lab7_pkey" PRIMARY KEY, btree (enrollment_id)
Foreign-key constraints:
    "enrollments_lab7_course_id_fkey" FOREIGN KEY (course_id) REFERENCES courses_lab7(course_id)
    "enrollments_lab7_student_id_fkey" FOREIGN KEY (student_id) REFERENCES students_lab7(student_id)


mydb=# INSERT INTO professors_lab7 (first_name, last_name, department)
mydb-# VALUES ('Sultan', 'Usuvaliev', 'TCMA'), ('Gulzada', 'Esenalieva', 'Computer Science'), ('Sergei', 'Sklyar', 'Mathematics');
INSERT 0 3                                                   ^
mydb=# INSERT INTO students_lab7 (first_name, last_name, email, fate_of_birth)
mydb-# VALUES ('Atai', 'Soorbekov', 'atai@auca.kg', '2005-07-12'), ('Valeriya', 'Pan', 'valeriya@auca.kg', '2005-10-07');
INSERT 0 2
mydb=# INSERT INTO courses_lab7 (title, credits, professor_id)
mydb-# VALUES ('Database', 3, 2), ('Optimization Methods', 4, 1);
INSERT 0 2
mydb=# INSERT INTO enrollments_lab7 (student_id, course_id, grade)
mydb-# VALUES (1, 1, 'A'), (2, 1, 'B'), (1, 2, 'A');
INSERT 0 3

mydb=# SELECT s.first_name, s.last_name, c.title, e.grade
mydb-# FROM students_lab7 s
mydb-# JOIN enrollments_lab7 e ON s.student_id = e.student_id
mydb-# JOIN courses_lab7 c ON e.course_id = c.course_id;
 first_name | last_name |        title         | grade
------------+-----------+----------------------+-------
 Atai       | Soorbekov | Database             | A
 Valeriya   | Pan       | Database             | B
 Atai       | Soorbekov | Optimization Methods | A
(3 rows)


mydb=# SELECT c.title, p.first_name AS professor
mydb-# FROM courses_lab7 c
mydb-# JOIN professors_lab7 p ON c.professor_id = p.professor_id;
        title         | professor
----------------------+-----------
 Database             | Gulzada
 Optimization Methods | Sultan
(2 rows)


mydb=#
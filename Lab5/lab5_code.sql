PS C:\Users\user> psql -U postgres -h localhost -p 5432
Password for user postgres:

psql (17.6)
Type "help" for help.

postgres=# \c mydb
You are now connected to database "mydb" as user "postgres".
mydb=# CREATE TABLE students (student_id INTGER PRIMARY KEY, namr VARCHAR(100), email VARCHAR(150) );
ОШИБКА:  тип "intger" не существует
LINE 1: CREATE TABLE students (student_id INTGER PRIMARY KEY, namr V...
                                          ^
mydb=# CREATE TABLE students (student_id INTEGER PRIMARY KEY, name VARCHAR(100), email VARCHAR(150) );
ОШИБКА:  отношение "students" уже существует
mydb=# CREATE TABLE students_a (student_id INTEGER PRIMARY KEY, name VARCHAR(100), email VARCHAR(150) );
CREATE TABLE
mydb=# CREATE TABLE students_a_table (student_id INTEGER, name VARCHAR(100), email VARCHAR(150), PRIMARY KEY (student_id) );
CREATE TABLE
mydb=# CREATE TABLE students_a_named (student_id INTEGER, name VARCHAR(100). email VARCHAR(150), CONSTRAINT pk_students_named PRIMARY KEY (student_id) );
ОШИБКА:  ошибка синтаксиса (примерное положение: ".")
LINE 1: ...nts_a_named (student_id INTEGER, name VARCHAR(100). email VA...
                                                             ^
mydb=# CREATE TABLE students_a_named (student_id INTEGER, name VARCHAR(100), email VARCHAR(150), CONSTRAINT pk_students_named PRIMARY KEY (student_id) );
CREATE TABLE
mydb=# CREATE TABLE students_a_no_pk (student_id INTEGER, name VARCHAR(100), email VARCHAR(150) );
CREATE TABLE
mydb=# \d students_a_no_pk
                   Table "public.students_a_no_pk"
   Column   |          Type          | Collation | Nullable | Default
------------+------------------------+-----------+----------+---------
 student_id | integer                |           |          |
 name       | character varying(100) |           |          |
 email      | character varying(150) |           |          |


mydb=# ALTER TABLE students_a_no_pk
mydb-# ADD CONSTRAINT pk_students_no_pk PRIMARY KEY (student_id);
ALTER TABLE
mydb=# \d students_a_no_pk
                   Table "public.students_a_no_pk"
   Column   |          Type          | Collation | Nullable | Default
------------+------------------------+-----------+----------+---------
 student_id | integer                |           | not null |
 name       | character varying(100) |           |          |
 email      | character varying(150) |           |          |
Indexes:
    "pk_students_no_pk" PRIMARY KEY, btree (student_id)


mydb=# CREATE TABLE students_a_single (student_id SERIAL PRIMARY KEY, name VARCHAR (100) NOT NULL, email VARCHAR(150) UNIQUE, faculty VARCHAR(50) );
CREATE TABLE
mydb=# \d students_a_single
                                          Table "public.students_a_single"
   Column   |          Type          | Collation | Nullable |                        Default
------------+------------------------+-----------+----------+-------------------------------------------------------
 student_id | integer                |           | not null | nextval('students_a_single_student_id_seq'::regclass)
 name       | character varying(100) |           | not null |
 email      | character varying(150) |           |          |
 faculty    | character varying(50)  |           |          |
Indexes:
    "students_a_single_pkey" PRIMARY KEY, btree (student_id)
    "students_a_single_email_key" UNIQUE CONSTRAINT, btree (email)


mydb=# INSERT INTO students_a_single (name, email, faculty) VALUES ('Alice Johnson', 'alice@alatoo.edu.kg', 'Mathematics'), ('Bob Smith', 'bob@alatoo.edu.kg', 'Computer Science'), ('Carol DAvis', 'carol@alatoo.edu.kg', 'Computer Science');
INSERT 0 3
mydb=# \d students_a_single
                                          Table "public.students_a_single"
   Column   |          Type          | Collation | Nullable |                        Default
------------+------------------------+-----------+----------+-------------------------------------------------------
 student_id | integer                |           | not null | nextval('students_a_single_student_id_seq'::regclass)
 name       | character varying(100) |           | not null |
 email      | character varying(150) |           |          |
 faculty    | character varying(50)  |           |          |
Indexes:
    "students_a_single_pkey" PRIMARY KEY, btree (student_id)
    "students_a_single_email_key" UNIQUE CONSTRAINT, btree (email)


mydb=# CREATE TABLE course_enrollments (student_id INTEGER, course_id INTEGER, semester VARCHAR(20), enrollment_date DATE DEFAULT CURRENT_DATE, grade CHAR(2), PRIMARY KEY (student_id, course_id, semester) );
CREATE TABLE
mydb=# INSERT INTO course_enrollments (student_id, course_id, semester, grade) VALUES (1, 101, '2024-Spring', 'A'), (1, 102, '2024-Spring', 'B+'), (2, 101, '2024-Spring', 'A-'), (1, 101, '2024-Fall', 'A+');
INSERT 0 4
mydb=# \d course_enrollments
                       Table "public.course_enrollments"
     Column      |         Type          | Collation | Nullable |   Default 
-----------------+-----------------------+-----------+----------+--------------
 student_id      | integer               |           | not null |
 course_id       | integer               |           | not null |
 semester        | character varying(20) |           | not null |
 enrollment_date | date                  |           |          | CURRENT_DATE
 grade           | character(2)          |           |          |
Indexes:
    "course_enrollments_pkey" PRIMARY KEY, btree (student_id, course_id, semester)


mydb=# CREATE TABLE products (product_id SERIAL PRIMARY KEY, product_name VARCHAR(100) NOT NULL, price DECIMAL(10,2) );
CREATE TABLE
mydb=# \d products
                                           Table "public.products"
    Column    |          Type          | Collation | Nullable |                   Default
--------------+------------------------+-----------+----------+----------------------------------------------
 product_id   | integer                |           | not null | nextval('products_product_id_seq'::regclass)
 product_name | character varying(100) |           | not null |
 price        | numeric(10,2)          |           |          |
Indexes:
    "products_pkey" PRIMARY KEY, btree (product_id)


mydb=# CREATE TABLE orders (order_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY, customer_name VARCHAR(100), order_date DATE DEFAULT CURRENT_DATE );
CREATE TABLE
mydb=# \d orders
                                    Table "public.orders"
    Column     |          Type          | Collation | Nullable |           Default
---------------+------------------------+-----------+----------+------------------------------
 order_id      | integer                |           | not null | generated always as identity
 customer_name | character varying(100) |           |          |
 order_date    | date                   |           |          | CURRENT_DATE
Indexes:
    "orders_pkey" PRIMARY KEY, btree (order_id)


mydb=# CREATE TABLE customers (customer_id INTEGER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY, customer_name VARCHAR(100), email VARCHAR(150) );
CREATE TABLE
mydb=# INSERT INTO customers (customer_id, customer_name, email)
mydb-# VALUES (1000, 'VIP Customer', 'vip@example.com');
INSERT 0 1
mydb=# CREATE TABLE departments (dept_id INTEGER PRIMARY KEY, dept_name VARCHAR(100) );
CREATE TABLE
mydb=# \d departments
                     Table "public.departments"
  Column   |          Type          | Collation | Nullable | Default
-----------+------------------------+-----------+----------+---------
 dept_id   | integer                |           | not null |
 dept_name | character varying(100) |           |          |
Indexes:
    "departments_pkey" PRIMARY KEY, btree (dept_id)


mydb=# INSERT INTO departments VALUES (1, 'Computer Science');
INSERT 0 1
mydb=# \d departments
                     Table "public.departments"
  Column   |          Type          | Collation | Nullable | Default
-----------+------------------------+-----------+----------+---------
 dept_id   | integer                |           | not null |
 dept_name | character varying(100) |           |          |
Indexes:
    "departments_pkey" PRIMARY KEY, btree (dept_id)


mydb=# \q
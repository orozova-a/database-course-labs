PS C:\Users\user>  psql -U postgres -d mydb -h localhost -p 5432
Пароль пользователя postgres:

psql (17.6)
ПРЕДУПРЕЖДЕНИЕ: Кодовая страница консоли (866) отличается от основной
                страницы Windows (1251).
                8-битовые (русские) символы могут отображаться некорректно.
                Подробнее об этом смотрите документацию psql, раздел
                "Notes for Windows users".
Введите "help", чтобы получить справку.

mydb=#  CREATE TABLE students ( student_id SERIAL PRIMARY KEY, name VARCHAR(100), email VARCHAR(100), faculty VARCHAR(50) );
ОШИБКА:  отношение "students" уже существует
mydb=# INSERT INTO students (name, email, faculty) VALUES ('Alymbek', 'alymbek@example.com', 'COM-25'), ('Timur', 'timur@example.com', 'MED'), ('Beka', 'beka@example.com', 'MAT'), ('Aizada', 'aizada@example.com', 'COM-25');
INSERT 0 4
mydb=# SELECT * FROM students;
 student_id |  name   |        email        | faculty
------------+---------+---------------------+---------
          1 | Alymbek | alymbek@example.com | COM-25
          2 | Timur   | timur@example.com   | MED
          3 | Beka    | beka@example.com    | MAT
          4 | Aizada  | aizada@example.com  | COM-25
(4 ёЄЁюъш)


mydb=# SELECT name, email, FROM students;
ОШИБКА:  ошибка синтаксиса (примерное положение: "FROM")
СТРОКА 1: SELECT name, email, FROM students;
                              ^
mydb=#  SELECT name, email FROM students;
  name   |        email
---------+---------------------
 Alymbek | alymbek@example.com
 Timur   | timur@example.com
 Beka    | beka@example.com
 Aizada  | aizada@example.com
(4 ёЄЁюъш)


mydb=# SELECT name, email FROM students WHERE faculty = 'COM-25';
  name   |        email
---------+---------------------
 Alymbek | alymbek@example.com
 Aizada  | aizada@example.com
(2 ёЄЁюъш)


mydb=# SELECT name, email FROM students WHERE name = 'Timur';
 name  |       email
-------+-------------------
 Timur | timur@example.com
(1 ёЄЁюър)


mydb=# SELECT name, email FROM students ORDER BY name ASC;
  name   |        email
---------+---------------------
 Aizada  | aizada@example.com
 Alymbek | alymbek@example.com
 Beka    | beka@example.com
 Timur   | timur@example.com
(4 ёЄЁюъш)


mydb=# SELECT name, email FROM students ORDER BY name DESC;
  name   |        email
---------+---------------------
 Timur   | timur@example.com
 Beka    | beka@example.com
 Alymbek | alymbek@example.com
 Aizada  | aizada@example.com
(4 ёЄЁюъш)


mydb=# SELECT name, email FROM students LIMIT 2;
  name   |        email
---------+---------------------
 Alymbek | alymbek@example.com
 Timur   | timur@example.com
(2 ёЄЁюъш)


mydb=# SELECT name, email FROM students WHERE faculty = 'COM-25';
  name   |        email
---------+---------------------
 Alymbek | alymbek@example.com
 Aizada  | aizada@example.com
(2 ёЄЁюъш)


mydb=# /*Show only first two students ordered alphabetically */ SELECT name, email FROM students ORDER BY name ASC LIMIT 2;
  name   |        email
---------+---------------------
 Aizada  | aizada@example.com
 Alymbek | alymbek@example.com
(2 ёЄЁюъш)


mydb=#

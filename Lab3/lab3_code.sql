mydb=# CREATE DATABASE university;
CREATE DATABASE
mydb=# DROP DATABASE university;
DROP DATABASE
mydb=# \c university;
подключиться к серверу "localhost" (::1), порту 5432 не удалось: ВАЖНО:  база данных "university" не существует
Сохранено предыдущее подключение
mydb=# \c university
подключиться к серверу "localhost" (::1), порту 5432 не удалось: ВАЖНО:  база данных "university" не существует
Сохранено предыдущее подключение
mydb=# CREATE DATABASE university;
CREATE DATABASE
mydb=# \c university
Вы подключены к базе данных "university" как пользователь "postgres".
university=# psql -d university -U postgres
university-# DROP DATABASE university;
ОШИБКА:  ошибка синтаксиса (примерное положение: "psql")
СТРОКА 1: psql -d university -U postgres
          ^
university=# DROP DATABASE university;
ОШИБКА:  удалить базу данных, открытую в данный момент, нельзя
university=# CREATE DATABASE course_management;
CREATE DATABASE
university=# \c course_management
Вы подключены к базе данных "course_management" как пользователь "postgres".
course_management=# DROP DATABASE university;
DROP DATABASE
course_management=# CREATE DATABASE sosnovka_family;
CREATE DATABASE
course_management=# \c sosnovka_family
Вы подключены к базе данных "sosnovka_family" как пользователь "postgres".
sosnovka_family=# DROP DATABASE course_management;
DROP DATABASE
sosnovka_family=#
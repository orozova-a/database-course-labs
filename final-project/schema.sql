-- Schema for Database Final Project - Book Reading Tracker

CREATE TYPE shelf_status AS ENUM ('Want to Read', 'Reading', 'Finished');
CREATE TYPE highlight_color AS ENUM ('Moonlight silver', 'Rivendell Sage', 'Lorien Gold', 'Elanor Bloom', 'Starlit violet');

CREATE TABLE users (
   user_id SERIAL PRIMARY KEY,
   username VARCHAR(50) NOT NULL UNIQUE,
   email VARCHAR(100) NOT NULL UNIQUE,
   created_at DATE DEFAULT CURRENT_DATE );

CREATE TABLE authors ( 
   author_id SERIAL PRIMARY KEY,
   name VARCHAR(100) NOT NULL,
   bio TEXT );

CREATE TABLE genres (
   genre_id SERIAL PRIMARY KEY,
   name VARCHAR(50) NOT NULL UNIQUE,
   description TEXT
);

CREATE TABLE books (
   book_id SERIAL PRIMARY KEY,
   title VARCHAR(100) NOT NULL,
   author_id INT NOT NULL REFERENCES authors(author_id) ON DELETE CASCADE,
   genre_id INT NOT NULL REFERENCES genres(genre_id) ON DELETE CASCADE,
   pages INT,
   published_year INT
);

CREATE TABLE reviews (
   review_id SERIAL PRIMARY KEY,
   user_id INT NOT NULL REFERENCES users(user_id) ON DELETE CASCADE,
   book_id INT NOT NULL REFERENCES books(book_id) ON DELETE CASCADE,
   rating INT CHECK (rating BETWEEN 1 AND 5),
   comment TEXT,
   review_date DATE DEFAULT CURRENT_DATE
);

CREATE TABLE reading_progress (
   progress_id SERIAL PRIMARY KEY,
   user_id INT NOT NULL REFERENCES users(user_id) ON DELETE CASCADE,
   book_id INT NOT NULL REFERENCES books(book_id) ON DELETE CASCADE,
   percentage_read DECIMAL(5,2) DEFAULT 0,
   start_date DATE,
   finish_date DATE
);

CREATE TABLE bookshelves (
   shelf_id SERIAL PRIMARY KEY,
   user_id INT NOT NULL REFERENCES users(user_id) ON DELETE CASCADE,
   book_id INT NOT NULL REFERENCES books(book_id) ON DELETE CASCADE,
   status shelf_status NOT NULL DEFAULT 'Want to Read',
   date_added DATE DEFAULT CURRENT_DATE
);

CREATE TABLE quotes (
   quote_id SERIAL PRIMARY KEY,
   user_id INT NOT NULL REFERENCES users(user_id) ON DELETE CASCADE,
   book_id INT NOT NULL REFERENCES books(book_id) ON DELETE CASCADE,
   quote_text TEXT NOT NULL,
   page_number INT,
   date_added DATE DEFAULT CURRENT_DATE,
   highlight_color highlight_color DEFAULT 'Moonlight silver',
   emotion VARCHAR(50)
);

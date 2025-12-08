-- Queries for Book Reading Tracker

SELECT * FROM books;

-- users and what they are reading
SELECT u.username, b.title, bs.status
FROM users u
JOIN bookshelves bs ON u.user_id = bs.user_id
JOIN books b ON bs.book_id = b.book_id;

-- users who finished a book
SELECT u.username, b.title
FROM bookshelves bs
JOIN users u ON bs.user_id = u.user_id
JOIN books b ON bs.book_id = b.book_id
WHERE bs.status = 'Finished';

-- quotes by highlight color
SELECT highlight_color, COUNT(*) AS total
FROM quotes
GROUP BY highlight_color;

-- books with average rating
SELECT b.title, ROUND(AVG(r.rating), 2) AS avg_rating
FROM books b
JOIN reviews r ON b.book_id = r.book_id
GROUP BY b.title;

-- top readers
SELECT u.username, COUNT(*) AS books_read
FROM reading_progress rp
JOIN users u ON rp.user_id = u.user_id
WHERE rp.percentage_read = 100
GROUP BY u.username
ORDER BY books_read DESC;

-- most quoted books
SELECT title
FROM books
WHERE book_id IN (
   SELECT book_id
   FROM quotes
   GROUP BY book_id
   HAVING COUNT(*) > 1
);

-- quotes and emotions
SELECT u.username, q.quote_text, q.emotion
FROM quotes q
JOIN users u ON q.user_id = u.user_id;

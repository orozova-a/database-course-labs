-- Data for Database Final Project - Book Reading Tracker (insert data)

INSERT INTO users (username, email)
VALUES
('akylai', 'akylai@example.com'),
('lera', 'lera@example.com'),
('atai', 'atai@example.com'),
('arlen', 'arlen@example.com'),
('vitalik', 'vitalik@example.com'),
('bekzhan', 'bekzhan@example.com'),
('denis', 'denis@example.com'),
('danil', 'danil@example.com');

INSERT INTO authors (name, bio)
VALUES
('J.R.R. Tolkien', 'Author of epic high fantasy; inspired by myth and nature.'),
('Haruki Murakami', 'Contemporary Japanese novelist, magical realism and introspection.'),
('Jane Austen', 'Classic novelist of manners and romance.'),
('Rupi Kaur', 'Poet known for short, emotional pieces.'),
('Kim Namjoon (RM)', 'RM of BTS — poet, lyricist, and thinker.'),
('Chimamanda Ngozi Adichie', 'Contemporary novelist exploring identity and culture.');

INSERT INTO genres (name, description)
VALUES
('Fantasy', 'Fiction with magical or supernatural elements.'),
('Contemporary', 'Modern life fiction.'),
('Classic', 'Classic literature.'),
('Poetry', 'Poetry collections and short verse.'),
('Non-Fiction', 'Essays, memoirs, and factual works.');

INSERT INTO books (title, author_id, genre_id, pages, published_year)
VALUES
('The Fellowship of the Ring', (SELECT author_id FROM authors WHERE name='J.R.R. Tolkien'), (SELECT genre_id FROM genres WHERE name='Fantasy'), 423, 1954),
('Kafka on the Shore', (SELECT author_id FROM authors WHERE name='Haruki Murakami'), (SELECT genre_id FROM genres WHERE name='Contemporary'), 505, 2002),
('Pride and Prejudice', (SELECT author_id FROM authors WHERE name='Jane Austen'), (SELECT genre_id FROM genres WHERE name='Classic'), 279, 1813),
('Milk and Honey', (SELECT author_id FROM authors WHERE name='Rupi Kaur'), (SELECT genre_id FROM genres WHERE name='Poetry'), 201, 2014),
('Chosen Essays', (SELECT author_id FROM authors WHERE name='Chimamanda Ngozi Adichie'), (SELECT genre_id FROM genres WHERE name='Non-Fiction'), 240, 2017),
('RM: Selected Thoughts', (SELECT author_id FROM authors WHERE name='Kim Namjoon (RM)'), (SELECT genre_id FROM genres WHERE name='Poetry'), 120, 2020),
('Norwegian Wood', (SELECT author_id FROM authors WHERE name='Haruki Murakami'), (SELECT genre_id FROM genres WHERE name='Contemporary'), 296, 1987),
('The Two Towers', (SELECT author_id FROM authors WHERE name='J.R.R. Tolkien'), (SELECT genre_id FROM genres WHERE name='Fantasy'), 352, 1954),
('Sense and Sensibility', (SELECT author_id FROM authors WHERE name='Jane Austen'), (SELECT genre_id FROM genres WHERE name='Classic'), 226, 1811),
('Poems for Winter', (SELECT author_id FROM authors WHERE name='Rupi Kaur'), (SELECT genre_id FROM genres WHERE name='Poetry'), 95, 2019);

INSERT INTO reviews (user_id, book_id, rating, comment)
VALUES
((SELECT user_id FROM users WHERE username='akylai'), (SELECT book_id FROM books WHERE title='The Fellowship of the Ring'), 5, 'A magical start — perfect for autumn nights.'),
((SELECT user_id FROM users WHERE username='lera'), (SELECT book_id FROM books WHERE title='Pride and Prejudice'), 4, 'Witty and charming.'),
((SELECT user_id FROM users WHERE username='atai'), (SELECT book_id FROM books WHERE title='Milk and Honey'), 3, 'Short, emotional, mixed feelings.'),
((SELECT user_id FROM users WHERE username='arlen'), (SELECT book_id FROM books WHERE title='Kafka on the Shore'), 5, 'Strange and lovely.'),
((SELECT user_id FROM users WHERE username='vitalik'), (SELECT book_id FROM books WHERE title='Norwegian Wood'), 4, 'Nostalgic and bittersweet.'),
((SELECT user_id FROM users WHERE username='bekzhan'), (SELECT book_id FROM books WHERE title='RM: Selected Thoughts'), 5, 'So comforting and wise.'),
((SELECT user_id FROM users WHERE username='denis'), (SELECT book_id FROM books WHERE title='The Two Towers'), 5, 'Action and heart.'),
((SELECT user_id FROM users WHERE username='danil'), (SELECT book_id FROM books WHERE title='Chosen Essays'), 4, 'Thought-provoking essays.');

INSERT INTO reading_progress (user_id, book_id, percentage_read, start_date, finish_date)
VALUES
((SELECT user_id FROM users WHERE username='akylai'), (SELECT book_id FROM books WHERE title='The Fellowship of the Ring'), 35.00, '2025-11-20', NULL),
((SELECT user_id FROM users WHERE username='lera'), (SELECT book_id FROM books WHERE title='Pride and Prejudice'), 100.00, '2025-10-01', '2025-10-20'),
((SELECT user_id FROM users WHERE username='atai'), (SELECT book_id FROM books WHERE title='Milk and Honey'), 40.00, '2025-11-01', NULL),
((SELECT user_id FROM users WHERE username='arlen'), (SELECT book_id FROM books WHERE title='Kafka on the Shore'), 10.00, '2025-11-25', NULL),
((SELECT user_id FROM users WHERE username='vitalik'), (SELECT book_id FROM books WHERE title='Norwegian Wood'), 75.00, '2025-09-10', NULL),
((SELECT user_id FROM users WHERE username='bekzhan'), (SELECT book_id FROM books WHERE title='RM: Selected Thoughts'), 100.00, '2025-05-01', '2025-05-07'),
((SELECT user_id FROM users WHERE username='denis'), (SELECT book_id FROM books WHERE title='The Two Towers'), 50.00, '2025-08-12', NULL),
((SELECT user_id FROM users WHERE username='danil'), (SELECT book_id FROM books WHERE title='Chosen Essays'), 20.00, '2025-11-05', NULL);

INSERT INTO bookshelves (user_id, book_id, status)
VALUES
((SELECT user_id FROM users WHERE username='akylai'), (SELECT book_id FROM books WHERE title='The Fellowship of the Ring'), 'Reading'),
((SELECT user_id FROM users WHERE username='lera'), (SELECT book_id FROM books WHERE title='Pride and Prejudice'), 'Finished'),
((SELECT user_id FROM users WHERE username='atai'), (SELECT book_id FROM books WHERE title='Milk and Honey'), 'Reading'),
((SELECT user_id FROM users WHERE username='arlen'), (SELECT book_id FROM books WHERE title='Kafka on the Shore'), 'Want to Read'),
((SELECT user_id FROM users WHERE username='vitalik'), (SELECT book_id FROM books WHERE title='Norwegian Wood'), 'Reading'),
((SELECT user_id FROM users WHERE username='bekzhan'), (SELECT book_id FROM books WHERE title='RM: Selected Thoughts'), 'Finished'),
((SELECT user_id FROM users WHERE username='denis'), (SELECT book_id FROM books WHERE title='The Two Towers'), 'Reading'),
((SELECT user_id FROM users WHERE username='danil'), (SELECT book_id FROM books WHERE title='Chosen Essays'), 'Want to Read');

INSERT INTO quotes (user_id, book_id, quote_text, page_number, highlight_color, emotion)
VALUES
((SELECT user_id FROM users WHERE username='akylai'), (SELECT book_id FROM books WHERE title='The Fellowship of the Ring'), 'All we have to decide is what to do with the time that is given us.', 201, 'Lorien Gold', 'contemplative'),
((SELECT user_id FROM users WHERE username='lera'), (SELECT book_id FROM books WHERE title='Pride and Prejudice'), 'I declare after all there is no enjoyment like reading!', 47, 'Elanor Bloom', 'joyful'),
((SELECT user_id FROM users WHERE username='atai'), (SELECT book_id FROM books WHERE title='Milk and Honey'), 'You tell me you are sad, and I believe you.', 12, 'Moonlight silver', 'sad'),
((SELECT user_id FROM users WHERE username='arlen'), (SELECT book_id FROM books WHERE title='Kafka on the Shore'), 'Sometimes fate is like a small sandstorm.', 88, 'Starlit violet', 'mysterious'),
((SELECT user_id FROM users WHERE username='vitalik'), (SELECT book_id FROM books WHERE title='Norwegian Wood'), 'I once had a girl, or should I say, she once had me.', 3, 'Rivendell Sage', 'nostalgic'),
((SELECT user_id FROM users WHERE username='bekzhan'), (SELECT book_id FROM books WHERE title='RM: Selected Thoughts'), 'You were born to be real, not to be perfect.', 14, 'Rivendell Sage', 'comforting'),
((SELECT user_id FROM users WHERE username='denis'), (SELECT book_id FROM books WHERE title='The Two Towers'), 'There is some good in this world, and it’s worth fighting for.', 320, 'Lorien Gold', 'hopeful'),
((SELECT user_id FROM users WHERE username='danil'), (SELECT book_id FROM books WHERE title='Chosen Essays'), 'Stories were not just stories for me but maps to myself.', 52, 'Elanor Bloom', 'reflective'),
((SELECT user_id FROM users WHERE username='akylai'), (SELECT book_id FROM books WHERE title='RM: Selected Thoughts'), 'To love yourself is the beginning of a lifelong romance.', 7, 'Elanor Bloom', 'self-love'),
((SELECT user_id FROM users WHERE username='lera'), (SELECT book_id FROM books WHERE title='RM: Selected Thoughts'), 'No one is born beautiful in this judgmental society.', 21, 'Moonlight silver', 'comforting');

-- end data
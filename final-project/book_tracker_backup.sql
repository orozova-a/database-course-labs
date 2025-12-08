--
-- PostgreSQL database dump
--

\restrict sNSYmClmhvykV0rHQF5gThVFwI1ClbNYIMIG9fT0s3gCHvyzkJnufZDHeZx51YK

-- Dumped from database version 17.6
-- Dumped by pg_dump version 17.6

-- Started on 2025-12-08 16:08:19

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 864 (class 1247 OID 25146)
-- Name: highlight_color; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.highlight_color AS ENUM (
    'Moonlight silver',
    'Rivendell Sage',
    'Lorien Gold',
    'Elanor Bloom',
    'Starlit violet'
);


ALTER TYPE public.highlight_color OWNER TO postgres;

--
-- TOC entry 861 (class 1247 OID 25139)
-- Name: shelf_status; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.shelf_status AS ENUM (
    'Want to Read',
    'Reading',
    'Finished'
);


ALTER TYPE public.shelf_status OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 222 (class 1259 OID 25196)
-- Name: authors; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.authors (
    author_id integer NOT NULL,
    name character varying(100) NOT NULL,
    bio text
);


ALTER TABLE public.authors OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 25195)
-- Name: authors_author_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.authors_author_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.authors_author_id_seq OWNER TO postgres;

--
-- TOC entry 5000 (class 0 OID 0)
-- Dependencies: 221
-- Name: authors_author_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.authors_author_id_seq OWNED BY public.authors.author_id;


--
-- TOC entry 224 (class 1259 OID 25286)
-- Name: books; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.books (
    book_id integer NOT NULL,
    title character varying(100) NOT NULL,
    author_id integer NOT NULL,
    genre_id integer NOT NULL,
    pages integer,
    published_year integer
);


ALTER TABLE public.books OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 25285)
-- Name: books_book_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.books_book_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.books_book_id_seq OWNER TO postgres;

--
-- TOC entry 5001 (class 0 OID 0)
-- Dependencies: 223
-- Name: books_book_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.books_book_id_seq OWNED BY public.books.book_id;


--
-- TOC entry 230 (class 1259 OID 25342)
-- Name: bookshelves; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.bookshelves (
    shelf_id integer NOT NULL,
    user_id integer NOT NULL,
    book_id integer NOT NULL,
    status public.shelf_status DEFAULT 'Want to Read'::public.shelf_status NOT NULL,
    date_added date DEFAULT CURRENT_DATE
);


ALTER TABLE public.bookshelves OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 25341)
-- Name: bookshelves_shelf_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.bookshelves_shelf_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.bookshelves_shelf_id_seq OWNER TO postgres;

--
-- TOC entry 5002 (class 0 OID 0)
-- Dependencies: 229
-- Name: bookshelves_shelf_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.bookshelves_shelf_id_seq OWNED BY public.bookshelves.shelf_id;


--
-- TOC entry 220 (class 1259 OID 25170)
-- Name: genres; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.genres (
    genre_id integer NOT NULL,
    name character varying(50) NOT NULL,
    description text
);


ALTER TABLE public.genres OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 25169)
-- Name: genres_genre_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.genres_genre_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.genres_genre_id_seq OWNER TO postgres;

--
-- TOC entry 5003 (class 0 OID 0)
-- Dependencies: 219
-- Name: genres_genre_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.genres_genre_id_seq OWNED BY public.genres.genre_id;


--
-- TOC entry 232 (class 1259 OID 25361)
-- Name: quotes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.quotes (
    quote_id integer NOT NULL,
    user_id integer NOT NULL,
    book_id integer NOT NULL,
    quote_text text NOT NULL,
    page_number integer,
    date_added date DEFAULT CURRENT_DATE,
    highlight_color public.highlight_color DEFAULT 'Moonlight silver'::public.highlight_color,
    emotion character varying(50)
);


ALTER TABLE public.quotes OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 25360)
-- Name: quotes_quote_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.quotes_quote_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.quotes_quote_id_seq OWNER TO postgres;

--
-- TOC entry 5004 (class 0 OID 0)
-- Dependencies: 231
-- Name: quotes_quote_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.quotes_quote_id_seq OWNED BY public.quotes.quote_id;


--
-- TOC entry 228 (class 1259 OID 25324)
-- Name: reading_progress; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.reading_progress (
    progress_id integer NOT NULL,
    user_id integer NOT NULL,
    book_id integer NOT NULL,
    percentage_read numeric(5,2) DEFAULT 0,
    start_date date,
    finish_date date
);


ALTER TABLE public.reading_progress OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 25323)
-- Name: reading_progress_progress_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.reading_progress_progress_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.reading_progress_progress_id_seq OWNER TO postgres;

--
-- TOC entry 5005 (class 0 OID 0)
-- Dependencies: 227
-- Name: reading_progress_progress_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.reading_progress_progress_id_seq OWNED BY public.reading_progress.progress_id;


--
-- TOC entry 226 (class 1259 OID 25303)
-- Name: reviews; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.reviews (
    review_id integer NOT NULL,
    user_id integer NOT NULL,
    book_id integer NOT NULL,
    rating integer,
    comment text,
    review_date date DEFAULT CURRENT_DATE,
    CONSTRAINT reviews_rating_check CHECK (((rating >= 1) AND (rating <= 5)))
);


ALTER TABLE public.reviews OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 25302)
-- Name: reviews_review_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.reviews_review_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.reviews_review_id_seq OWNER TO postgres;

--
-- TOC entry 5006 (class 0 OID 0)
-- Dependencies: 225
-- Name: reviews_review_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.reviews_review_id_seq OWNED BY public.reviews.review_id;


--
-- TOC entry 218 (class 1259 OID 25158)
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    user_id integer NOT NULL,
    username character varying(50) NOT NULL,
    email character varying(100) NOT NULL,
    created_at date DEFAULT CURRENT_DATE
);


ALTER TABLE public.users OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 25157)
-- Name: users_user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_user_id_seq OWNER TO postgres;

--
-- TOC entry 5007 (class 0 OID 0)
-- Dependencies: 217
-- Name: users_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_user_id_seq OWNED BY public.users.user_id;


--
-- TOC entry 4786 (class 2604 OID 25199)
-- Name: authors author_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authors ALTER COLUMN author_id SET DEFAULT nextval('public.authors_author_id_seq'::regclass);


--
-- TOC entry 4787 (class 2604 OID 25289)
-- Name: books book_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.books ALTER COLUMN book_id SET DEFAULT nextval('public.books_book_id_seq'::regclass);


--
-- TOC entry 4792 (class 2604 OID 25345)
-- Name: bookshelves shelf_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bookshelves ALTER COLUMN shelf_id SET DEFAULT nextval('public.bookshelves_shelf_id_seq'::regclass);


--
-- TOC entry 4785 (class 2604 OID 25173)
-- Name: genres genre_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.genres ALTER COLUMN genre_id SET DEFAULT nextval('public.genres_genre_id_seq'::regclass);


--
-- TOC entry 4795 (class 2604 OID 25364)
-- Name: quotes quote_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quotes ALTER COLUMN quote_id SET DEFAULT nextval('public.quotes_quote_id_seq'::regclass);


--
-- TOC entry 4790 (class 2604 OID 25327)
-- Name: reading_progress progress_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reading_progress ALTER COLUMN progress_id SET DEFAULT nextval('public.reading_progress_progress_id_seq'::regclass);


--
-- TOC entry 4788 (class 2604 OID 25306)
-- Name: reviews review_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reviews ALTER COLUMN review_id SET DEFAULT nextval('public.reviews_review_id_seq'::regclass);


--
-- TOC entry 4783 (class 2604 OID 25161)
-- Name: users user_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN user_id SET DEFAULT nextval('public.users_user_id_seq'::regclass);


--
-- TOC entry 4984 (class 0 OID 25196)
-- Dependencies: 222
-- Data for Name: authors; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.authors (author_id, name, bio) FROM stdin;
19	J.R.R. Tolkien	Author of epic high fantasy; inspired by myth and nature.
20	Haruki Murakami	Contemporary Japanese novelist, magical realism and introspection.
21	Jane Austen	Classic novelist of manners and romance.
22	Rupi Kaur	Poet known for short, emotional pieces.
23	Kim Namjoon (RM)	RM of BTS — poet, lyricist, and thinker.
24	Chimamanda Ngozi Adichie	Contemporary novelist exploring identity and culture.
\.


--
-- TOC entry 4986 (class 0 OID 25286)
-- Dependencies: 224
-- Data for Name: books; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.books (book_id, title, author_id, genre_id, pages, published_year) FROM stdin;
31	The Fellowship of the Ring	19	16	423	1954
32	Kafka on the Shore	20	17	505	2002
33	Pride and Prejudice	21	18	279	1813
34	Milk and Honey	22	19	201	2014
35	Chosen Essays	24	20	240	2017
36	RM: Selected Thoughts	23	19	120	2020
37	Norwegian Wood	20	17	296	1987
38	The Two Towers	19	16	352	1954
39	Sense and Sensibility	21	18	226	1811
40	Poems for Winter	22	19	95	2019
\.


--
-- TOC entry 4992 (class 0 OID 25342)
-- Dependencies: 230
-- Data for Name: bookshelves; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.bookshelves (shelf_id, user_id, book_id, status, date_added) FROM stdin;
26	26	33	Finished	2025-12-08
27	27	34	Reading	2025-12-08
28	28	32	Want to Read	2025-12-08
29	29	37	Reading	2025-12-08
30	30	36	Finished	2025-12-08
31	31	38	Reading	2025-12-08
32	32	35	Want to Read	2025-12-08
25	25	31	Finished	2025-12-08
\.


--
-- TOC entry 4982 (class 0 OID 25170)
-- Dependencies: 220
-- Data for Name: genres; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.genres (genre_id, name, description) FROM stdin;
16	Fantasy	Fiction with magical or supernatural elements.
17	Contemporary	Modern life fiction.
18	Classic	Classic literature.
19	Poetry	Poetry collections and short verse.
20	Non-Fiction	Essays, memoirs, and factual works.
\.


--
-- TOC entry 4994 (class 0 OID 25361)
-- Dependencies: 232
-- Data for Name: quotes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.quotes (quote_id, user_id, book_id, quote_text, page_number, date_added, highlight_color, emotion) FROM stdin;
1	25	31	All we have to decide is what to do with the time that is given us.	201	2025-12-08	Lorien Gold	contemplative
2	26	33	I declare after all there is no enjoyment like reading!	47	2025-12-08	Elanor Bloom	joyful
3	27	34	You tell me you are sad, and I believe you.	12	2025-12-08	Moonlight silver	sad
4	28	32	Sometimes fate is like a small sandstorm.	88	2025-12-08	Starlit violet	mysterious
5	29	37	I once had a girl, or should I say, she once had me.	3	2025-12-08	Rivendell Sage	nostalgic
6	30	36	You were born to be real, not to be perfect.	14	2025-12-08	Rivendell Sage	comforting
7	31	38	There is some good in this world, and it’s worth fighting for.	320	2025-12-08	Lorien Gold	hopeful
8	32	35	Stories were not just stories for me but maps to myself.	52	2025-12-08	Elanor Bloom	reflective
9	25	36	To love yourself is the beginning of a lifelong romance.	7	2025-12-08	Elanor Bloom	self-love
10	26	36	No one is born beautiful in this judgmental society.	21	2025-12-08	Moonlight silver	comforting
\.


--
-- TOC entry 4990 (class 0 OID 25324)
-- Dependencies: 228
-- Data for Name: reading_progress; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.reading_progress (progress_id, user_id, book_id, percentage_read, start_date, finish_date) FROM stdin;
26	26	33	100.00	2025-10-01	2025-10-20
27	27	34	40.00	2025-11-01	\N
28	28	32	10.00	2025-11-25	\N
29	29	37	75.00	2025-09-10	\N
30	30	36	100.00	2025-05-01	2025-05-07
31	31	38	50.00	2025-08-12	\N
32	32	35	20.00	2025-11-05	\N
25	25	31	100.00	2025-11-20	2025-12-08
\.


--
-- TOC entry 4988 (class 0 OID 25303)
-- Dependencies: 226
-- Data for Name: reviews; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.reviews (review_id, user_id, book_id, rating, comment, review_date) FROM stdin;
25	25	31	5	A magical start — perfect for autumn nights.	2025-12-08
26	26	33	4	Witty and charming.	2025-12-08
27	27	34	3	Short, emotional, mixed feelings.	2025-12-08
28	28	32	5	Strange and lovely.	2025-12-08
29	29	37	4	Nostalgic and bittersweet.	2025-12-08
30	30	36	5	So comforting and wise.	2025-12-08
31	31	38	5	Action and heart.	2025-12-08
32	32	35	4	Thought-provoking essays.	2025-12-08
\.


--
-- TOC entry 4980 (class 0 OID 25158)
-- Dependencies: 218
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (user_id, username, email, created_at) FROM stdin;
25	akylai	akylai@example.com	2025-12-08
26	lera	lera@example.com	2025-12-08
27	atai	atai@example.com	2025-12-08
28	arlen	arlen@example.com	2025-12-08
29	vitalik	vitalik@example.com	2025-12-08
30	bekzhan	bekzhan@example.com	2025-12-08
31	denis	denis@example.com	2025-12-08
32	danil	danil@example.com	2025-12-08
\.


--
-- TOC entry 5008 (class 0 OID 0)
-- Dependencies: 221
-- Name: authors_author_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.authors_author_id_seq', 24, true);


--
-- TOC entry 5009 (class 0 OID 0)
-- Dependencies: 223
-- Name: books_book_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.books_book_id_seq', 40, true);


--
-- TOC entry 5010 (class 0 OID 0)
-- Dependencies: 229
-- Name: bookshelves_shelf_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.bookshelves_shelf_id_seq', 32, true);


--
-- TOC entry 5011 (class 0 OID 0)
-- Dependencies: 219
-- Name: genres_genre_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.genres_genre_id_seq', 20, true);


--
-- TOC entry 5012 (class 0 OID 0)
-- Dependencies: 231
-- Name: quotes_quote_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.quotes_quote_id_seq', 10, true);


--
-- TOC entry 5013 (class 0 OID 0)
-- Dependencies: 227
-- Name: reading_progress_progress_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.reading_progress_progress_id_seq', 32, true);


--
-- TOC entry 5014 (class 0 OID 0)
-- Dependencies: 225
-- Name: reviews_review_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.reviews_review_id_seq', 32, true);


--
-- TOC entry 5015 (class 0 OID 0)
-- Dependencies: 217
-- Name: users_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_user_id_seq', 32, true);


--
-- TOC entry 4810 (class 2606 OID 25203)
-- Name: authors authors_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authors
    ADD CONSTRAINT authors_pkey PRIMARY KEY (author_id);


--
-- TOC entry 4812 (class 2606 OID 25291)
-- Name: books books_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.books
    ADD CONSTRAINT books_pkey PRIMARY KEY (book_id);


--
-- TOC entry 4820 (class 2606 OID 25349)
-- Name: bookshelves bookshelves_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bookshelves
    ADD CONSTRAINT bookshelves_pkey PRIMARY KEY (shelf_id);


--
-- TOC entry 4806 (class 2606 OID 25179)
-- Name: genres genres_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.genres
    ADD CONSTRAINT genres_name_key UNIQUE (name);


--
-- TOC entry 4808 (class 2606 OID 25177)
-- Name: genres genres_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.genres
    ADD CONSTRAINT genres_pkey PRIMARY KEY (genre_id);


--
-- TOC entry 4823 (class 2606 OID 25370)
-- Name: quotes quotes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quotes
    ADD CONSTRAINT quotes_pkey PRIMARY KEY (quote_id);


--
-- TOC entry 4818 (class 2606 OID 25330)
-- Name: reading_progress reading_progress_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reading_progress
    ADD CONSTRAINT reading_progress_pkey PRIMARY KEY (progress_id);


--
-- TOC entry 4816 (class 2606 OID 25312)
-- Name: reviews reviews_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_pkey PRIMARY KEY (review_id);


--
-- TOC entry 4800 (class 2606 OID 25168)
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- TOC entry 4802 (class 2606 OID 25164)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);


--
-- TOC entry 4804 (class 2606 OID 25166)
-- Name: users users_username_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key UNIQUE (username);


--
-- TOC entry 4813 (class 1259 OID 25383)
-- Name: idx_books_title; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_books_title ON public.books USING btree (title);


--
-- TOC entry 4821 (class 1259 OID 25384)
-- Name: idx_quotes_color; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_quotes_color ON public.quotes USING btree (highlight_color);


--
-- TOC entry 4814 (class 1259 OID 25385)
-- Name: idx_reviews_user; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_reviews_user ON public.reviews USING btree (user_id);


--
-- TOC entry 4824 (class 2606 OID 25292)
-- Name: books books_author_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.books
    ADD CONSTRAINT books_author_id_fkey FOREIGN KEY (author_id) REFERENCES public.authors(author_id) ON DELETE CASCADE;


--
-- TOC entry 4825 (class 2606 OID 25297)
-- Name: books books_genre_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.books
    ADD CONSTRAINT books_genre_id_fkey FOREIGN KEY (genre_id) REFERENCES public.genres(genre_id) ON DELETE CASCADE;


--
-- TOC entry 4830 (class 2606 OID 25355)
-- Name: bookshelves bookshelves_book_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bookshelves
    ADD CONSTRAINT bookshelves_book_id_fkey FOREIGN KEY (book_id) REFERENCES public.books(book_id) ON DELETE CASCADE;


--
-- TOC entry 4831 (class 2606 OID 25350)
-- Name: bookshelves bookshelves_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bookshelves
    ADD CONSTRAINT bookshelves_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON DELETE CASCADE;


--
-- TOC entry 4832 (class 2606 OID 25376)
-- Name: quotes quotes_book_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quotes
    ADD CONSTRAINT quotes_book_id_fkey FOREIGN KEY (book_id) REFERENCES public.books(book_id) ON DELETE CASCADE;


--
-- TOC entry 4833 (class 2606 OID 25371)
-- Name: quotes quotes_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quotes
    ADD CONSTRAINT quotes_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON DELETE CASCADE;


--
-- TOC entry 4828 (class 2606 OID 25336)
-- Name: reading_progress reading_progress_book_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reading_progress
    ADD CONSTRAINT reading_progress_book_id_fkey FOREIGN KEY (book_id) REFERENCES public.books(book_id) ON DELETE CASCADE;


--
-- TOC entry 4829 (class 2606 OID 25331)
-- Name: reading_progress reading_progress_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reading_progress
    ADD CONSTRAINT reading_progress_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON DELETE CASCADE;


--
-- TOC entry 4826 (class 2606 OID 25318)
-- Name: reviews reviews_book_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_book_id_fkey FOREIGN KEY (book_id) REFERENCES public.books(book_id) ON DELETE CASCADE;


--
-- TOC entry 4827 (class 2606 OID 25313)
-- Name: reviews reviews_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON DELETE CASCADE;


-- Completed on 2025-12-08 16:08:19

--
-- PostgreSQL database dump complete
--

\unrestrict sNSYmClmhvykV0rHQF5gThVFwI1ClbNYIMIG9fT0s3gCHvyzkJnufZDHeZx51YK


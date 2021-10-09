--
-- PostgreSQL database dump
--

-- Dumped from database version 13.2
-- Dumped by pg_dump version 13.2

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: actors; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.actors (
    actor_id integer NOT NULL,
    first_name text NOT NULL,
    last_name text NOT NULL,
    gender text,
    birth_date date
);


ALTER TABLE public.actors OWNER TO postgres;

--
-- Name: actors_actor_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.actors_actor_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.actors_actor_id_seq OWNER TO postgres;

--
-- Name: actors_actor_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.actors_actor_id_seq OWNED BY public.actors.actor_id;


--
-- Name: awards; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.awards (
    award_id integer NOT NULL,
    award text NOT NULL
);


ALTER TABLE public.awards OWNER TO postgres;

--
-- Name: awards_award_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.awards_award_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.awards_award_id_seq OWNER TO postgres;

--
-- Name: awards_award_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.awards_award_id_seq OWNED BY public.awards.award_id;


--
-- Name: directors; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.directors (
    director_id integer NOT NULL,
    first_name text NOT NULL,
    last_name text NOT NULL,
    gender text,
    birth_date date
);


ALTER TABLE public.directors OWNER TO postgres;

--
-- Name: directors_director_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.directors_director_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.directors_director_id_seq OWNER TO postgres;

--
-- Name: directors_director_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.directors_director_id_seq OWNED BY public.directors.director_id;


--
-- Name: formats; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.formats (
    format_id integer NOT NULL,
    extension text NOT NULL
);


ALTER TABLE public.formats OWNER TO postgres;

--
-- Name: formats_format_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.formats_format_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.formats_format_id_seq OWNER TO postgres;

--
-- Name: formats_format_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.formats_format_id_seq OWNED BY public.formats.format_id;


--
-- Name: genres; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.genres (
    genre_id integer NOT NULL,
    genre text NOT NULL,
    subgenre text
);


ALTER TABLE public.genres OWNER TO postgres;

--
-- Name: genres_genre_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.genres_genre_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.genres_genre_id_seq OWNER TO postgres;

--
-- Name: genres_genre_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.genres_genre_id_seq OWNED BY public.genres.genre_id;


--
-- Name: movie_ratings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.movie_ratings (
    user_id integer NOT NULL,
    movie_id integer NOT NULL,
    rating numeric NOT NULL,
    rating_date timestamp without time zone
);


ALTER TABLE public.movie_ratings OWNER TO postgres;

--
-- Name: movies; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.movies (
    movie_id integer NOT NULL,
    title text NOT NULL,
    year integer NOT NULL,
    length_hour text NOT NULL,
    length_min text NOT NULL,
    studio text,
    format_id integer NOT NULL,
    resolution_id integer NOT NULL,
    rating_id integer NOT NULL,
    cover text
);


ALTER TABLE public.movies OWNER TO postgres;

--
-- Name: movies_actors; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.movies_actors (
    actor_id integer NOT NULL,
    movie_id integer NOT NULL
);


ALTER TABLE public.movies_actors OWNER TO postgres;

--
-- Name: movies_awards; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.movies_awards (
    award_id integer NOT NULL,
    movie_id integer NOT NULL
);


ALTER TABLE public.movies_awards OWNER TO postgres;

--
-- Name: movies_directors; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.movies_directors (
    director_id integer NOT NULL,
    movie_id integer NOT NULL
);


ALTER TABLE public.movies_directors OWNER TO postgres;

--
-- Name: movies_genres; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.movies_genres (
    genre_id integer NOT NULL,
    movie_id integer NOT NULL
);


ALTER TABLE public.movies_genres OWNER TO postgres;

--
-- Name: movies_movie_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.movies_movie_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.movies_movie_id_seq OWNER TO postgres;

--
-- Name: movies_movie_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.movies_movie_id_seq OWNED BY public.movies.movie_id;


--
-- Name: movies_trailers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.movies_trailers (
    trailer_id integer NOT NULL,
    movie_id integer NOT NULL
);


ALTER TABLE public.movies_trailers OWNER TO postgres;

--
-- Name: mpa_ratings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.mpa_ratings (
    rating_id integer NOT NULL,
    rating text NOT NULL,
    description_short text NOT NULL,
    description_detailed text NOT NULL
);


ALTER TABLE public.mpa_ratings OWNER TO postgres;

--
-- Name: mpa_ratings_rating_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.mpa_ratings_rating_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.mpa_ratings_rating_id_seq OWNER TO postgres;

--
-- Name: mpa_ratings_rating_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.mpa_ratings_rating_id_seq OWNED BY public.mpa_ratings.rating_id;


--
-- Name: resolutions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resolutions (
    resolution_id integer NOT NULL,
    resolution text NOT NULL,
    pixel_size text NOT NULL,
    aspect_ratio text NOT NULL,
    num_p text
);


ALTER TABLE public.resolutions OWNER TO postgres;

--
-- Name: resolutions_resolution_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.resolutions_resolution_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.resolutions_resolution_id_seq OWNER TO postgres;

--
-- Name: resolutions_resolution_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.resolutions_resolution_id_seq OWNED BY public.resolutions.resolution_id;


--
-- Name: trailers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.trailers (
    trailer_id integer NOT NULL,
    trailer_url text NOT NULL,
    trailer_name text NOT NULL
);


ALTER TABLE public.trailers OWNER TO postgres;

--
-- Name: trailers_trailer_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.trailers_trailer_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.trailers_trailer_id_seq OWNER TO postgres;

--
-- Name: trailers_trailer_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.trailers_trailer_id_seq OWNED BY public.trailers.trailer_id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    user_id integer NOT NULL,
    username text NOT NULL,
    password text NOT NULL,
    email character varying(320) NOT NULL,
    cell_phone character varying(24),
    first_name text,
    last_name text,
    gender text,
    birth_date date,
    profile_pic text,
    age integer NOT NULL
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: users_user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_user_id_seq OWNER TO postgres;

--
-- Name: users_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_user_id_seq OWNED BY public.users.user_id;


--
-- Name: actors actor_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.actors ALTER COLUMN actor_id SET DEFAULT nextval('public.actors_actor_id_seq'::regclass);


--
-- Name: awards award_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.awards ALTER COLUMN award_id SET DEFAULT nextval('public.awards_award_id_seq'::regclass);


--
-- Name: directors director_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directors ALTER COLUMN director_id SET DEFAULT nextval('public.directors_director_id_seq'::regclass);


--
-- Name: formats format_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.formats ALTER COLUMN format_id SET DEFAULT nextval('public.formats_format_id_seq'::regclass);


--
-- Name: genres genre_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.genres ALTER COLUMN genre_id SET DEFAULT nextval('public.genres_genre_id_seq'::regclass);


--
-- Name: movies movie_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.movies ALTER COLUMN movie_id SET DEFAULT nextval('public.movies_movie_id_seq'::regclass);


--
-- Name: mpa_ratings rating_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mpa_ratings ALTER COLUMN rating_id SET DEFAULT nextval('public.mpa_ratings_rating_id_seq'::regclass);


--
-- Name: resolutions resolution_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resolutions ALTER COLUMN resolution_id SET DEFAULT nextval('public.resolutions_resolution_id_seq'::regclass);


--
-- Name: trailers trailer_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.trailers ALTER COLUMN trailer_id SET DEFAULT nextval('public.trailers_trailer_id_seq'::regclass);


--
-- Name: users user_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN user_id SET DEFAULT nextval('public.users_user_id_seq'::regclass);


--
-- Data for Name: actors; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.actors (actor_id, first_name, last_name, gender, birth_date) FROM stdin;
1	Tom	Hanks	\N	\N
2	Tim	Allen	\N	\N
3	Don	Rickles	\N	\N
4	Jim	Varney	\N	\N
5	Wallace	Shawn	\N	\N
6	John	Ratzenberger	\N	\N
7	Annie	Potts	\N	\N
8	John	Morris	\N	\N
9	Eric	von Detten	\N	\N
\.


--
-- Data for Name: awards; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.awards (award_id, award) FROM stdin;
1	Best Original Screenplay
2	Best Original Song
3	Best Original Score
\.


--
-- Data for Name: directors; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.directors (director_id, first_name, last_name, gender, birth_date) FROM stdin;
1	John	Lasseter	\N	\N
\.


--
-- Data for Name: formats; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.formats (format_id, extension) FROM stdin;
1	MP4
2	MOV
3	WMV
4	AVI
5	FLV
6	F4V
7	SWF
8	MKV
9	WEBM
10	HTML5
11	MPEG-2
\.


--
-- Data for Name: genres; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.genres (genre_id, genre, subgenre) FROM stdin;
1	Action	\N
2	Action	Epic Movies
3	Action	Spy Movies
4	Action	Disaster Movies
5	Action	Superhero Movies
6	Action	Thriller Movies
7	Action	Martial Arts Movies
8	Action	Video Game Movies
9	Animation	\N
10	Animation	Traditional
11	Animation	Rotoscoping
12	Animation	Puppet
13	Animation	Claymation
14	Animation	Live/Animation
15	Animation	2D CGI
16	Animation	3D CGI
17	Crime	\N
18	Crime	Detective Movies
19	Crime	Gangster Movies
20	Crime	Legal Thrillers
21	Comedy	\N
22	Comedy	Anarchic
23	Comedy	Bathroom
24	Comedy	Parody
25	Comedy	Sex
26	Comedy	Straight
27	Drama	\N
28	Drama	Docudrama
29	Drama	Comedy Drama
30	Drama	Light Drama
31	Drama	Satire
32	Fantasy	\N
33	Fantasy	Urban Fantasy
34	Fantasy	Dark Fantasy
35	Fantasy	Fairy Tale
36	Fantasy	Epic Fantasy
37	Fantasy	Heroic Fantasy
38	Fantasy	Sword/Sorcery
39	Historical	\N
40	Historical	Biopic
41	Historical	Historical Drama
42	Historical	Biblical
43	Historical	Period
44	Historical	Alternate History
45	Horror	\N
46	Horror	Slasher
47	Horror	Splatter
48	Horror	Pyschological Horror
49	Horror	Survival
50	Horror	Found Footage
51	Horror	Paranormal/Occult
52	Horror	Monster
53	Romance	\N
54	Romance	Romantic comedy
55	Romance	Historical Romance
56	Romance	Romantic Action
57	Romance	Romantic Thriller
58	Romance	Chick flick
59	Romance	Romantic Drama
60	Sci-Fi	\N
61	Sci-Fi	Hard
62	Sci-Fi	Apocalyptic
63	Sci-Fi	Future Noir
64	Sci-Fi	Space Opera
65	Sci-Fi	Military
66	Sci-Fi	Punk
67	Sci-Fi	Speculative
68	Thriller	\N
69	Thriller	Action Thriller
70	Thriller	Comedy Thriller
71	Thriller	Conspiracy
72	Thriller	Crime Thriller
73	Thriller	Erotic
74	Thriller	Pandemic
75	Western	\N
76	Western	Epic Western
77	Western	Outlaw Western
78	Western	Marshall Western
79	Western	Revisionist Western
80	Western	Revenge Western
81	Western	Empire Western
\.


--
-- Data for Name: movie_ratings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.movie_ratings (user_id, movie_id, rating, rating_date) FROM stdin;
2	1	7	\N
3	1	8	\N
\.


--
-- Data for Name: movies; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.movies (movie_id, title, year, length_hour, length_min, studio, format_id, resolution_id, rating_id, cover) FROM stdin;
1	Toy Story	1995	1	21	Pixar	1	3	1	\N
\.


--
-- Data for Name: movies_actors; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.movies_actors (actor_id, movie_id) FROM stdin;
1	1
2	1
3	1
4	1
5	1
6	1
7	1
8	1
9	1
\.


--
-- Data for Name: movies_awards; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.movies_awards (award_id, movie_id) FROM stdin;
1	1
2	1
3	1
\.


--
-- Data for Name: movies_directors; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.movies_directors (director_id, movie_id) FROM stdin;
1	1
\.


--
-- Data for Name: movies_genres; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.movies_genres (genre_id, movie_id) FROM stdin;
16	1
21	1
32	1
\.


--
-- Data for Name: movies_trailers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.movies_trailers (trailer_id, movie_id) FROM stdin;
1	1
\.


--
-- Data for Name: mpa_ratings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.mpa_ratings (rating_id, rating, description_short, description_detailed) FROM stdin;
1	G	General Audiences	All ages admitted. Nothing that would offend parents for viewing by children.
2	PG	Parental Guidance Suggested	Some material may not be suitable for children. Parents urged to give "parental guidance". May contain some material parents might not like for their young children.
3	PG-13	Parents Strongly Cautioned	Some material may be inappropriate for children under 13. Parents are urged to be cautious. Some material may be inappropriate for pre-teenagers.
4	R	Restricted	Under 17 requires accompanying parent or adult guardian. Contains some adult material. Parents are urged to learn more about the film before taking their young children with them.
5	NC-17	Adults Only	No One 17 and Under Admitted. Clearly adult. Children are not admitted.
6	X	Adult Content	Contains an accumulation of brutal or sexually connotative language or explicit sex, or excessive and sadistic violence
\.


--
-- Data for Name: resolutions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resolutions (resolution_id, resolution, pixel_size, aspect_ratio, num_p) FROM stdin;
1	SD (Standard Definition)	640 x 480	4:3	480p
2	HD (High Definition)	1280 x 720	16:9	720p
3	Full HD (FHD)	1920 x 1080	16:9	1080p
4	QHD (Quad HD)	2560 x 1440	16:9	1440p
5	2K	2048 x 1080	1:1.77	1080p
6	4K (Ultra HD)	3840 x 2160	1:1.9	2160p
7	8K (Full Ultra HD)	7680 x 4320	16:9	4320p
\.


--
-- Data for Name: trailers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.trailers (trailer_id, trailer_url, trailer_name) FROM stdin;
1	https://youtu.be/v-PjgYDrg70	Toy Story
2	https://youtu.be/mE35XQFxbeo	A Bugs Life
3	https://youtu.be/xNWSGRD5CzU	Toy Story 2
4	https://youtu.be/CGbgaHoapFM	Monsters, Inc.
5	https://youtu.be/9oQ628Seb9w	Finding Nemo
6	https://youtu.be/-UaGUdNJdRQ	The Incredibles
7	https://youtu.be/W_H7_tDHFE8	Cars
8	https://youtu.be/NgsQ8mVkN8w	Ratatouille
9	https://youtu.be/CZ1CATNbXg0	WALL-E
10	https://youtu.be/AkdXuDAP2Ts	Up
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (user_id, username, password, email, cell_phone, first_name, last_name, gender, birth_date, profile_pic, age) FROM stdin;
2	user1	passwordHappy	ed@gmail.com	\N	\N	\N	\N	\N	\N	34
3	user2	superPassword	bob@gmail.com	\N	\N	\N	\N	\N	\N	38
\.


--
-- Name: actors_actor_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.actors_actor_id_seq', 9, true);


--
-- Name: awards_award_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.awards_award_id_seq', 3, true);


--
-- Name: directors_director_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.directors_director_id_seq', 1, true);


--
-- Name: formats_format_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.formats_format_id_seq', 11, true);


--
-- Name: genres_genre_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.genres_genre_id_seq', 81, true);


--
-- Name: movies_movie_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.movies_movie_id_seq', 1, false);


--
-- Name: mpa_ratings_rating_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.mpa_ratings_rating_id_seq', 1, false);


--
-- Name: resolutions_resolution_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.resolutions_resolution_id_seq', 1, false);


--
-- Name: trailers_trailer_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.trailers_trailer_id_seq', 1, false);


--
-- Name: users_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_user_id_seq', 3, true);


--
-- Name: actors actors_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.actors
    ADD CONSTRAINT actors_pkey PRIMARY KEY (actor_id);


--
-- Name: awards awards_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.awards
    ADD CONSTRAINT awards_pkey PRIMARY KEY (award_id);


--
-- Name: directors directors_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directors
    ADD CONSTRAINT directors_pkey PRIMARY KEY (director_id);


--
-- Name: formats formats_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.formats
    ADD CONSTRAINT formats_pkey PRIMARY KEY (format_id);


--
-- Name: genres genres_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.genres
    ADD CONSTRAINT genres_pkey PRIMARY KEY (genre_id);


--
-- Name: movie_ratings movie_ratings_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.movie_ratings
    ADD CONSTRAINT movie_ratings_pkey PRIMARY KEY (user_id, movie_id);


--
-- Name: movies_actors movies_actors_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.movies_actors
    ADD CONSTRAINT movies_actors_pkey PRIMARY KEY (actor_id, movie_id);


--
-- Name: movies_awards movies_awards_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.movies_awards
    ADD CONSTRAINT movies_awards_pkey PRIMARY KEY (award_id, movie_id);


--
-- Name: movies_directors movies_directors_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.movies_directors
    ADD CONSTRAINT movies_directors_pkey PRIMARY KEY (director_id, movie_id);


--
-- Name: movies_genres movies_genres_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.movies_genres
    ADD CONSTRAINT movies_genres_pkey PRIMARY KEY (genre_id, movie_id);


--
-- Name: movies movies_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.movies
    ADD CONSTRAINT movies_pkey PRIMARY KEY (movie_id);


--
-- Name: movies_trailers movies_trailers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.movies_trailers
    ADD CONSTRAINT movies_trailers_pkey PRIMARY KEY (trailer_id, movie_id);


--
-- Name: mpa_ratings mpa_ratings_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mpa_ratings
    ADD CONSTRAINT mpa_ratings_pkey PRIMARY KEY (rating_id);


--
-- Name: resolutions resolutions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resolutions
    ADD CONSTRAINT resolutions_pkey PRIMARY KEY (resolution_id);


--
-- Name: trailers trailers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.trailers
    ADD CONSTRAINT trailers_pkey PRIMARY KEY (trailer_id);


--
-- Name: users users_cell_phone_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_cell_phone_key UNIQUE (cell_phone);


--
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);


--
-- Name: users users_username_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key UNIQUE (username);


--
-- Name: movies_actors fk_actor; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.movies_actors
    ADD CONSTRAINT fk_actor FOREIGN KEY (actor_id) REFERENCES public.actors(actor_id);


--
-- Name: movies_awards fk_award; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.movies_awards
    ADD CONSTRAINT fk_award FOREIGN KEY (award_id) REFERENCES public.awards(award_id);


--
-- Name: movies_directors fk_director; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.movies_directors
    ADD CONSTRAINT fk_director FOREIGN KEY (director_id) REFERENCES public.directors(director_id);


--
-- Name: movies_genres fk_genre; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.movies_genres
    ADD CONSTRAINT fk_genre FOREIGN KEY (genre_id) REFERENCES public.genres(genre_id);


--
-- Name: movies_trailers fk_movie; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.movies_trailers
    ADD CONSTRAINT fk_movie FOREIGN KEY (movie_id) REFERENCES public.movies(movie_id);


--
-- Name: movies_actors fk_movie; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.movies_actors
    ADD CONSTRAINT fk_movie FOREIGN KEY (movie_id) REFERENCES public.movies(movie_id);


--
-- Name: movies_genres fk_movie; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.movies_genres
    ADD CONSTRAINT fk_movie FOREIGN KEY (movie_id) REFERENCES public.movies(movie_id);


--
-- Name: movies_awards fk_movie; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.movies_awards
    ADD CONSTRAINT fk_movie FOREIGN KEY (movie_id) REFERENCES public.movies(movie_id);


--
-- Name: movies_directors fk_movie; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.movies_directors
    ADD CONSTRAINT fk_movie FOREIGN KEY (movie_id) REFERENCES public.movies(movie_id);


--
-- Name: movie_ratings fk_movie; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.movie_ratings
    ADD CONSTRAINT fk_movie FOREIGN KEY (movie_id) REFERENCES public.movies(movie_id);


--
-- Name: movies fk_movie_format; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.movies
    ADD CONSTRAINT fk_movie_format FOREIGN KEY (format_id) REFERENCES public.formats(format_id);


--
-- Name: movies fk_movie_rating; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.movies
    ADD CONSTRAINT fk_movie_rating FOREIGN KEY (rating_id) REFERENCES public.mpa_ratings(rating_id);


--
-- Name: movies fk_movie_resolution; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.movies
    ADD CONSTRAINT fk_movie_resolution FOREIGN KEY (resolution_id) REFERENCES public.resolutions(resolution_id);


--
-- Name: movies_trailers fk_trailer; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.movies_trailers
    ADD CONSTRAINT fk_trailer FOREIGN KEY (trailer_id) REFERENCES public.trailers(trailer_id);


--
-- Name: movie_ratings fk_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.movie_ratings
    ADD CONSTRAINT fk_user FOREIGN KEY (user_id) REFERENCES public.users(user_id);


--
-- PostgreSQL database dump complete
--


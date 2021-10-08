---
--- movie_viewer
---

DROP DATABASE IF EXISTS movies;
CREATE DATABASE movies;
\c movies

DROP TABLE IF EXISTS trailers;
DROP TABLE IF EXISTS movies_trailers;
DROP TABLE IF EXISTS formats;
DROP TABLE IF EXISTS resolutions;
DROP TABLE IF EXISTS actors;
DROP TABLE IF EXISTS movies_actors;
DROP TABLE IF EXISTS genres;
DROP TABLE IF EXISTS movies_genres;
DROP TABLE IF EXISTS awards;
DROP TABLE IF EXISTS movies_awards;
DROP TABLE IF EXISTS directors;
DROP TABLE IF EXISTS movies_directors;
DROP TABLE IF EXISTS movies;
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS movies_ratings;

--
-- Name: trailers; Type: TABLE; Schema: public; Owner: Amanda_Shuman; Tablespace: 
--
CREATE TABLE trailers (
    trailer_id SERIAL PRIMARY KEY,
    trailer_url TEXT NOT NULL
);

--
-- Name: movies_trailers; Type: TABLE; Schema: public; Owner: Amanda_Shuman; Tablespace: 
--
CREATE TABLE movies_trailers (
    trailer_id INT NOT NULL,
    movie_id INT NOT NULL,
    PRIMARY KEY(trailer_id, movie_id),
    CONSTRAINT fk_trailer FOREIGN KEY (trailer_id) REFERENCES trailers(trailer_id),
    CONSTRAINT fk_movie FOREIGN KEY (movie_id) REFERENCES movies(movie_id)
);

--
-- Name: formats; Type: TABLE; Schema: public; Owner: Amanda_Shuman; Tablespace: 
--
CREATE TABLE formats (
    format_id SERIAL PRIMARY KEY,
    extension TEXT NOT NULL,
);

--
-- Name: resolutions; Type: TABLE; Schema: public; Owner: Amanda_Shuman; Tablespace: 
--
CREATE TABLE resolutions (
    resolution_id SERIAL PRIMARY KEY,
    resolution TEXT NOT NULL,
    pixel_size TEXT NOT NULL,
    aspect_ratio TEXT NOT NULL,
    num_p TEXT
);

--
-- Name: actors; Type: TABLE; Schema: public; Owner: Amanda_Shuman; Tablespace: 
--
CREATE TABLE actors (
    actor_id SERIAL PRIMARY KEY,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    gender TEXT,
    birth_date DATE
);

--
-- Name: movies_actors; Type: TABLE; Schema: public; Owner: Amanda_Shuman; Tablespace: 
--
CREATE TABLE movies_actors (
    actor_id INT NOT NULL,
    movie_id INT NOT NULL,
    PRIMARY KEY(actor_id, movie_id),
    CONSTRAINT fk_actor FOREIGN KEY (actor_id) REFERENCES actors(actor_id),
    CONSTRAINT fk_movie FOREIGN KEY (movie_id) REFERENCES movies(movie_id)
);

--
-- Name: genres; Type: TABLE; Schema: public; Owner: Amanda_Shuman; Tablespace: 
--
CREATE TABLE genres (
    genre_id SERIAL PRIMARY KEY,
    genre TEXT NOT NULL,
    subgenre TEXT
);

--
-- Name: awards; Type: TABLE; Schema: public; Owner: Amanda_Shuman; Tablespace: 
--


--
-- Name: directors; Type: TABLE; Schema: public; Owner: Amanda_Shuman; Tablespace: 
--


--
-- Name: movies; Type: TABLE; Schema: public; Owner: Amanda_Shuman; Tablespace: 
--
CREATE TABLE movies (
    movie_id SERIAL PRIMARY KEY,
    title TEXT NOT NULL,
    year INT NOT NULL,
    length_hour TEXT NOT NULL,
    length_min TEXT NOT NULL,
    studio TEXT,
    format_id INT NOT NULL,
    CONSTRAINT fk_movie_format FOREIGN KEY (format_id) REFERENCES formats (format_id)
);

--
-- Name: users; Type: TABLE; Schema: public; Owner: Amanda_Shuman; Tablespace: 
--

-- Insert records
INSERT INTO formats (extension) VALUES
('MP4'), ('MOV'), ('WMV'), ('AVI'), ('FLV'), ('F4V'), ('SWF'), ('MKV'), ('WEBM'), ('HTML5'), ('MPEG-2');

INSERT INTO resolutions VALUES
('SD (Standard Definition)', '640 x 480', '4:3', '480p'),
('HD (High Definition)', '1280 x 720', '16:9', '720p'),
('Full HD (FHD)', '1920 x 1080', '16:9', '1080p'),
('QHD (Quad HD)', '2560 x 1440', '16:9', '1440p'),
('2K', '2048 x 1080', '1:1.77', '1080p'),
('4K (Ultra HD)', '3840 x 2160', '1:1.9', '2160p'),
('8K (Full Ultra HD)', '7680 x 4320', '16:9', '4320p')

-- Used site https://www.nyfa.edu/student-resources/ultimate-list-of-film-sub-genres/
INSERT INTO genres VALUES
('Action', NULL),
    ('Action', 'Epic Movies'),  -- Ben Hur / Gone with the Wind
    ('Action', 'Spy Movies'),  -- Mission Impossible
    ('Action', 'Disaster Movies'),  -- Day after Tomorrow
    ('Action', 'Superhero Movies'),  -- Hancock
    ('Action', 'Thriller Movies'),  -- Die Hard
    ('Action', 'Martial Arts Movies'),  -- The Karate Kid
    ('Action', 'Video Game Movies'),  -- Resident Evil
('Animation', NULL),
    ('Animation', 'Traditional'),  --Pinocchio/ Spirited Away
    ('Animation', 'Rotoscoping'), -- A Scanner Darkly
    ('Animation', 'Puppet'),  -- Coraline, Nightmare Before Christmas
    ('Animation', 'Claymation'),  -- Wallace and Grommit
    ('Animation', 'Live/Animation'),  -- Space Jam, Osmosis Jones
    ('Animation', '2D CGI'),  -- Home on the Range
    ('Animation', '3D CGI'),  -- Frozen, Toy Story, Up
('Crime', NULL),
    ('Crime', 'Detective Movies'),  -- Lady on a Train
    ('Crime', 'Gangster Movies'),  -- Gangs of New York
    ('Crime', 'Legal Thrillers'),  -- A Few Good Men
('Comedy', NULL),
    ('Comedy', 'Anarchic'),  -- Monty Python
    ('Comedy', 'Bathroom'),  -- American Pie
    ('Comedy', 'Parody'),  -- Scary Movie
    ('Comedy', 'Sex'),  -- Knocked Up
    ('Comedy', 'Straight'),  -- Mrs. Doubtfire
('Drama', NULL),
    ('Drama', 'Docudrama'),  --  Zodiac
    ('Drama', 'Comedy Drama'),  -- The Truman Show
    ('Drama', 'Light Drama'),  -- The Help/ Terminal
    ('Drama', 'Satire'),  -- Idiocracy
('Fantasy', NULL),
    ('Fantasy', 'Urban Fantasy'), -- Ghostbusters / Constantine
    ('Fantasy', 'Dark Fantasy'),  -- Pan's Labyrinth
    ('Fantasy', 'Fairy Tale'),  -- Maleficient
    ('Fantasy', 'Epic Fantasy'),  --Lord of the Rings / Narnia
    ('Fantasy', 'Heroic Fantasy'),  -- Dark Crystal
    ('Fantasy', 'Sword/Sorcery'), -- Conan the Barbarian
('Historical', NULL),
    ('Historical', 'Biopic'),  -- Lincoln
    ('Historical', 'Historical Drama'),  --Titanic / Braveheart
    ('Historical', 'Biblical'),  --The Ten Commandments / Ben Hur
    ('Historical', 'Period'),  -- Anna and the King
    ('Historical', 'Alternate History'),  --Timequest
('Horror', NULL),
    ('Horror', 'Slasher'),  --Nightmare on Elm Street / Scream
    ('Horror', 'Splatter'),  -- Saw
    ('Horror', 'Pyschological Horror'),  --Silence of the Lambs
    ('Horror', 'Survival'),  -- 28 Days Later
    ('Horror', 'Found Footage'),  -- Blair Witch Project
    ('Horror', 'Paranormal/Occult'),  --Paranormal Activity/ Exorcist
    ('Horror', 'Monster'),  -- Cloverfield
('Romance', NULL), 
    ('Romance', 'Romantic comedy'),  --Love Actually
    ('Romance', 'Historical Romance'),  -- Pride and Prejudice 
    ('Romance', 'Romantic Action'),  -- A Knight's Tale
    ('Romance', 'Romantic Thriller'),  --Mr and Mrs Smith
    ('Romance', 'Chick flick'),  --The Notebook
    ('Romance', 'Romantic Drama'),  --Casablanca
('Sci-Fi', NULL),
    ('Sci-Fi', 'Hard'),  -- Jurassic Park / Gravity
    ('Sci-Fi', 'Apocalyptic'),  -- Planet of the Apes
    ('Sci-Fi', 'Future Noir'),  -- Terminator/ Blade Runner
    ('Sci-Fi', 'Space Opera'),  -- Star Wars
    ('Sci-Fi', 'Military'),  -- Starship Troopers
    ('Sci-Fi', 'Punk'),  -- Total Recall, Demolition Man
    ('Sci-Fi', 'Speculative'),  -- Interstellar
('Thriller', NULL),
    ('Thriller', 'Action Thriller'),  -- Taken
    ('Thriller', 'Comedy Thriller'),  -- Mr and Mrs Smith
    ('Thriller', 'Conspiracy'),  -- The Da Vinci Code
    ('Thriller', 'Crime Thriller'),  -- Entrapment
    ('Thriller', 'Erotic'),  -- Basic Instinct
    ('Thriller', 'Pandemic'),  -- Contagin, Outbreak
('Western', NULL),
    ('Western', 'Epic Western'),  -- The Good, The Bad, The Ugly
    ('Western', 'Outlaw Western'),  -- Butch Cassidy and the Sundance Kid
    ('Western', 'Marshall Western'),  -- The Lone Ranger
    ('Western', 'Revisionist Western'),  -- Dances with Wolves
    ('Western', 'Revenge Western'),  -- High Plains Drifter
    ('Western', 'Empire Western')  -- There will be blood
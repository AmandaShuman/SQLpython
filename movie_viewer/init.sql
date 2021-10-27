---
--- movie_viewer
---

DROP DATABASE IF EXISTS movie_viewer;
CREATE DATABASE movie_viewer;
--\c movies

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
DROP TABLE IF EXISTS MPA_ratings;

--
-- Name: trailers; Type: TABLE; Schema: public; Owner: Amanda_Shuman; Tablespace: 
--
CREATE TABLE trailers (
    trailer_id SERIAL PRIMARY KEY,
    trailer_url TEXT NOT NULL,
    trailer_name TEXT NOT NULL
);

--
-- Name: formats; Type: TABLE; Schema: public; Owner: Amanda_Shuman; Tablespace: 
--
CREATE TABLE formats (
    format_id SERIAL PRIMARY KEY,
    extension TEXT NOT NULL
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
    birth_date DATE,
    picture TEXT
);

--
-- Name: genres; Type: TABLE; Schema: public; Owner: Amanda_Shuman; Tablespace: 
--
CREATE TABLE genres (
    genre_id SERIAL PRIMARY KEY,
    genre TEXT NOT NULL,
    subgenre TEXT,
    description TEXT
);

--
-- Name: awards; Type: TABLE; Schema: public; Owner: Amanda_Shuman; Tablespace: 
--
CREATE TABLE awards (
    award_id SERIAL PRIMARY KEY,
    award TEXT NOT NULL
);

--
-- Name: directors; Type: TABLE; Schema: public; Owner: Amanda_Shuman; Tablespace: 
--
CREATE TABLE directors (
    director_id SERIAL PRIMARY KEY,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    gender TEXT,
    birth_date DATE,
    picture TEXT
);

--
-- Name: users; Type: TABLE; Schema: public; Owner: Amanda_Shuman; Tablespace: 
--
CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
    username TEXT UNIQUE NOT NULL,
    password TEXT NOT NULL,
    email character varying(320) UNIQUE NOT NULL,
    cell_phone character varying(24) UNIQUE,
    first_name TEXT,
    last_name TEXT,
    gender TEXT,
    birth_date DATE,
    profile_pic TEXT,
    age INT NOT NULL
);

--
-- Name: MPA_ratings; Type: TABLE; Schema: public; Owner: Amanda_Shuman; Tablespace: 
--
CREATE TABLE MPA_ratings (
    rating_id SERIAL PRIMARY KEY,
    rating TEXT NOT NULL,
    description_short TEXT NOT NULL,
    description_detailed TEXT NOT NULL
);

--
-- Name: movies; Type: TABLE; Schema: public; Owner: Amanda_Shuman; Tablespace: 
--
CREATE TABLE movies (
    movie_id SERIAL PRIMARY KEY,
    title TEXT NOT NULL,
    year INT NOT NULL,
    length_min TEXT NOT NULL,
    studio TEXT,
    format_id INT NOT NULL,
    resolution_id INT NOT NULL,
    rating_id INT,
    cover TEXT,
    movie TEXT NOT NULL,
    movie_subtitles TEXT,
    summary TEXT,
    CONSTRAINT fk_movie_format FOREIGN KEY (format_id) REFERENCES formats (format_id) ON DELETE CASCADE,
    CONSTRAINT fk_movie_resolution FOREIGN KEY (resolution_id) REFERENCES resolutions(resolution_id) ON DELETE CASCADE,
    CONSTRAINT fk_movie_rating FOREIGN KEY (rating_id) REFERENCES MPA_ratings (rating_id) ON DELETE CASCADE
);

--
-- Name: movies_trailers; Type: TABLE; Schema: public; Owner: Amanda_Shuman; Tablespace: 
--
CREATE TABLE movies_trailers (
    trailer_id INT NOT NULL,
    movie_id INT NOT NULL,
    PRIMARY KEY(trailer_id, movie_id),
    CONSTRAINT fk_trailer FOREIGN KEY (trailer_id) REFERENCES trailers(trailer_id) ON DELETE CASCADE,
    CONSTRAINT fk_movie FOREIGN KEY (movie_id) REFERENCES movies(movie_id) ON DELETE CASCADE
);

--
-- Name: movies_actors; Type: TABLE; Schema: public; Owner: Amanda_Shuman; Tablespace: 
--
CREATE TABLE movies_actors (
    actor_id INT NOT NULL,
    movie_id INT NOT NULL,
    PRIMARY KEY(actor_id, movie_id),
    CONSTRAINT fk_actor FOREIGN KEY (actor_id) REFERENCES actors(actor_id) ON DELETE CASCADE,
    CONSTRAINT fk_movie FOREIGN KEY (movie_id) REFERENCES movies(movie_id) ON DELETE CASCADE
);

--
-- Name: movie-genres; Type: TABLE; Schema: public; Owner: Amanda_Shuman; Tablespace: 
--
CREATE TABLE movies_genres (
    genre_id INT NOT NULL,
    movie_id INT NOT NULL,
    PRIMARY KEY(genre_id, movie_id),
    CONSTRAINT fk_genre FOREIGN KEY (genre_id) REFERENCES genres(genre_id) ON DELETE CASCADE,
    CONSTRAINT fk_movie FOREIGN KEY (movie_id) REFERENCES movies(movie_id) ON DELETE CASCADE
);

--
-- Name: movie-awards; Type: TABLE; Schema: public; Owner: Amanda_Shuman; Tablespace: 
--
CREATE TABLE movies_awards (
    award_id INT NOT NULL,
    movie_id INT NOT NULL,
    PRIMARY KEY(award_id, movie_id),
    CONSTRAINT fk_award FOREIGN KEY (award_id) REFERENCES awards(award_id) ON DELETE CASCADE,
    CONSTRAINT fk_movie FOREIGN KEY (movie_id) REFERENCES movies(movie_id) ON DELETE CASCADE
);

--
-- Name: movie_directors; Type: TABLE; Schema: public; Owner: Amanda_Shuman; Tablespace: 
--
CREATE TABLE movies_directors (
    director_id INT NOT NULL,
    movie_id INT NOT NULL,
    PRIMARY KEY(director_id, movie_id),
    CONSTRAINT fk_director FOREIGN KEY (director_id) REFERENCES directors(director_id) ON DELETE CASCADE,
    CONSTRAINT fk_movie FOREIGN KEY (movie_id) REFERENCES movies(movie_id) ON DELETE CASCADE
);

--
-- Name: movie_ratings; Type: TABLE; Schema: public; Owner: Amanda_Shuman; Tablespace: 
--
CREATE TABLE movie_ratings (
    user_id INT NOT NULL,
    movie_id INT NOT NULL,
    rating NUMERIC NOT NULL,
    rating_date TIMESTAMP,
    PRIMARY KEY(user_id, movie_id),
    CONSTRAINT fk_user FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    CONSTRAINT fk_movie FOREIGN KEY (movie_id) REFERENCES movies(movie_id) ON DELETE CASCADE
);

-- Insert records
INSERT INTO formats VALUES
(1, 'MP4'), (2, 'MOV'), (3, 'WMV'), (4, 'AVI'), (5, 'FLV'), (6, 'F4V'), (7, 'SWF'), (8, 'MKV'), (9, 'WEBM'), (10, 'HTML5'), (11, 'MPEG-2');

INSERT INTO resolutions VALUES
(1, 'SD (Standard Definition)', '640 x 480', '4:3', '480p'),
(2, 'HD (High Definition)', '1280 x 720', '16:9', '720p'),
(3, 'Full HD (FHD)', '1920 x 1080', '16:9', '1080p'),
(4, 'QHD (Quad HD)', '2560 x 1440', '16:9', '1440p'),
(5, '2K', '2048 x 1080', '1:1.77', '1080p'),
(6, '4K (Ultra HD)', '3840 x 2160', '1:1.9', '2160p'),
(7, '8K (Full Ultra HD)', '7680 x 4320', '16:9', '4320p');

-- Used site https://www.nyfa.edu/student-resources/ultimate-list-of-film-sub-genres/
INSERT INTO genres VALUES
(1, 'Action', NULL),
    (2, 'Action', 'Epic Movies'),  -- Ben Hur / Gone with the Wind
    (3, 'Action', 'Spy Movies'),  -- Mission Impossible
    (4, 'Action', 'Disaster Movies'),  -- Day after Tomorrow
    (5, 'Action', 'Superhero Movies'),  -- Hancock
    (6, 'Action', 'Thriller Movies'),  -- Die Hard
    (7, 'Action', 'Martial Arts Movies'),  -- The Karate Kid
    (8, 'Action', 'Video Game Movies'),  -- Resident Evil
(9, 'Animation', NULL),
    (10, 'Animation', 'Traditional'),  --Pinocchio/ Spirited Away
    (11, 'Animation', 'Rotoscoping'), -- A Scanner Darkly
    (12, 'Animation', 'Puppet'),  -- Coraline, Nightmare Before Christmas
    (13, 'Animation', 'Claymation'),  -- Wallace and Grommit
    (14, 'Animation', 'Live/Animation'),  -- Space Jam, Osmosis Jones
    (15, 'Animation', '2D CGI'),  -- Home on the Range
    (16, 'Animation', '3D CGI'),  -- Frozen, Toy Story, Up
(17, 'Crime', NULL),
    (18, 'Crime', 'Detective Movies'),  -- Lady on a Train
    (19, 'Crime', 'Gangster Movies'),  -- Gangs of New York
    (20, 'Crime', 'Legal Thrillers'),  -- A Few Good Men
(21, 'Comedy', NULL),
    (22, 'Comedy', 'Anarchic'),  -- Monty Python
    (23, 'Comedy', 'Bathroom'),  -- American Pie
    (24, 'Comedy', 'Parody'),  -- Scary Movie
    (25, 'Comedy', 'Sex'),  -- Knocked Up
    (26, 'Comedy', 'Straight'),  -- Mrs. Doubtfire
(27, 'Drama', NULL),
    (28, 'Drama', 'Docudrama'),  --  Zodiac
    (29, 'Drama', 'Comedy Drama'),  -- The Truman Show
    (30, 'Drama', 'Light Drama'),  -- The Help/ Terminal
    (31, 'Drama', 'Satire'),  -- Idiocracy
(32, 'Fantasy', NULL),
    (33, 'Fantasy', 'Urban Fantasy'), -- Ghostbusters / Constantine
    (34, 'Fantasy', 'Dark Fantasy'),  -- Pan's Labyrinth
    (35, 'Fantasy', 'Fairy Tale'),  -- Maleficient
    (36, 'Fantasy', 'Epic Fantasy'),  --Lord of the Rings / Narnia
    (37, 'Fantasy', 'Heroic Fantasy'),  -- Dark Crystal
    (38, 'Fantasy', 'Sword/Sorcery'), -- Conan the Barbarian
(39, 'Historical', NULL),
    (40, 'Historical', 'Biopic'),  -- Lincoln
    (41, 'Historical', 'Historical Drama'),  --Titanic / Braveheart
    (42, 'Historical', 'Biblical'),  --The Ten Commandments / Ben Hur
    (43, 'Historical', 'Period'),  -- Anna and the King
    (44, 'Historical', 'Alternate History'),  --Timequest
(45, 'Horror', NULL),
    (46, 'Horror', 'Slasher'),  --Nightmare on Elm Street / Scream
    (47, 'Horror', 'Splatter'),  -- Saw
    (48, 'Horror', 'Pyschological Horror'),  --Silence of the Lambs
    (49, 'Horror', 'Survival'),  -- 28 Days Later
    (50, 'Horror', 'Found Footage'),  -- Blair Witch Project
    (51, 'Horror', 'Paranormal/Occult'),  --Paranormal Activity/ Exorcist
    (52, 'Horror', 'Monster'),  -- Cloverfield
(53, 'Romance', NULL), 
    (54, 'Romance', 'Romantic comedy'),  --Love Actually
    (55, 'Romance', 'Historical Romance'),  -- Pride and Prejudice 
    (56, 'Romance', 'Romantic Action'),  -- A Knight's Tale
    (57, 'Romance', 'Romantic Thriller'),  --Mr and Mrs Smith
    (58, 'Romance', 'Chick flick'),  --The Notebook
    (59, 'Romance', 'Romantic Drama'),  --Casablanca
(60, 'Sci-Fi', NULL),
    (61, 'Sci-Fi', 'Hard'),  -- Jurassic Park / Gravity
    (62, 'Sci-Fi', 'Apocalyptic'),  -- Planet of the Apes
    (63, 'Sci-Fi', 'Future Noir'),  -- Terminator/ Blade Runner
    (64, 'Sci-Fi', 'Space Opera'),  -- Star Wars
    (65, 'Sci-Fi', 'Military'),  -- Starship Troopers
    (66, 'Sci-Fi', 'Punk'),  -- Total Recall, Demolition Man
    (67, 'Sci-Fi', 'Speculative'),  -- Interstellar
(68, 'Thriller', NULL),
    (69, 'Thriller', 'Action Thriller'),  -- Taken
    (70, 'Thriller', 'Comedy Thriller'),  -- Mr and Mrs Smith
    (71, 'Thriller', 'Conspiracy'),  -- The Da Vinci Code
    (72, 'Thriller', 'Crime Thriller'),  -- Entrapment
    (73, 'Thriller', 'Erotic'),  -- Basic Instinct
    (74, 'Thriller', 'Pandemic'),  -- Contagin, Outbreak
(75, 'Western', NULL),
    (76, 'Western', 'Epic Western'),  -- The Good, The Bad, The Ugly
    (77, 'Western', 'Outlaw Western'),  -- Butch Cassidy and the Sundance Kid
    (78, 'Western', 'Marshall Western'),  -- The Lone Ranger
    (79, 'Western', 'Revisionist Western'),  -- Dances with Wolves
    (80, 'Western', 'Revenge Western'),  -- High Plains Drifter
    (81, 'Western', 'Empire Western'),  -- There will be blood
(82, 'Adventure', NULL),
    (83, 'Adventure', 'Swashbuckler films'),
    (84, 'Adventure', 'Pirate films'),
    (85, 'Adventure', 'Survival films');

INSERT INTO MPA_ratings VALUES
(1, 'G', 'General Audiences', 'All ages admitted. Nothing that would offend parents for viewing by children.'),
(2, 'PG', 'Parental Guidance Suggested', 'Some material may not be suitable for children. Parents urged to give "parental guidance". May contain some material parents might not like for their young children.'),
(3, 'PG-13', 'Parents Strongly Cautioned', 'Some material may be inappropriate for children under 13. Parents are urged to be cautious. Some material may be inappropriate for pre-teenagers.'),
(4, 'R', 'Restricted', 'Under 17 requires accompanying parent or adult guardian. Contains some adult material. Parents are urged to learn more about the film before taking their young children with them.'),
(5, 'NC-17', 'Adults Only', 'No One 17 and Under Admitted. Clearly adult. Children are not admitted.'),
(6, 'X', 'Adult Content', 'Contains an accumulation of brutal or sexually connotative language or explicit sex, or excessive and sadistic violence');

INSERT INTO trailers VALUES
(1, 'https://youtu.be/v-PjgYDrg70', 'Toy Story'),
(2, 'https://youtu.be/mE35XQFxbeo', 'A Bug''s Life'),
(3, 'https://youtu.be/xNWSGRD5CzU', 'Toy Story 2'),
(4, 'https://youtu.be/CGbgaHoapFM', 'Monsters, Inc.'),
(5, 'https://youtu.be/9oQ628Seb9w', 'Finding Nemo'),
(6, 'https://youtu.be/-UaGUdNJdRQ', 'The Incredibles'),
(7, 'https://youtu.be/W_H7_tDHFE8', 'Cars'),
(8, 'https://youtu.be/NgsQ8mVkN8w', 'Ratatouille'),
(9, 'https://youtu.be/CZ1CATNbXg0', 'WALL-E'),
(10, 'https://youtu.be/AkdXuDAP2Ts', 'Up'),
(11, 'https://youtu.be/ZZv1vki4ou4', 'Toy Story 3'),
(12, 'https://youtu.be/lg5hj2c5Nkk', 'Cars 2'),
(13, 'https://youtu.be/TEHWDA_6e3M', 'Brave'),
(14, 'https://youtu.be/QxrQ6BaijAY', 'Monsters University'),
(15, 'https://youtu.be/WIDYqBMFzfg', 'Inside Out'),
(16, 'https://youtu.be/7BrH72aFXfI', 'The Good Dinosaur'),
(17, 'https://youtu.be/oP0WR2Ql9yI', 'Finding Dory'),
(18, 'https://youtu.be/xGGM5Sy5PJs', 'Cars 3'),
(19, 'https://youtu.be/Dh2szjud4I4', 'Coco'),
(20, 'https://youtu.be/D9joM600LKA', 'Incredibles 2'),
(21, 'https://youtu.be/lZHUmQ-dCXM', 'Toy Story 4'),
(22, 'https://youtu.be/Alv1znZA6Es', 'Onward'),
(23, 'https://youtu.be/aP5C1OSSEOo', 'Soul'),
(24, 'https://youtu.be/fDGe7ozamj0', 'Luca');

INSERT INTO actors VALUES
(1, 'Tom', 'Hanks'),
(2, 'Tim', 'Allen'),
(3, 'Don', 'Rickles'),
(4, 'Jim', 'Varney'),
(5, 'Wallace', 'Shawn'),
(6, 'John', 'Ratzenberger'),
(7, 'Annie', 'Potts'),
(8, 'John', 'Morris'),
(9, 'Eric', 'von Detten'),
(10, 'Dave', 'Foley'),
(11, 'Kevin', 'Spacey'),
(12, 'Julia', 'Louis-Dreyfus'),
(13, 'Joan', 'Cusack'),
(14, 'Kelsey', 'Grammer'),
(15, 'Billy', 'Crystal'),
(16, 'John', 'Goodman'),
(17, 'Mary', 'Gibbs'),
(18, 'Steve', 'Buscemi'),
(19, 'Albert', 'Brooks'),
(20, 'Ellen', 'DeGeneres'),
(21, 'Alexander', 'Gould'),
(22, 'William', 'DaFoe'),
(23, 'Craig', 'Nelson'),
(24, 'Samuel', 'Jackson'),
(25, 'Holly', 'Hunter'),
(26, 'Jason', 'Lee'),
(27, 'Owen', 'Wilson'),
(28, 'Bonnie', 'Hunt'),
(29, 'Paul', 'Newman'),
(30, 'Larry', 'Cable Guy, the'),
(31, 'Brad', 'Garrett'),
(32, 'Lou', 'Romano'),
(33, 'Patton', 'Oswalt'),
(34, 'Ian', 'Holm'),
(35, 'Ben', 'Burtt'),
(36, 'Elissa', 'Knight'),
(37, 'Jeff', 'Garlin'),
(38, 'Fred', 'Willard'),
(39, 'Ed', 'Asner'),
(40, 'Jordan', 'Nagai'),
(41, 'John', 'Ratzenberger'),
(42, 'Christopher', 'Plummer'),
(43, 'Ned', 'Beatty'),
(44, 'Michael', 'Caine'),
(45, 'Emily', 'Mortimer'),
(46, 'Kelly', 'Macdonald'),
(47, 'Billy', 'Connolly'),
(48, 'Emma', 'Thompson'),
(49, 'Julie', 'Walters'),
(50, 'Helen', 'Mirren'),
(51, 'Amy', 'Poehler'),
(52, 'Bill', 'Hader'),
(53, 'Lewis', 'Black'),
(54, 'Mindy', 'Kaling'),
(55, 'Jeffrey', 'Wright'),
(56, 'Frances', 'McDormand'),
(57, 'Maleah', 'Nipay-Padilla'),
(58, 'Ryan', 'Teeple'),
(59, 'Ed', 'O''Neill'),
(60, 'Kaitlin', 'Olson'),
(61, 'Cristela', 'Alonzo'),
(62, 'Chris', 'Cooper'),
(63, 'Nathan', 'Fillion'),
(64, 'Anthony', 'Gonzalez'),
(65, 'Gael', 'Garcia Bernal'),
(66, 'Benjamin', 'Bratt'),
(67, 'Alanna', 'Ubach'),
(68, 'Sarah', 'Vowell'),
(69, 'Huck', 'Milner'),
(70, 'Tony', 'Hale'),
(71, 'Tom', 'Holland'),
(72, 'Chris', 'Pratt'),
(73, 'Julia', 'Louis-Dreyfus'),
(74, 'Octavia', 'Spencer'),
(75, 'Jamie', 'Foxx'),
(76, 'Tina', 'Fey'),
(77, 'Graham', 'Norton'),
(78, 'Rachel', 'House'),
(79, 'Jacob', 'Tremblay'),
(80, 'Jack', 'Dylan Grazer'),
(81, 'Emma', 'Berman'),
(82, 'Saverio', 'Raimondo')
;

INSERT INTO awards VALUES
(1, 'Best Original Screenplay'),
(2, 'Best Original Song'),
(3, 'Best Original Score'),
(4, 'Best Instrumental Composition'),
(5, 'Best Animated Film');

INSERT INTO directors VALUES
(1, 'John', 'Lasseter'),
(2, 'Pete', 'Docter'),
(3, 'Andrew', 'Stanton'),
(4, 'Brad', 'Bird'),
(5, 'Lee', 'Unkrich'),
(6, 'Mark', 'Andrews'),
(7, 'Brenda', 'Chapman'),
(8, 'Dan', 'Scanlon'),
(9, 'Peter', 'Sohn'),
(10, 'Brian', 'Fee'),
(11, 'Josh', 'Cooley'),
(12, 'Enrico', 'Casarosa'),
(13, 'Ash', 'Brannon'),
(14, 'David', 'Silverman'),
(15, 'Joe', 'Ranft'),
(16, 'Bob', 'Peterson'),
(17, 'Brad', 'Lewis'),
(18, 'Steve', 'Purcell'),
(19, 'Ronnie', 'del Carmen'),
(20, 'Angus', 'MacLane'),
(21, 'Kemp', 'Powers'),
(22, 'Jan', 'Pinkava'),
(23, 'Adrian', 'Molina');

INSERT INTO users (user_id, username, password, email, age) VALUES
(1, 'user1', 'passwordHappy', 'ed@gmail.com', 34),
(2, 'user2', 'superPassword', 'bob@gmail.com', 38);

INSERT INTO movies VALUES
-- id, title, year, length_min, studio, format_id(edit later), resolution_id (edit later), rating_id, cover, movie (edit later), subtitles (edit later), summary
(1, 'Toy Story', 1995, 81, 'Disney Pixar', 1, 3, 1, 'https://upload.wikimedia.org/wikipedia/en/1/13/Toy_Story.jpg', 'movie link', 'sub link', 'A cowboy doll is profoundly threatened and jealous when a new spaceman figure supplants him as top toy in a boy''s room.'),
(2, 'A Bug''s Life', 1998, 95, 'Disney Pixar', 1, 3, 1,'https://upload.wikimedia.org/wikipedia/en/c/cc/A_Bug%27s_Life.jpg', 'movie link', 'sub link', 'A misfit ant, looking for "warriors" to save his colony from greedy grasshoppers, recruits a group of bugs that turn out to be an inept circus troupe.'),
(3, 'Toy Story 2', 1999, 92, 'Disney Pixar', 1, 3, 1, 'https://m.media-amazon.com/images/M/MV5BMWM5ZDcxMTYtNTEyNS00MDRkLWI3YTItNThmMGExMWY4NDIwXkEyXkFqcGdeQXVyNjUwNzk3NDc@._V1_UY209_CR1,0,140,209_AL_.jpg', 'movie link', 'sub link', 'When Woody is stolen by a toy collector, Buzz and his friends set out on a rescue mission to save Woody before he becomes a museum toy property with his roundup gang Jessie, Prospector, and Bullseye.'),
(4, 'Monsters, Inc.', 2001, 92, 'Disney Pixar', 1, 3, 1, 'https://m.media-amazon.com/images/M/MV5BMTY1NTI0ODUyOF5BMl5BanBnXkFtZTgwNTEyNjQ0MDE@._V1_UY209_CR0,0,140,209_AL_.jpg', 'movie link', 'sub link', 'In order to power the city, monsters have to scare children so that they scream. However, the children are toxic to the monsters, and after a child gets through, two monsters realize things may not be what they think.'),
(5, 'Finding Nemo', 2003, 100, 'Disney Pixar', 1, 3, 1, 'https://m.media-amazon.com/images/M/MV5BZTAzNWZlNmUtZDEzYi00ZjA5LWIwYjEtZGM1NWE1MjE4YWRhXkEyXkFqcGdeQXVyNjU0OTQ0OTY@._V1_UY209_CR0,0,140,209_AL_.jpg', 'movie link', 'sub link', 'After his son is captured in the Great Barrier Reef and taken to Sydney, a timid clownfish sets out on a journey to bring him home.'),
(6, 'The Incredibles', 2004, 115, 'Disney Pixar', 1, 3, 2, 'https://m.media-amazon.com/images/M/MV5BMTY5OTU0OTc2NV5BMl5BanBnXkFtZTcwMzU4MDcyMQ@@._V1_UY209_CR0,0,140,209_AL_.jpg', 'movie link', 'sub link', 'A family of undercover superheroes, while trying to live the quiet suburban life, are forced into action to save the world.'),
(7, 'Cars', 2006, 117, 'Disney Pixar', 1, 3, 1, 'https://m.media-amazon.com/images/M/MV5BMTg5NzY0MzA2MV5BMl5BanBnXkFtZTYwNDc3NTc2._V1_UY209_CR0,0,140,209_AL_.jpg', 'movie link', 'sub link', 'A hot-shot race-car named Lightning McQueen gets waylaid in Radiator Springs, where he finds the true meaning of friendship and family.'),
(8, 'Ratatouille', 2007, 111, 'Disney Pixar', 1, 3, 1, 'https://m.media-amazon.com/images/M/MV5BMTMzODU0NTkxMF5BMl5BanBnXkFtZTcwMjQ4MzMzMw@@._V1_UY209_CR0,0,140,209_AL_.jpg', 'movie link', 'sub link', 'A rat who can cook makes an unusual alliance with a young kitchen worker at a famous restaurant.'),
(9, 'WALL-E', 2008, 98, 'Disney Pixar', 1, 3, 1, 'https://m.media-amazon.com/images/M/MV5BMjExMTg5OTU0NF5BMl5BanBnXkFtZTcwMjMxMzMzMw@@._V1_UY209_CR0,0,140,209_AL_.jpg', 'movie link', 'sub link', 'In the distant future, a small waste-collecting robot inadvertently embarks on a space journey that will ultimately decide the fate of mankind.'),
(10, 'Up', 2009, 96, 'Disney Pixar', 1, 3, 2, 'https://m.media-amazon.com/images/M/MV5BMTk3NDE2NzI4NF5BMl5BanBnXkFtZTgwNzE1MzEyMTE@._V1_UX140_CR0,0,140,209_AL_.jpg', 'movie link', 'sub link', '78-year-old Carl Fredricksen travels to Paradise Falls in his house equipped with balloons, inadvertently taking a young stowaway.'),
(11, 'Toy Story 3', 2010, 103, 'Disney Pixar', 1, 3, 1, 'https://m.media-amazon.com/images/M/MV5BMTgxOTY4Mjc0MF5BMl5BanBnXkFtZTcwNTA4MDQyMw@@._V1_UY209_CR4,0,140,209_AL_.jpg', 'movie link', 'sub link', 'The toys are mistakenly delivered to a day-care center instead of the attic right before Andy leaves for college, and it''s up to Woody to convince the other toys that they weren''t abandoned and to return home.'),
(12, 'Cars 2', 2011, 106, 'Disney Pixar', 1, 3, 1, 'https://m.media-amazon.com/images/M/MV5BMTUzNTc3MTU3M15BMl5BanBnXkFtZTcwMzIxNTc3NA@@._V1_UY209_CR0,0,140,209_AL_.jpg', 'movie link', 'sub link', 'Star race car Lightning McQueen and his pal Mater head overseas to compete in the World Grand Prix race. But the road to the championship becomes rocky as Mater gets caught up in an intriguing adventure of his own: international espionage.'),
(13, 'Brave', '2012', 93, 'Disney Pixar', 1, 3, 2, 'https://m.media-amazon.com/images/M/MV5BMzgwODk3ODA1NF5BMl5BanBnXkFtZTcwNjU3NjQ0Nw@@._V1_UY209_CR0,0,140,209_AL_.jpg', 'movie link', 'sub link', 'Determined to make her own path in life, Princess Merida (Kelly Macdonald) defies a custom that brings chaos to her kingdom. Granted one wish, Merida must rely on her bravery and her archery skills to undo a beastly curse.'),
(14, 'Monsters University', 2013, 104, 'Disney Pixar', 1, 3, 1, 'https://m.media-amazon.com/images/M/MV5BMTUyODgwMDU3M15BMl5BanBnXkFtZTcwOTM4MjcxOQ@@._V1_UY209_CR0,0,140,209_AL_.jpg', 'movie link', 'sub link', 'A look at the relationship between Mike Wazowski (Billy Crystal) and James P. "Sully" Sullivan (John Goodman) during their days at Monsters University, when they weren''t necessarily the best of friends.'),
(15, 'Inside Out', 2015, 95, 'Disney Pixar', 1, 3, 2, 'https://m.media-amazon.com/images/M/MV5BOTgxMDQwMDk0OF5BMl5BanBnXkFtZTgwNjU5OTg2NDE@._V1_UY209_CR0,0,140,209_AL_.jpg', 'movie link', 'sub link', 'After young Riley is uprooted from her Midwest life and moved to San Francisco, her emotions - Joy, Fear, Anger, Disgust and Sadness - conflict on how best to navigate a new city, house, and school.'),
(16, 'The Good Dinosaur', 2015, 93, 'Disney Pixar', 1, 3, 2, 'https://m.media-amazon.com/images/M/MV5BMTc5MTg2NjQ4MV5BMl5BanBnXkFtZTgwNzcxOTY5NjE@._V1_UY209_CR0,0,140,209_AL_.jpg', 'movie link', 'sub link', 'In a world where dinosaurs and humans live side-by-side, an Apatosaurus named Arlo makes an unlikely human friend.'),
(17, 'Finding Dory', 2016, 97, 'Disney Pixar', 1, 3, 2, 'https://m.media-amazon.com/images/M/MV5BNzg4MjM2NDQ4MV5BMl5BanBnXkFtZTgwMzk3MTgyODE@._V1_UY209_CR0,0,140,209_AL_.jpg', 'movie link', 'sub link', 'Friendly but forgetful blue tang Dory begins a search for her long-lost parents, and everyone learns a few things about the real meaning of family along the way.'),
(18, 'Cars 3', 2017, 102, 'Disney Pixar', 1, 3, 1, 'https://upload.wikimedia.org/wikipedia/en/9/94/Cars_3_poster.jpg', 'movie link', 'sub link', 'Blindsided by a new generation of blazing-fast cars, the legendary Lighting McQueen finds himself pushed out of the sport that he loves. Hoping to get back in the game, he turns to Cruz Ramirez, an eager young technician who has her own plans for winning. With inspiration from the Fabulous Hudson Hornet and a few unexpected turns, No. 95 prepares to compete on Piston Cup Racing''s biggest stage.'),
(19, 'Coco', 2017, 105, 'Disney Pixar', 1, 3, 2, 'https://m.media-amazon.com/images/M/MV5BYjQ5NjM0Y2YtNjZkNC00ZDhkLWJjMWItN2QyNzFkMDE3ZjAxXkEyXkFqcGdeQXVyODIxMzk5NjA@._V1_UY209_CR3,0,140,209_AL_.jpg', 'movie link', 'sub link', 'Aspiring musician Miguel, confronted with his family''s ancestral ban on music, enters the Land of the Dead to find his great-great-grandfather, a legendary singer.'),
(20, 'Incredibles 2', 2018, 118, 'Disney Pixar', 1, 3, 2, 'https://upload.wikimedia.org/wikipedia/en/2/27/The_Incredibles_2.jpg', 'movie link', 'sub link', 'The Incredibles family takes on a new mission which involves a change in family roles: Bob Parr (Mr. Incredible) must manage the house while his wife Helen (Elastigirl) goes out to save the world.'),
(21, 'Toy Story 4', 2019, 100, 'Disney Pixar', 1, 3, 1, 'https://upload.wikimedia.org/wikipedia/en/4/4c/Toy_Story_4_poster.jpg', 'movie link', 'sub link', 'When a new toy called "Forky" joins Woody and the gang, a road trip alongside old and new friends reveals how big the world can be for a toy.'),
(22, 'Onward', 2020, 102, 'Disney Pixar', 1, 3, 2, 'https://upload.wikimedia.org/wikipedia/en/0/03/Onward_poster.jpg', 'movie link', 'sub link', 'Two elven brothers embark on a quest to bring their father back for one day.'),
(23, 'Soul', 2020, 100, 'Disney Pixar', 1, 3, 2, 'https://upload.wikimedia.org/wikipedia/en/9/95/Soul_Poster.jpeg', 'movie link', 'sub link', 'After landing the gig of a lifetime, a New York jazz pianist suddenly finds himself trapped in a strange land between Earth and the afterlife.'),
(24, 'Luca', 2021, 95, 'Disney Pixar', 1, 3, 2, 'https://upload.wikimedia.org/wikipedia/en/3/33/Luca_%282021_film%29.png', 'movie link', 'sub link', 'On the Italian Riviera, an unlikely but strong friendship grows between a human being and a sea monster disguised as a human.')
;

INSERT INTO movies_trailers VALUES
(1, 1), (2, 2), (3, 3), (4, 4), (5, 5), (6, 6), (7, 7), (8, 8), (9, 9), (10, 10), (11, 11), (12, 12), (13, 13), (14, 14), (15, 15), (16, 16), (17, 17), (18, 18), (19, 19), (20, 20), (21, 21), (22, 22), (23, 23), (24, 24);

INSERT INTO movies_actors VALUES
(1, 1), (2, 1), (3, 1), (4, 1), (5, 1), (6, 1), (7, 1), (8, 1), (9, 1), 
(10, 2), (11, 2), (12, 2),
(1, 3), (2, 3), (13, 3), (14, 3), 
(15, 4), (16, 4), (17, 4), (18, 4), 
(19, 5), (20, 5), (21, 5), (22, 5),
(23, 6), (24, 6), (25, 6), (26, 6),
(27, 7), (28, 7), (29, 7), (30, 7),
(31, 8), (32, 8), (33, 8), (34, 8),
(35, 9), (36, 9), (37, 9), (38, 9),
(39, 10), (40, 10), (41, 10), (42, 10),
(1, 11), (2, 11), (13, 11), (43, 11),
(27, 12), (30, 12), (44, 12), (45, 12),
(46, 13), (47, 13), (48, 13), (49, 13),
(15, 14), (16, 14), (18, 14),
(50, 14),
(51, 15), (52, 15), (53, 15), (54, 15),
(55, 16), (56, 16), (57, 16), (58, 16),
(20, 17), (19, 17), (59, 17), (60, 17),
(27, 18), (61, 18), (62, 18), (63, 18), (30, 18),
(64, 19), (65, 19), (66, 19), (67, 19),
(23, 20), (25, 20), (68, 20), (69, 20),
(1, 21), (2, 21), (7, 21), (70, 21),
(71, 22), (72, 22), (73, 22), (74, 22),
(75, 23), (76, 23), (77, 23), (78, 23),
(79, 24), (80, 24), (81, 24), (82, 24);

INSERT INTO movies_genres VALUES
(16, 1), (21, 1), (32, 1), (82, 1), 
(16, 2), (21, 2), (32, 2), (85, 2), 
(16, 3), (21, 3), (32, 3), (82, 3),
(16, 4), (21, 4), (32, 4), (82, 4), 
(16, 5), (21, 5), (32, 5), (85, 5), 
(16, 6), (21, 6), (37, 6), (82, 6), (5, 6),
(16, 7), (21, 7), (32, 7), (82, 7), 
(16, 8), (21, 8), (32, 8), (82, 8), 
(16, 9), (21, 9), (32, 9), (82, 9), (63, 9),
(16, 10), (21, 10), (32, 10), (82, 10), 
(16, 11), (21, 11), (32, 11), (82, 11), 
(16, 12), (21, 12), (32, 12), (82, 12), 
(16, 13), (21, 13), (32, 13), (82, 13), 
(16, 14), (21, 14), (32, 14), (82, 14), 
(16, 15), (21, 15), (32, 15), (82, 15),
(16, 16), (21, 16), (32, 16), (85, 16), 
(16, 17), (21, 17), (32, 17), (82, 17),
(16, 18), (21, 18), (32, 18), (82, 18),
(16, 19), (21, 19), (32, 19), (82, 19),
(16, 20), (21, 20), (37, 20), (82, 20), (5, 20),
(16, 21), (21, 21), (32, 21), (82, 21),
(16, 22), (21, 22), (32, 22), (82, 22),
(16, 23), (21, 23), (32, 23), (85, 23),
(16, 24), (21, 24), (32, 24), (82, 24);

INSERT INTO movies_awards VALUES
(1, 1), (2, 1), (3, 1), 
(4, 2), (5, 2);

INSERT INTO movies_directors VALUES
(1, 1), 
(2, 1), (2, 3), 
(3, 1), (3, 13), 
(4, 2), (4, 5), (4, 14), 
(5, 3), (5, 5), 
(6, 4), 
(7, 1), (7, 15), 
(8, 4), (8, 22), 
(9, 3), 
(10, 2), (10, 16), 
(11, 5), 
(12, 1), (12, 17), 
(13, 6), (13, 7), (13, 18), 
(14, 8), 
(15, 2), (15, 19), 
(16, 9), 
(17, 3), (17, 20), 
(18, 10), 
(19, 5), (19, 23), 
(20, 4), 
(21, 11), 
(22, 8), 
(23, 2), (23, 21), 
(23, 12);

INSERT INTO movie_ratings VALUES
(1, 1, 7), (2, 1, 8);

-- Change starting sequences of tables for Flask to accommodate for initial data
ALTER SEQUENCE formats_format_id_seq RESTART WITH 12;
ALTER SEQUENCE resolutions_resolution_id_seq RESTART WITH 8;
ALTER SEQUENCE genres_genre_id_seq RESTART WITH 86;
ALTER SEQUENCE MPA_ratings_rating_id_seq RESTART WITH 7;
ALTER SEQUENCE trailers_trailer_id_seq RESTART WITH 25;
ALTER SEQUENCE actors_actor_id_seq RESTART WITH 82;
ALTER SEQUENCE awards_award_id_seq RESTART WITH 6;
ALTER SEQUENCE directors_director_id_seq RESTART WITH 24;
ALTER SEQUENCE users_user_id_seq RESTART WITH 3;
ALTER SEQUENCE movies_movie_id_seq RESTART WITH 25;

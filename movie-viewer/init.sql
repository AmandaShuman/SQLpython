---
--- movie_viewer
---

DROP DATABASE IF EXISTS movies;
CREATE DATABASE movies;
\c movies

DROP TABLE IF EXISTS trailers;
DROP TABLE IF EXISTS movies_trailers;
DROP TABLE IF EXISTS formats;
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
)

--
-- Name: resolutions; Type: TABLE; Schema: public; Owner: Amanda_Shuman; Tablespace: 
--
CREATE TABLE resolutions (
    resolution_id SERIAL PRIMARY KEY,
    resolution TEXT NOT NULL,
    pixel_size TEXT NOT NULL,
    aspect_ratio TEXT NOT NULL,
    num_p TEXT
)

--
-- Name: actors; Type: TABLE; Schema: public; Owner: Amanda_Shuman; Tablespace: 
--


--
-- Name: genres; Type: TABLE; Schema: public; Owner: Amanda_Shuman; Tablespace: 
--


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
    length TEXT NOT NULL,
    format_id INT NOT NULL,
    CONSTRAINT fk_movie_format FOREIGN KEY (format_id) REFERENCES formats (format_id)
);

--
-- Name: users; Type: TABLE; Schema: public; Owner: Amanda_Shuman; Tablespace: 
--

-- Insert records
INSERT INTO formats (extension) VALUES
(MP4), (MOV), (WMV), (AVI), (FLV), (F4V), (SWF), (MKV), (WEBM), (HTML5), (MPEG-2);

INSERT INTO resolutions VALUES
('SD (Standard Definition)', '640 x 480', '4:3', '480p'),
('HD (High Definition)', '1280 x 720', '16:9', '720p'),
('Full HD (FHD)', '1920 x 1080', '16:9', '1080p'),
('QHD (Quad HD)', '2560 x 1440', '16:9', '1440p'),
('2K', '2048 x 1080', '1:1.77', '1080p'),
('4K (Ultra HD)', '3840 x 2160', '1:1.9', '2160p'),
('8K (Full Ultra HD)', '7680 x 4320', '16:9', '4320p')
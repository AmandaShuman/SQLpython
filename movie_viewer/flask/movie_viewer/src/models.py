import datetime
from flask_sqlalchemy import SQLAlchemy

db = SQLAlchemy()

# Reference:
# https://flask-sqlalchemy.palletsprojects.com/en/2.x/models/
# https://docs.sqlalchemy.org/en/14/core/metadata.html#sqlalchemy.schema.Column
# https://flask-sqlalchemy.palletsprojects.com/en/2.x/models/#many-to-many-relationships


class Trailer(db.Model):
    __tablename__ = 'trailers'
    trailer_id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    trailer_url = db.Column(db.Text, nullable=False)
    trailer_name = db.Column(db.String(100), nullable=False)

    def __init__(self, trailer_url: str, trailer_name: str):
        self.trailer_url = trailer_url
        self.trailer_name = trailer_name

    def serialize(self):
        return {
            'trailer_id': self.trailer_id,
            'trailer_url': self.trailer_url,
            'trailer_name': self.trailer_name
        }


class Format(db.Model):
    __tablename__ = 'formats'
    format_id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    extension = db.Column(db.String(10), nullable=False)


class Resolution(db.Model):
    __tablename__ = 'resolutions'
    resolution_id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    resoution = db.Column(db.String(40), nullable=False)
    pixel_size = db.Column(db.String(15), nullable=False)
    aspect_ratio = db.Column(db.String(10), nullable=False)
    num_p = db.Column(db.String(10))


class Actor(db.Model):
    __tablename__ = 'actors'
    actor_id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    first_name = db.Column(db.String(50), nullable=False)
    last_name = db.Column(db.String(50), nullable=False)
    gender = db.Column(db.String(10))
    birth_date = db.Column(db.Date)
    picture = db.Column(db.Text)


class Genre(db.Model):
    __tablename__ = 'genres'
    genre_id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    genre = db.Column(db.String(25), nullable=False)
    subgenre = db.Column(db.String(25))
    description = db.Column(db.Text)


class Award(db.Model):
    __tablename__ = 'awards'
    award_id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    award = db.Column(db.String(150), nullable=False)


class Director(db.Model):
    __tablename__ = 'directors'
    director_id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    first_name = db.Column(db.String(50), nullable=False)
    last_name = db.Column(db.String(50), nullable=False)
    gender = db.Column(db.String(10))
    birth_date = db.Column(db.Date)
    picture = db.Column(db.Text)


class User(db.Model):
    __tablename__ = 'users'
    user_id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    username = db.Column(db.String(15), unique=True, nullable=False)
    password = db.Column(db.String(128), nullable=False)
    email = db.Column(db.String(320), unique=True, nullable=False)
    first_name = db.Column(db.String(50))
    last_name = db.Column(db.String(50))
    gender = db.Column(db.String(10))
    birth_date = db.Column(db.Date)
    profile_pic = db.Column(db.Text)
    age = db.Column(db.Integer, nullable=False)


class Mpa_rating(db.Model):
    __tablename__ = 'MPA_ratings'
    rating_id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    rating = db.Column(db.String(10), nullable=False)
    description_short = db.Column(db.String(100))
    description_detailed = db.Column(db.Text)


class Movie(db.Model):
    __tablename__ = 'movies'
    movie_id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    title = db.Column(db.String(50), nullable=False)
    year = db.Column(db.Integer, nullable=False)
    length_min = db.Column(db.Integer, nullable=False)
    studio = db.Column(db.String(50))
    format_id = db.Column(
        db.Integer, 
        db.ForeignKey('formats.format_id'), 
        nullable=False
        )
    resolution_id = db.Column(
        db.Integer, 
        db.ForeignKey('resolutions.resolution_id'), 
        nullable=False
        )
    rating_id = db.Column(
        db.Integer, 
        db.ForeignKey('MPA_ratings.rating_id'), 
        nullable=False
        )
    cover = db.Column(db.Text)
    movie = db.Column(db.Text, nullable=False)
    movie_subtitles = db.Column(db.Text)
    summary = db.Column(db.Text)


movie_trailers_table = db.Table(
    'movies_trailers',
    db.Column(
        'trailer_id', db.Integer,
        db.ForeignKey('trailers.trailer_id'),
        primary_key=True
    ),
    db.Column(
        'movie_id', db.Integer,
        db.ForeignKey('movies.movie_id'),
        primary_key=True
    )
)


movie_actors_table = db.Table(
    'movies_actors',
    db.Column(
        'actor_id', db.Integer,
        db.ForeignKey('actors.actor_id'),
        primary_key=True
    ),
    db.Column(
        'movie_id', db.Integer,
        db.ForeignKey('movies.movie_id'),
        primary_key=True
    )
)


movie_genres_table = db.Table(
    'movies_genres',
    db.Column(
        'genre_id', db.Integer,
        db.ForeignKey('genres.genre_id'),
        primary_key=True
    ),
    db.Column(
        'movie_id', db.Integer,
        db.ForeignKey('movies.movie_id'),
        primary_key=True
    )
)


movie_awards_table = db.Table(
    'movies_awards',
    db.Column(
        'award_id', db.Integer,
        db.ForeignKey('awards.award_id'),
        primary_key=True
    ),
    db.Column(
        'movie_id', db.Integer,
        db.ForeignKey('movies.movie_id'),
        primary_key=True
    )
)


movie_directors_table = db.Table(
    'movies_directors',
    db.Column(
        'director_id', db.Integer,
        db.ForeignKey('directors.director_id'),
        primary_key=True
    ),
    db.Column(
        'movie_id', db.Integer,
        db.ForeignKey('movies.movie_id'),
        primary_key=True
    )
)


user_movie_ratings_table = db.Table(
    db.Column(
        'user_id', db.Integer,
        db.ForeignKey('users.user_id'),
        primary_key=True
    ),
    db.Column(
        'movie_id', db.Integer,
        db.ForeignKey('movies.movie_id'),
        primary_key=True
    ),
    db.Column(
        'rating', db.Numeric,
        nullable=False
    ),
    db.Column(
        'rating_date', db.DateTime,
        default=datetime.datetime.utcnow
    )
)

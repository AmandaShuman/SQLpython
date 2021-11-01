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

    def __init__(self, extension: str):
        self.extension = extension

    def serialize(self):
        return {
            'format_id': self.format_id,
            'extension': self.extension
        }


class Resolution(db.Model):
    __tablename__ = 'resolutions'
    resolution_id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    resolution = db.Column(db.String(40), nullable=False)
    pixel_size = db.Column(db.String(15), nullable=False)
    aspect_ratio = db.Column(db.String(10), nullable=False)
    num_p = db.Column(db.String(10))

    def __init__(self, resolution: str, pixel_size: str, aspect_ratio: str, num_p: str):
        self.resolution = resolution
        self.pixel_size = pixel_size
        self.aspect_ratio = aspect_ratio
        self.num_p = num_p  

    def serialize(self):
        return {
            'resolution_id': self.resolution_id,
            'resolution': self.resolution,
            'pixel_size': self.pixel_size,
            'aspect_ratio': self.aspect_ratio,
            'num_p': self.num_p
        }  


class Actor(db.Model):
    __tablename__ = 'actors'
    actor_id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    first_name = db.Column(db.String(50), nullable=False)
    last_name = db.Column(db.String(50), nullable=False)
    gender = db.Column(db.String(10))
    birth_date = db.Column(db.Date)
    picture = db.Column(db.Text)

    def __init__(self, first_name: str, last_name: str, gender: str, birth_date: datetime.date, picture: str):
        self.first_name = first_name
        self.last_name = last_name
        self.gender = gender
        self.birth_date = birth_date
        self.picture = picture

    def serialize(self):
        return {
            'actor_id': self.actor_id,
            'first_name': self.first_name,
            'last_name': self.last_name,
            'gender': self.gender,
            'birth_date': self.birth_date,
            'picture': self.picture
        }


class Genre(db.Model):
    __tablename__ = 'genres'
    genre_id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    genre = db.Column(db.String(25), nullable=False)
    subgenre = db.Column(db.String(25))
    description = db.Column(db.Text)

    def __init__(self, genre: str, subgenre: str, description: str):
        self.genre = genre
        self.subgenre = subgenre
        self.description = description

    def serialize(self):
        return {
            'genre_id': self.genre_id,
            'genre': self.genre,
            'subgenre': self.subgenre,
            'description': self.description
        }


class Award(db.Model):
    __tablename__ = 'awards'
    award_id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    award = db.Column(db.String(150), nullable=False)

    def __init__(self, award: str):
        self.award = award

    def serialize(self):
        return {
            'award_id': self.award_id,
            'award': self.award
        }


class Director(db.Model):
    __tablename__ = 'directors'
    director_id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    first_name = db.Column(db.String(50), nullable=False)
    last_name = db.Column(db.String(50), nullable=False)
    gender = db.Column(db.String(10))
    birth_date = db.Column(db.Date)
    picture = db.Column(db.Text)

    def __init__(self, first_name: str, last_name: str, gender: str, birth_date: datetime.date, picture: str):
        self.first_name = first_name
        self.last_name = last_name
        self.gender = gender
        self.birth_date = birth_date
        self.picture = picture

    def serialize(self):
        return {
            'director_id': self.director_id,
            'first_name': self.first_name,
            'last_name': self.last_name,
            'gender': self.gender,
            'birth_date': self.birth_date,
            'picture': self.picture
        }


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

    def __init__(self, username: str, password: str, email: str, first_name: str, last_name: str, gender: str, birth_date: datetime.date, profile_pic: str, age: int):
        self.username: username
        self.password: password
        self.email: email
        self.first_name = first_name
        self.last_name = last_name
        self.gender = gender
        self.birth_date = birth_date
        self.profile_pic = profile_pic
        self.age = age

    def serialize(self):
        return {
            'user_id': self.user_id,
            'username': self.username,
            'password': self.password,
            'email': self.email,
            'first_name': self.first_name,
            'last_name': self.last_name,
            'gender': self.gender,
            'birth_date': self.birth_date,
            'proflie_pic': self.profile_pic,
            'age': self.age
        }


class Mpa_rating(db.Model):
    __tablename__ = 'mpa_ratings'
    rating_id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    rating = db.Column(db.String(10), nullable=False)
    description_short = db.Column(db.String(100), nullable=False)
    description_detailed = db.Column(db.Text, nullable=False)

    def __init__(self, rating: str, description_short: str, description_detailed: str):
        self.rating = rating
        self.description_short = description_short
        self.description_detailed = description_detailed

    def serialize(self):
        return {
            'rating_id': self.rating_id,
            'rating': self.rating,
            'description_short': self.description_short,
            'description_detailed': self.description_detailed
        }


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

    def __init__(self, title: str, year: int, length_min: int, studio: str, format_id: int, resolution_id: int, rating_id: int, cover: str, movie: str, movie_subtitles: str, summary: str):
        self.title = title
        self.year = year
        self.length_min = length_min
        self.studio = studio
        self.format_id = format_id
        self.resolution_id = resolution_id
        self.rating_id = rating_id
        self.cover = cover
        self.movie = movie
        self.movie_subtitles = movie_subtitles
        self.summary = summary

    def serialize(self):
        return {
            'movie_id': self.movie_id,
            'title': self.title,
            'year': self.year,
            'length_min': self.length_min,
            'studio': self.studio,
            'format_id': self.format_id,
            'resolution_id': self.resolution_id,
            'rating_id': self.rating_id,
            'cover': self.cover,
            'movie': self.movie,
            'movie_subtitles': self.movie_subtitles,
            'summary': self.summary
        }


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

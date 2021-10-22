from enum import unique
from flask_sqlalchemy import SQLAlchemy

db = SQLAlchemy()

# Reference:
# https://flask-sqlalchemy.palletsprojects.com/en/2.x/models/
# https://docs.sqlalchemy.org/en/14/core/metadata.html#sqlalchemy.schema.Column
# https://flask-sqlalchemy.palletsprojects.com/en/2.x/models/#many-to-many-relationships


class Trailer(db.Model):
    __tablename__ = 'trailers'
    trailer_id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    trailer_url = db.Column(dt.Text, nullable=False)
    trailer_name = db.Column(db.String(100), nullable=False)


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
    username = db.Column(db.String(15),unique=True, nullable=False)
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
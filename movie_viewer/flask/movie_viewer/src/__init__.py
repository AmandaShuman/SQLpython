import os
from flask import Flask
from flask_migrate import Migrate

# https://flask.palletsprojects.com/en/2.0.x/patterns/appfactories/


def create_app(test_config=None):
    app = Flask(__name__, instance_relative_config=True)
    app.config.from_mapping(
        SECRET_KEY='dev',
        SQLALCHEMY_DATABASE_URI='postgresql://postgres@localhost:5432/movie_viewer',
        SQLALCHEMY_TRACK_MODIFICATIONS=False,
        SQLALCHEMY_ECHO=True
    )

    if test_config is None:
        # load the instance config, if it exists, when not testing
        app.config.from_pyfile('config.py', silent=True)
    else:
        # load the test config if passed in
        app.config.from_mapping(test_config)

    # ensure the instance folder exists
    try:
        os.makedirs(app.instance_path)
    except OSError:
        pass

    from .models import db
    db.init_app(app)
    migrate = Migrate(app, db)

    from .api import actors, awards, directors, formats, genres, movies, mpa_ratings, resolutions, trailers, users
    app.register_blueprint(actors.bp)
    app.register_blueprint(awards.bp)
    app.register_blueprint(directors.bp)
    app.register_blueprint(formats.bp)
    app.register_blueprint(genres.bp)
    app.register_blueprint(movies.bp)
    app.register_blueprint(mpa_ratings.bp)
    app.register_blueprint(resolutions.bp)
    app.register_blueprint(trailers.bp)
    app.register_blueprint(users.bp)

    return app

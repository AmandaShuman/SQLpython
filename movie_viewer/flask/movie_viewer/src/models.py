from flask_sqlalchemy import SQLAlchemy

db = SQLAlchemy()

# Reference:
# https://flask-sqlalchemy.palletsprojects.com/en/2.x/models/
# https://docs.sqlalchemy.org/en/14/core/metadata.html#sqlalchemy.schema.Column
# https://flask-sqlalchemy.palletsprojects.com/en/2.x/models/#many-to-many-relationships

class Actor(db.Model):
    __tablename__='actors'
    actor_id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    first_name = db.Column(db.string(50), nullable=False)
    last_name = db.Column(db.string(50), nullable=False)
    gender = db.Column(db.string(10))
    birth_date = db.Column(db.date)
    picture = db.Column(db.string())

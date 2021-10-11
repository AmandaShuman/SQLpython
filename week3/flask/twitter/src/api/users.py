from flask import Blueprint, json, jsonify, abort, request
from ..models import User, Tweet, likes_table, db
import sqlalchemy
import hashlib
import secrets


def scramble(password: str):
    """Hash and salt the given password"""
    salt = secrets.token_hex(16)
    return hashlib.sha512((password + salt).encode('utf-8')).hexdigest()


bp = Blueprint('users', __name__, url_prefix='/users')


@bp.route('', methods=['GET'])
def index():
    users = User.query.all()
    result = []
    for u in users:
        result.append(u.serialize())
    return jsonify(result)


@bp.route('/<int:id>', methods=['GET'])
def show(id: int):
    u = User.query.get_or_404(id)
    return jsonify(u.serialize())

# returns all the tweets a user likes
@bp.route('/<int:id>/liked_tweets', methods=['GET'])
def liked_tweets(id: int):
    u = User.query.get_or_404(id)
    result = []
    for t in u.liked_tweets:
        result.append(t.serialize())
    return jsonify(result)


@bp.route('', methods=['POST'])
def create():
    if 'username' not in request.json or 'password' not in request.json:
        return abort(400)
    if len(request.json['username']) < 3:
        return abort(400)
    if len(request.json['password']) < 8:
        return abort(400)

    u = User(
        username=request.json['username'],
        # scramble the password after pulling from json
        password=scramble(request.json['password'])
    )
    
    db.session.add(u)
    db.session.commit()
    return jsonify(u.serialize())

# Bonus task 1
@bp.route('/<int:id>/likes', methods=['POST'])
def like(id: int):
    if 'tweet_id' not in request.json:
        return abort(400)
    u = User.query.get_or_404(id)
    t = Tweet.query.get_or_404(request.json['tweet_id'])
    stmt = sqlalchemy.insert(likes_table).values(
        tweet_id=t.id, user_id=u.id)
    try:
        # compiling & executing the sql stmt based off the ORM notation
        db.session.execute(stmt)
        # adding the values to the table
        db.session.commit()
        return jsonify(True)
    except:
        return jsonify(False)


@bp.route('/<int:user_id>/likes/<int:tweet_id>', methods=['DELETE'])
def unlike(user_id: int, tweet_id: int):
    User.query.get_or_404(user_id)
    Tweet.query.get_or_404(tweet_id)
    stmt = sqlalchemy.delete(likes_table).where(
        sqlalchemy.and_(
            likes_table.c.user_id == user_id,
            likes_table.c.tweet_id == tweet_id
            )
    )
    try:
        db.session.execute(stmt)
        db.session.commit()
        return jsonify(True)
    except:
        return jsonify(False)


@bp.route('/<int:id>', methods=['DELETE'])
def delete(id: int):
    u = User.query.get_or_404(id)
    try:
        db.session.delete(u)
        db.session.commit()
        return jsonify(True)
    except:
        return jsonify(False)


@bp.route('/<int:id>', methods=['PATCH'])
def update(id: int):
    u = User.query.get_or_404(id)
    # how to create error if user doesn't change anything?
    if 'username' in request.json:
        u.username=request.json['username']
    if 'password' in request.json:
        u.password=scramble(request.json['password'])
    try:
        db.session.commit()
        return jsonify(True)
    except:
        return jsonify(False)



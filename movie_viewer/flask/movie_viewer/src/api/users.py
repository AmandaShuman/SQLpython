from flask import Blueprint, jsonify, abort, request
from ..models import User, db
import hashlib
import secrets


def scramble(password: str):
    """Hash and salt the given password"""
    salt = secrets.token_hex(16)
    return hashlib.sha512((password + salt).encode('utf-8')).hexdigest()


bp = Blueprint('users', __name__, url_prefix='/users')


@bp.app_errorhandler(400)
def bad_request(error):
    return jsonify({
        "success": False,
        "error": 400,
        "message": "Bad Request"
    }), 400


@bp.route('', methods=['GET'])
def index():
    users = User.query.all()
    result = []
    try:
        for u in users:
            result.append(u.serialize())
        return jsonify(result)
    except:
        return abort(400)


@bp.route('/<int:id>', methods=['GET'])
def show(id: int):
    u = User.query.get_or_404(id)
    try:
        return jsonify(u.serialize())
    except:
        return abort(400)


@bp.route('', methods=['POST'])
def create():
    if 'username' not in request.json or 'password' not in request.json or 'email' not in request.json or 'age' not in request.json:
        return abort(400)
    if len(request.json['username']) < 3:
        return abort(400)
    if len(request.json['password']) < 8:
        return abort(400)
    """ if request.json['age'] < 18:
        return abort(400) """

    username = request.json['username']
    # scramble the password after pulling from json
    password = scramble(request.json['password'])
    email = request.json['email']
    age = request.json['age']
    if 'first_name' in request.json:
        first_name = request.json['first_name']
    else:
        first_name = None
    if 'last_name' in request.json:
        last_name = request.json['last_name']
    else:
        last_name = None
    if 'gender' in request.json:
        gender = request.json['gender']
    else:
        gender = None
    if 'birth_date' in request.json:
        birth_date = request.json['birth_date']
    else:
        birth_date = None
    if 'profile_pic' in request.json:
        profile_pic = request.json['profile_pic']
    else:
        profile_pic = None
    try:
        u = User(
            username,
            password,
            email,
            first_name,
            last_name,
            gender,
            birth_date,
            profile_pic,
            age
        )

        db.session.add(u)
        db.session.commit()
        return jsonify(u.serialize())
    except:
        return abort(400)


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
    # can make changes to password, email, first_name, last_name, gender,    birth_date, profile_pic, age
    if 'password' in request.json:
        u.password = scramble(request.json['password'])
    if 'email' in request.json:
        u.email = request.json['email']
    if 'first_name' in request.json:
        u.first_name = request.json['first_name']
    if 'last_name' in request.json:
        u.last_name = request.json['last_name']
    if 'gender' in request.json:
        u.gender = request.json['gender']
    if 'birth_date' in request.json:
        u.birth_date = request.json['birth_date']
    if 'profile_pic' in request.json:
        u.profile_pic = request.json['profile_pic']
    if 'age' in request.json:
        u.age = request.json['age']
    try:
        db.session.commit()
        return jsonify(True)
    except:
        return jsonify(False)

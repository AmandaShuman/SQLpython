from flask import Blueprint, jsonify, abort, request
from ..models import Actor, db

bp = Blueprint('actors', __name__, url_prefix='/actors')


@bp.app_errorhandler(400)
def bad_request(error):
    return jsonify({
        "success": False,
        "error": 400,
        "message": "Bad Request"
    }), 400


@bp.route('', methods=['GET'])
def index():
    try:
        actors = Actor.query.all()
        result = []
        for a in actors:
            result.append(a.serialize())
        return jsonify(result)
    except:
        return abort(400)


@bp.route('/<int:id>', methods=['GET'])
def show(id: int):
    a = Actor.query.get_or_404(id)
    try:
        return jsonify(a.serialize())
    except:
        return abort(400)


# figure out optional parameters
@bp.route('', methods=['POST'])
def create():
    if 'first_name' not in request.json or 'last_name' not in request.json:
        return abort(400)

    first_name = request.json['first_name'],
    last_name = request.json['last_name'],
    if 'gender' in request.json:
        gender = request.json['gender']
    else: 
        gender = None
    if 'birth_date' in request.json:
        birth_date = request.json['birth_date']
    else:
        birth_date = None
    if 'picture' in request.json:
        picture = request.json['picture']
    else:
        picture = None
    a = Actor(
        first_name,
        last_name,
        gender,
        birth_date,
        picture,
    )
    db.session.add(a)
    db.session.commit()
    return jsonify(a.serialize())


# Test this route in insomnia
@bp.route('/<int:id>', methods=['DELETE'])
def delete(id: int):
    a = Actor.query.get_or_404(id)
    try:
        db.session.delete(a)
        db.session.commit()
        return jsonify(True)
    except:
        return jsonify(False)

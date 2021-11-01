from flask import Blueprint, jsonify, abort, request
from ..models import Director, db

bp = Blueprint('directors', __name__, url_prefix='/directors')


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
        directors = Director.query.all()
        result = []
        for d in directors:
            result.append(d.serialize())
        return jsonify(result)
    except:
        return abort(400)


@bp.route('/<int:id>', methods=['GET'])
def show(id: int):
    d = Director.query.get_or_404(id)
    try:
        return jsonify(d.serialize())
    except:
        return abort(400)


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
    d = Director(
        first_name,
        last_name,
        gender,
        birth_date,
        picture,
    )
    db.session.add(d)
    db.session.commit()
    return jsonify(d.serialize())


@bp.route('/<int:id>', methods=['DELETE'])
def delete(id: int):
    d = Director.query.get_or_404(id)
    try:
        db.session.delete(d)
        db.session.commit()
        return jsonify(True)
    except:
        return jsonify(False)

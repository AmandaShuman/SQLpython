from flask import Blueprint, jsonify, abort, request
from ..models import Genre, db

bp = Blueprint('genres', __name__, url_prefix='/genres')


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
        genres = Genre.query.all()
        result = []
        for g in genres:
            result.append(g.serialize())
        return jsonify(result)
    except:
        return abort(400)


@bp.route('/<int:id>', methods=['GET'])
def show(id: int):
    g = Genre.query.get_or_404(id)
    try:
        return jsonify(g.serialize())
    except:
        return abort(400)


@bp.route('', methods=['POST'])
def create():
    if 'genre' not in request.json:
        return abort(400)

    genre = request.json['genre'],
    if 'subgenre' in request.json:
        subgenre = request.json['subgenre']
    else:
        subgenre = None
    if 'description' in request.json:
        description = request.json['description']
    else:
        description = None
    g = Genre(
        genre,
        subgenre,
        description,
    )
    db.session.add(g)
    db.session.commit()
    return jsonify(g.serialize())


@bp.route('/<int:id>', methods=['DELETE'])
def delete(id: int):
    g = Genre.query.get_or_404(id)
    try:
        db.session.delete(g)
        db.session.commit()
        return jsonify(True)
    except:
        return jsonify(False)

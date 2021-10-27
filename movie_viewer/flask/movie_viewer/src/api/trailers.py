from flask import Blueprint, jsonify, abort, request
from ..models import Trailer, db

bp = Blueprint('trailers', __name__, url_prefix='/trailers')


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
        trailers = Trailer.query.all()
        result = []
        for t in trailers:
            result.append(t.serialize())
        return jsonify(result)
    except:
        return abort(400)


@bp.route('/<int:id>', methods=['GET'])
def show(id: int):
    t = Trailer.query.get_or_404(id)
    try:
        return jsonify(t.serialize())
    except:
        return abort(400)


@bp.route('', methods=['POST'])
def create():
    if 'trailer_url' not in request.json or 'trailer_name' not in request.json:
        return abort(400)
    try:
        t = Trailer(
            trailer_url=request.json['trailer_url'],
            trailer_name=request.json['trailer_name']
        )
        db.session.add(t)
        db.session.commit()
        return jsonify(t.serialize())
    except:
        return abort(400)
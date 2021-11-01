from flask import Blueprint, jsonify, abort, request
from ..models import Mpa_rating, db 

bp = Blueprint('mpa_ratings', __name__, url_prefix='/mpa_ratings')


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
        mpa_ratings = Mpa_rating.query.all()
        result = []
        for mpa in mpa_ratings:
            result.append(mpa.serialize())
        return jsonify(result)
    except:
        return abort(400)


@bp.route('/<int:id>', methods=['GET'])
def show(id: int):
    mpa = Mpa_rating.query.get_or_404(id)
    try:
        return jsonify(mpa.serialize())
    except:
        return abort(400)


@bp.route('', methods=['POST'])
def create():
    if 'rating' not in request.json or 'description_short' not in request.json or 'description_detailed' not in request.json:
        return abort(400)
    mpa = Mpa_rating(
        rating= request.json['rating'],
        description_short=request.json['description_short'],
        description_detailed=request.json['description_detailed']
    )
    db.session.add(mpa)
    db.session.commit()
    return jsonify(mpa.serialize())


@bp.route('/<int:id>', methods=['DELETE'])
def delete(id: int):
    mpa = Mpa_rating.query.get_or_404(id)
    try:
        db.session.delete(mpa)
        db.session.commit()
        return jsonify(True)
    except:
        return jsonify(False)

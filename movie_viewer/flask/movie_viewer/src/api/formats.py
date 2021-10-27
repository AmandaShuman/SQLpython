from flask import Blueprint, jsonify, abort, request
from ..models import Format, db

bp = Blueprint('formats', __name__, url_prefix='/formats')


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
        formats = Format.query.all()
        result = []
        for f in formats:
            result.append(f.serialize())
        return jsonify(result)
    except:
        return abort(400)


@bp.route('/<int:id>', methods=['GET'])
def show(id: int):
    f = Format.query.get_or_404(id)
    try:
        return jsonify(f.serialize())
    except:
        return abort(400)


@bp.route('', methods=['POST'])
def create():
    if 'extension' not in request.json:
        return abort(400)
    try:
        f = Format(
            extension=request.json['extension']
        )
        db.session.add(f)
        db.session.commit()
        return jsonify(f.serialize())
    except:
        return abort(400)


@bp.route('/<int:id>', methods=['DELETE'])
def delete(id: int):
    f = Format.query.get_or_404(id)
    try:
        db.session.delete(f)
        db.session.commit()
        return jsonify(True)
    except:
        return jsonify(False)

from flask import Blueprint, jsonify, abort, request
from ..models import Award, db

bp = Blueprint('awards', __name__, url_prefix='/awards')


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
        awards = Award.query.all()
        result = []
        for a in awards:
            result.append(a.serialize())
        return jsonify(result)
    except:
        return abort(400)


@bp.route('/<int:id>', methods=['GET'])
def show(id: int):
    a = Award.query.get_or_404(id)
    try:
        return jsonify(a.serialize())
    except:
        return abort(400)


@bp.route('', methods=['POST'])
def create():
    if 'award' not in request.json:
        return abort(400)
    try:
        a = Award(
            award=request.json['award']
        )
        db.session.add(a)
        db.session.commit()
        return jsonify(a.serialize())
    except:
        return abort(400)


@bp.route('/<int:id>', methods=['DELETE'])
def delete(id: int):
    a = Award.query.get_or_404(id)
    try:
        db.session.delete(a)
        db.session.commit()
        return jsonify(True)
    except:
        return jsonify(False)

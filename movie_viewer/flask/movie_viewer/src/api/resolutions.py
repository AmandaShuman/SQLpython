from flask import Blueprint, jsonify, abort, request
from ..models import Resolution, db

bp = Blueprint('resolutions', __name__, url_prefix='/resolutions')


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
        resolutions = Resolution.query.all()
        result = []
        for r in resolutions:
            result.append(r.serialize())
        return jsonify(result)
    except:
        return abort(400)


@bp.route('/<int:id>', methods=['GET'])
def show(id: int):
    r = Resolution.query.get_or_404(id)
    try:
        return jsonify(r.serialize())
    except:
        return abort(400)


@bp.route('', methods=['POST'])
def create():
    if 'resolution' not in request.json or 'pixel_size' not in request.json or 'aspect_ratio' not in request.json or 'num_p' not in request.json:
        return abort(400)
    try:
        r = Resolution(
            resolution=request.json['resolution'],
            pixel_size=request.json['pixel_size'],
            aspect_ratio=request.json['aspect_ratio'],
            num_p=request.json['num_p']
        )
        db.session.add(r)
        db.session.commit()
        return jsonify(r.serialize())
    except:
        return abort(400)


@bp.route('/<int:id>', methods=['DELETE'])
def delete(id: int):
    r = Resolution.query.get_or_404(id)
    try:
        db.session.delete(r)
        db.session.commit()
        return jsonify(True)
    except:
        return jsonify(False)

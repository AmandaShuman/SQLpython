from flask import Blueprint, jsonify, abort, request
from ..models import Movie, db

bp = Blueprint('movies', __name__, url_prefix='/movies')

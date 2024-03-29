"""empty message

Revision ID: 4396f21a44d3
Revises: 
Create Date: 2021-10-21 22:13:04.343021

"""
from alembic import op
import sqlalchemy as sa
from sqlalchemy.dialects import postgresql

# revision identifiers, used by Alembic.
revision = '4396f21a44d3'
down_revision = None
branch_labels = None
depends_on = None


def upgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    op.drop_table('movie_ratings')
    op.drop_table('awards')
    op.drop_table('formats')
    op.drop_table('movies_genres')
    op.drop_table('movies_awards')
    op.drop_table('mpa_ratings')
    op.drop_table('directors')
    op.drop_table('movies_actors')
    op.drop_table('movies_directors')
    op.drop_table('movies_trailers')
    op.drop_table('trailers')
    op.drop_table('users')
    op.drop_table('genres')
    op.drop_table('movies')
    op.drop_table('resolutions')
    # ### end Alembic commands ###


def downgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    op.create_table('resolutions',
    sa.Column('resolution_id', sa.INTEGER(), server_default=sa.text("nextval('resolutions_resolution_id_seq'::regclass)"), autoincrement=True, nullable=False),
    sa.Column('resolution', sa.TEXT(), autoincrement=False, nullable=False),
    sa.Column('pixel_size', sa.TEXT(), autoincrement=False, nullable=False),
    sa.Column('aspect_ratio', sa.TEXT(), autoincrement=False, nullable=False),
    sa.Column('num_p', sa.TEXT(), autoincrement=False, nullable=True),
    sa.PrimaryKeyConstraint('resolution_id', name='resolutions_pkey'),
    postgresql_ignore_search_path=False
    )
    op.create_table('movies',
    sa.Column('movie_id', sa.INTEGER(), server_default=sa.text("nextval('movies_movie_id_seq'::regclass)"), autoincrement=True, nullable=False),
    sa.Column('title', sa.TEXT(), autoincrement=False, nullable=False),
    sa.Column('year', sa.INTEGER(), autoincrement=False, nullable=False),
    sa.Column('length_min', sa.TEXT(), autoincrement=False, nullable=False),
    sa.Column('studio', sa.TEXT(), autoincrement=False, nullable=True),
    sa.Column('format_id', sa.INTEGER(), autoincrement=False, nullable=False),
    sa.Column('resolution_id', sa.INTEGER(), autoincrement=False, nullable=False),
    sa.Column('rating_id', sa.INTEGER(), autoincrement=False, nullable=True),
    sa.Column('cover', sa.TEXT(), autoincrement=False, nullable=True),
    sa.Column('movie', sa.TEXT(), autoincrement=False, nullable=False),
    sa.Column('movie_subtitles', sa.TEXT(), autoincrement=False, nullable=True),
    sa.Column('summary', sa.TEXT(), autoincrement=False, nullable=True),
    sa.ForeignKeyConstraint(['format_id'], ['formats.format_id'], name='fk_movie_format'),
    sa.ForeignKeyConstraint(['rating_id'], ['mpa_ratings.rating_id'], name='fk_movie_rating'),
    sa.ForeignKeyConstraint(['resolution_id'], ['resolutions.resolution_id'], name='fk_movie_resolution'),
    sa.PrimaryKeyConstraint('movie_id', name='movies_pkey'),
    postgresql_ignore_search_path=False
    )
    op.create_table('genres',
    sa.Column('genre_id', sa.INTEGER(), server_default=sa.text("nextval('genres_genre_id_seq'::regclass)"), autoincrement=True, nullable=False),
    sa.Column('genre', sa.TEXT(), autoincrement=False, nullable=False),
    sa.Column('subgenre', sa.TEXT(), autoincrement=False, nullable=True),
    sa.Column('description', sa.TEXT(), autoincrement=False, nullable=True),
    sa.PrimaryKeyConstraint('genre_id', name='genres_pkey'),
    postgresql_ignore_search_path=False
    )
    op.create_table('users',
    sa.Column('user_id', sa.INTEGER(), server_default=sa.text("nextval('users_user_id_seq'::regclass)"), autoincrement=True, nullable=False),
    sa.Column('username', sa.TEXT(), autoincrement=False, nullable=False),
    sa.Column('password', sa.TEXT(), autoincrement=False, nullable=False),
    sa.Column('email', sa.VARCHAR(length=320), autoincrement=False, nullable=False),
    sa.Column('cell_phone', sa.VARCHAR(length=24), autoincrement=False, nullable=True),
    sa.Column('first_name', sa.TEXT(), autoincrement=False, nullable=True),
    sa.Column('last_name', sa.TEXT(), autoincrement=False, nullable=True),
    sa.Column('gender', sa.TEXT(), autoincrement=False, nullable=True),
    sa.Column('birth_date', sa.DATE(), autoincrement=False, nullable=True),
    sa.Column('profile_pic', sa.TEXT(), autoincrement=False, nullable=True),
    sa.Column('age', sa.INTEGER(), autoincrement=False, nullable=False),
    sa.PrimaryKeyConstraint('user_id', name='users_pkey'),
    sa.UniqueConstraint('cell_phone', name='users_cell_phone_key'),
    sa.UniqueConstraint('email', name='users_email_key'),
    sa.UniqueConstraint('username', name='users_username_key'),
    postgresql_ignore_search_path=False
    )
    op.create_table('trailers',
    sa.Column('trailer_id', sa.INTEGER(), server_default=sa.text("nextval('trailers_trailer_id_seq'::regclass)"), autoincrement=True, nullable=False),
    sa.Column('trailer_url', sa.TEXT(), autoincrement=False, nullable=False),
    sa.Column('trailer_name', sa.TEXT(), autoincrement=False, nullable=False),
    sa.PrimaryKeyConstraint('trailer_id', name='trailers_pkey'),
    postgresql_ignore_search_path=False
    )
    op.create_table('movies_trailers',
    sa.Column('trailer_id', sa.INTEGER(), autoincrement=False, nullable=False),
    sa.Column('movie_id', sa.INTEGER(), autoincrement=False, nullable=False),
    sa.ForeignKeyConstraint(['movie_id'], ['movies.movie_id'], name='fk_movie'),
    sa.ForeignKeyConstraint(['trailer_id'], ['trailers.trailer_id'], name='fk_trailer'),
    sa.PrimaryKeyConstraint('trailer_id', 'movie_id', name='movies_trailers_pkey')
    )
    op.create_table('movies_directors',
    sa.Column('director_id', sa.INTEGER(), autoincrement=False, nullable=False),
    sa.Column('movie_id', sa.INTEGER(), autoincrement=False, nullable=False),
    sa.ForeignKeyConstraint(['director_id'], ['directors.director_id'], name='fk_director'),
    sa.ForeignKeyConstraint(['movie_id'], ['movies.movie_id'], name='fk_movie'),
    sa.PrimaryKeyConstraint('director_id', 'movie_id', name='movies_directors_pkey')
    )
    op.create_table('movies_actors',
    sa.Column('actor_id', sa.INTEGER(), autoincrement=False, nullable=False),
    sa.Column('movie_id', sa.INTEGER(), autoincrement=False, nullable=False),
    sa.ForeignKeyConstraint(['actor_id'], ['actors.actor_id'], name='fk_actor'),
    sa.ForeignKeyConstraint(['movie_id'], ['movies.movie_id'], name='fk_movie'),
    sa.PrimaryKeyConstraint('actor_id', 'movie_id', name='movies_actors_pkey')
    )
    op.create_table('directors',
    sa.Column('director_id', sa.INTEGER(), autoincrement=True, nullable=False),
    sa.Column('first_name', sa.TEXT(), autoincrement=False, nullable=False),
    sa.Column('last_name', sa.TEXT(), autoincrement=False, nullable=False),
    sa.Column('gender', sa.TEXT(), autoincrement=False, nullable=True),
    sa.Column('birth_date', sa.DATE(), autoincrement=False, nullable=True),
    sa.Column('picture', sa.TEXT(), autoincrement=False, nullable=True),
    sa.PrimaryKeyConstraint('director_id', name='directors_pkey')
    )
    op.create_table('mpa_ratings',
    sa.Column('rating_id', sa.INTEGER(), server_default=sa.text("nextval('mpa_ratings_rating_id_seq'::regclass)"), autoincrement=True, nullable=False),
    sa.Column('rating', sa.TEXT(), autoincrement=False, nullable=False),
    sa.Column('description_short', sa.TEXT(), autoincrement=False, nullable=False),
    sa.Column('description_detailed', sa.TEXT(), autoincrement=False, nullable=False),
    sa.PrimaryKeyConstraint('rating_id', name='mpa_ratings_pkey'),
    postgresql_ignore_search_path=False
    )
    op.create_table('movies_awards',
    sa.Column('award_id', sa.INTEGER(), autoincrement=False, nullable=False),
    sa.Column('movie_id', sa.INTEGER(), autoincrement=False, nullable=False),
    sa.ForeignKeyConstraint(['award_id'], ['awards.award_id'], name='fk_award'),
    sa.ForeignKeyConstraint(['movie_id'], ['movies.movie_id'], name='fk_movie'),
    sa.PrimaryKeyConstraint('award_id', 'movie_id', name='movies_awards_pkey')
    )
    op.create_table('movies_genres',
    sa.Column('genre_id', sa.INTEGER(), autoincrement=False, nullable=False),
    sa.Column('movie_id', sa.INTEGER(), autoincrement=False, nullable=False),
    sa.ForeignKeyConstraint(['genre_id'], ['genres.genre_id'], name='fk_genre'),
    sa.ForeignKeyConstraint(['movie_id'], ['movies.movie_id'], name='fk_movie'),
    sa.PrimaryKeyConstraint('genre_id', 'movie_id', name='movies_genres_pkey')
    )
    op.create_table('formats',
    sa.Column('format_id', sa.INTEGER(), server_default=sa.text("nextval('formats_format_id_seq'::regclass)"), autoincrement=True, nullable=False),
    sa.Column('extension', sa.TEXT(), autoincrement=False, nullable=False),
    sa.PrimaryKeyConstraint('format_id', name='formats_pkey'),
    postgresql_ignore_search_path=False
    )
    op.create_table('awards',
    sa.Column('award_id', sa.INTEGER(), autoincrement=True, nullable=False),
    sa.Column('award', sa.TEXT(), autoincrement=False, nullable=False),
    sa.PrimaryKeyConstraint('award_id', name='awards_pkey')
    )
    op.create_table('movie_ratings',
    sa.Column('user_id', sa.INTEGER(), autoincrement=False, nullable=False),
    sa.Column('movie_id', sa.INTEGER(), autoincrement=False, nullable=False),
    sa.Column('rating', sa.NUMERIC(), autoincrement=False, nullable=False),
    sa.Column('rating_date', postgresql.TIMESTAMP(), autoincrement=False, nullable=True),
    sa.ForeignKeyConstraint(['movie_id'], ['movies.movie_id'], name='fk_movie'),
    sa.ForeignKeyConstraint(['user_id'], ['users.user_id'], name='fk_user'),
    sa.PrimaryKeyConstraint('user_id', 'movie_id', name='movie_ratings_pkey')
    )
    # ### end Alembic commands ###

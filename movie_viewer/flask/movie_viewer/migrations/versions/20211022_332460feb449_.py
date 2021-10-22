"""empty message

Revision ID: 332460feb449
Revises: 4396f21a44d3
Create Date: 2021-10-22 16:45:26.360930

"""
from alembic import op
import sqlalchemy as sa
from sqlalchemy.dialects import postgresql

# revision identifiers, used by Alembic.
revision = '332460feb449'
down_revision = '4396f21a44d3'
branch_labels = None
depends_on = None


def upgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    op.create_table('MPA_ratings',
    sa.Column('rating_id', sa.Integer(), autoincrement=True, nullable=False),
    sa.Column('rating', sa.String(length=10), nullable=False),
    sa.Column('description_short', sa.String(length=100), nullable=True),
    sa.Column('description_detailed', sa.Text(), nullable=True),
    sa.PrimaryKeyConstraint('rating_id')
    )
    op.drop_table('movies_actors')
    op.drop_table('movies_trailers')
    op.drop_table('movies_genres')
    op.drop_table('mpa_ratings')
    op.drop_table('movie_ratings')
    op.drop_table('movies_awards')
    op.drop_table('movies_directors')
    op.alter_column('movies', 'rating_id',
               existing_type=sa.INTEGER(),
               nullable=False)
    op.drop_constraint('fk_movie_rating', 'movies', type_='foreignkey')
    op.create_foreign_key(None, 'movies', 'MPA_ratings', ['rating_id'], ['rating_id'])
    op.add_column('resolutions', sa.Column('resoution', sa.String(length=40), nullable=False))
    op.drop_column('resolutions', 'resolution')
    op.drop_constraint('users_cell_phone_key', 'users', type_='unique')
    op.drop_column('users', 'cell_phone')
    # ### end Alembic commands ###


def downgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    op.add_column('users', sa.Column('cell_phone', sa.VARCHAR(length=24), autoincrement=False, nullable=True))
    op.create_unique_constraint('users_cell_phone_key', 'users', ['cell_phone'])
    op.add_column('resolutions', sa.Column('resolution', sa.TEXT(), autoincrement=False, nullable=False))
    op.drop_column('resolutions', 'resoution')
    op.drop_constraint(None, 'movies', type_='foreignkey')
    op.create_foreign_key('fk_movie_rating', 'movies', 'mpa_ratings', ['rating_id'], ['rating_id'])
    op.alter_column('movies', 'rating_id',
               existing_type=sa.INTEGER(),
               nullable=True)
    op.create_table('movies_directors',
    sa.Column('director_id', sa.INTEGER(), autoincrement=False, nullable=False),
    sa.Column('movie_id', sa.INTEGER(), autoincrement=False, nullable=False),
    sa.ForeignKeyConstraint(['director_id'], ['directors.director_id'], name='fk_director'),
    sa.ForeignKeyConstraint(['movie_id'], ['movies.movie_id'], name='fk_movie'),
    sa.PrimaryKeyConstraint('director_id', 'movie_id', name='movies_directors_pkey')
    )
    op.create_table('movies_awards',
    sa.Column('award_id', sa.INTEGER(), autoincrement=False, nullable=False),
    sa.Column('movie_id', sa.INTEGER(), autoincrement=False, nullable=False),
    sa.ForeignKeyConstraint(['award_id'], ['awards.award_id'], name='fk_award'),
    sa.ForeignKeyConstraint(['movie_id'], ['movies.movie_id'], name='fk_movie'),
    sa.PrimaryKeyConstraint('award_id', 'movie_id', name='movies_awards_pkey')
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
    op.create_table('mpa_ratings',
    sa.Column('rating_id', sa.INTEGER(), server_default=sa.text("nextval('mpa_ratings_rating_id_seq'::regclass)"), autoincrement=True, nullable=False),
    sa.Column('rating', sa.TEXT(), autoincrement=False, nullable=False),
    sa.Column('description_short', sa.TEXT(), autoincrement=False, nullable=False),
    sa.Column('description_detailed', sa.TEXT(), autoincrement=False, nullable=False),
    sa.PrimaryKeyConstraint('rating_id', name='mpa_ratings_pkey'),
    postgresql_ignore_search_path=False
    )
    op.create_table('movies_genres',
    sa.Column('genre_id', sa.INTEGER(), autoincrement=False, nullable=False),
    sa.Column('movie_id', sa.INTEGER(), autoincrement=False, nullable=False),
    sa.ForeignKeyConstraint(['genre_id'], ['genres.genre_id'], name='fk_genre'),
    sa.ForeignKeyConstraint(['movie_id'], ['movies.movie_id'], name='fk_movie'),
    sa.PrimaryKeyConstraint('genre_id', 'movie_id', name='movies_genres_pkey')
    )
    op.create_table('movies_trailers',
    sa.Column('trailer_id', sa.INTEGER(), autoincrement=False, nullable=False),
    sa.Column('movie_id', sa.INTEGER(), autoincrement=False, nullable=False),
    sa.ForeignKeyConstraint(['movie_id'], ['movies.movie_id'], name='fk_movie'),
    sa.ForeignKeyConstraint(['trailer_id'], ['trailers.trailer_id'], name='fk_trailer'),
    sa.PrimaryKeyConstraint('trailer_id', 'movie_id', name='movies_trailers_pkey')
    )
    op.create_table('movies_actors',
    sa.Column('actor_id', sa.INTEGER(), autoincrement=False, nullable=False),
    sa.Column('movie_id', sa.INTEGER(), autoincrement=False, nullable=False),
    sa.ForeignKeyConstraint(['actor_id'], ['actors.actor_id'], name='fk_actor'),
    sa.ForeignKeyConstraint(['movie_id'], ['movies.movie_id'], name='fk_movie'),
    sa.PrimaryKeyConstraint('actor_id', 'movie_id', name='movies_actors_pkey')
    )
    op.drop_table('MPA_ratings')
    # ### end Alembic commands ###

"""empty message

Revision ID: 939693e1678b
Revises: 46d674a68a22
Create Date: 2024-04-23 11:17:51.548571

"""
from typing import Sequence, Union

from alembic import op
import sqlalchemy as sa


# revision identifiers, used by Alembic.
revision: str = '939693e1678b'
down_revision: Union[str, None] = '46d674a68a22'
branch_labels: Union[str, Sequence[str], None] = None
depends_on: Union[str, Sequence[str], None] = None


def upgrade() -> None:
    # ### commands auto generated by Alembic - please adjust! ###
    op.create_table('noti',
    sa.Column('noti_id', sa.Integer(), autoincrement=True, nullable=False),
    sa.Column('user_id', sa.Integer(), nullable=True),
    sa.Column('connect_id', sa.Integer(), nullable=True),
    sa.Column('noti_title', sa.String(length=255), nullable=True),
    sa.Column('noti_content', sa.String(length=2555), nullable=True),
    sa.Column('created_at', sa.DateTime(), nullable=True),
    sa.ForeignKeyConstraint(['connect_id'], ['connect.connect_id'], ),
    sa.ForeignKeyConstraint(['user_id'], ['user.user_id'], ),
    sa.PrimaryKeyConstraint('noti_id'),
    sa.UniqueConstraint('connect_id'),
    sa.UniqueConstraint('noti_id'),
    sa.UniqueConstraint('user_id')
    )
    # ### end Alembic commands ###


def downgrade() -> None:
    # ### commands auto generated by Alembic - please adjust! ###
    op.drop_table('noti')
    # ### end Alembic commands ###

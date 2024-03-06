"""empty message

Revision ID: 3b91bb98d648
Revises: c896dc1d6661
Create Date: 2024-03-25 10:26:23.799501

"""
from typing import Sequence, Union

from alembic import op
import sqlalchemy as sa


# revision identifiers, used by Alembic.
revision: str = '3b91bb98d648'
down_revision: Union[str, None] = 'c896dc1d6661'
branch_labels: Union[str, Sequence[str], None] = None
depends_on: Union[str, Sequence[str], None] = None


def upgrade() -> None:
    # ### commands auto generated by Alembic - please adjust! ###
    op.add_column('responser', sa.Column('best_way_fir', sa.String(length=255), nullable=True))
    op.add_column('responser', sa.Column('best_way_sec', sa.String(length=255), nullable=True))
    op.add_column('responser', sa.Column('best_way_thd', sa.String(length=255), nullable=True))
    op.drop_column('responser', 'best_way')
    # ### end Alembic commands ###


def downgrade() -> None:
    # ### commands auto generated by Alembic - please adjust! ###
    op.add_column('responser', sa.Column('best_way', sa.VARCHAR(length=255), nullable=True))
    op.drop_column('responser', 'best_way_thd')
    op.drop_column('responser', 'best_way_sec')
    op.drop_column('responser', 'best_way_fir')
    # ### end Alembic commands ###
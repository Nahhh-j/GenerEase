from sqlalchemy.orm import Session
from model.models import Noti, User


def get_noti(db: Session, id: str):
    user_noti_list = db.query(Noti).filter(Noti.user_id == id).all()
    return user_noti_list
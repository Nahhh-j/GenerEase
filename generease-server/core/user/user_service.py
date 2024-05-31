import json
from fastapi import Depends
from sqlalchemy.orm import Session
from util.constants import ROLE
from util.http_error import http_bad_request_check, http_success_check
from util.util import get_now, issued_hash, issued_token, make_nickname
from model.database import get_db
from model.models import User

from schema.user.user_schema import CreateUser

def create_user(db: Session, user_info: CreateUser):
    db_user = User(
        username = user_info.username,
        nickname = make_nickname(),
        password_hash = issued_hash(),
        birth = user_info.birth,
        phone_no = user_info.phone_no,
        role = ROLE.NORMAL,
        created_at = get_now())
    db.add(db_user)
    db.commit()

def get_user(db: Session, phone_no: str):
    return db.query(User).filter(User.phone_no == phone_no).first()

def get_exist_user(db: Session, _user_info: CreateUser):
    exist_user = db.query(User).filter(
        (User.phone_no == _user_info.phone_no) 
    ).first()
    return exist_user

def get_exist_user_by_data(db: Session, _data: str, key: str):
    return db.query(User).filter(
        getattr(User, key) == _data
    ).first()

def del_user(phone_no, db: Session):
    user = db.query(User).filter(User.phone_no == phone_no).first()
    if user is None:
        raise http_bad_request_check()
    db.query(User).filter(User.user_id == user.user_id).delete()
    db.commit()
    return http_success_check(200)

    
    
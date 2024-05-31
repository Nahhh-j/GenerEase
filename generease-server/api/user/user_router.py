from fastapi import APIRouter, Depends
from fastapi.security import HTTPBearer
from sqlalchemy.orm import Session
from api.auth.auth_router import current_user
from model.models import User
from model import database
from core.user import user_service
from util.http_error import http_bad_request_check, http_server_error_check


router = APIRouter(
    prefix="/user",
    tags=["유저"]
)

@router.post("/user_manage", summary="계정/정보 관리(AUTH)")
def user_manage(db: Session = Depends(database.get_db), _user: User = Depends(current_user)):
    try:
        user = user_service.get_user(db, phone_no = _user.phone_no)
        return {
            "username": user.username,
            "user_img": user.user_img,
            "phone_no": user.phone_no,
            "birth": user.birth
        }
    except:
        return http_server_error_check()

@router.delete("/user_delete/{phone_no}", summary="유저 삭제", description="")
def user_delete(phone_no: str, token: str = Depends(HTTPBearer()), db: Session= Depends(database.get_db)):
    try:
       user_service.del_user(phone_no, db)
    except: 
       return http_bad_request_check()


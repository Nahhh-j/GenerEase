from datetime import timedelta
from fastapi import APIRouter, Depends, HTTPException
from fastapi.security import HTTPBearer
from core.auth.auth_service import ALGORITHM, SECRET_KEY, decode_token, issue_access, issue_refresh
from util import error
from model.models import Requester, User

# https://dev-blackcat.tistory.com/7
# https://mopil.tistory.com/182

from sqlalchemy.orm import Session

from model import database
from model import models

from starlette import status

from schema.user.user_schema import CreateUser, LoginUser
from core.user import user_service
from core.auth import auth_service
from core.connect import connect_service
from core.requester import requester_service
from core.responser import responser_service

from jose import jwt, JWTError

from util.constants import ROLE

router = APIRouter(
    prefix="/auth",
    tags=["인증"]
)

# NO-AUTH
# 회원가입 라우터:
@router.post("/register", status_code=status.HTTP_200_OK, summary="회원가입(NO AUTH)")
def create_user(_user_info: CreateUser, db: Session = Depends(database.get_db)):
    auth_service.send_sms()
    
    # 추후 핸드폰번호 인증을 이 사이 추가.
    user = user_service.get_exist_user(db, _user_info)
    if user:
        raise HTTPException(status_code= status.HTTP_500_INTERNAL_SERVER_ERROR,
                            detail="이미 존재하는 유저의 핸드폰 번호")
    user_service.create_user(db, _user_info)

# NO-AUTH
# 로그인 라우터;
@router.post("/login", summary="로그인(NO AUTH)")
def login_user(_user_info: LoginUser, db: Session = Depends(database.get_db)):
    # 추후 핸드폰번호 인증을 이 사이 추가.
    user = user_service.get_user(db, phone_no=_user_info.phone_no)
    if not user:
        raise error.credentials_exception
    return {
        "access_token": issue_access(user.phone_no),
        "refresh_token": issue_refresh(user.phone_no),
        "username": user.username,
        "user_img": user.user_img,
        "role": user.role,
    }

# 앱 실행 시 호출(401이면, 로그인으로)
@router.post("/refresh", summary="토큰 재발급 또는 자동로그인-ALL(AUTH)")
def refresh_user(refresh_token: str = Depends(HTTPBearer()), db: Session = Depends(database.get_db)):
    try:
        # phone_no = decode_token(refresh_token)
        payload = jwt.decode(refresh_token.credentials, SECRET_KEY, algorithms=[ALGORITHM])
         # type : Bearer, credentails: token
        phone_no: str = payload.get("sub")
        if phone_no is None:
            raise error.credentials_exception
    except JWTError:
        raise error.credentials_exception
    user = user_service.get_user(db, phone_no)
    if user is None:
        raise error.credentials_exception
    
    return {
        "access_token": issue_access(user.phone_no),
        "refresh_token": issue_refresh(user.phone_no),
        "nickname": user.nickname
    }    

def current_user (token: str = Depends(HTTPBearer()), db: Session = Depends(database.get_db)):
    credentials_exception = HTTPException(
        status_code=status.HTTP_401_UNAUTHORIZED,
        detail="Could not validate credentials",
        headers={"WWW-Authenticate": "Bearer"},
    )
    try:
        payload = jwt.decode(token.credentials, SECRET_KEY, algorithms=[ALGORITHM])
         # type : Bearer, credentails: token
        phone_no: str = payload.get("sub")
        print(phone_no)
        if phone_no is None:
            raise error.credentials_exception
    except JWTError:
        raise error.credentials_exception
    else:
        user = user_service.get_user(db, phone_no=phone_no)
        if user is None:
            raise credentials_exception
        return user
    
from datetime import timedelta
from fastapi import APIRouter, Depends, HTTPException
from fastapi.security import HTTPBearer
from core.auth.auth_service import ALGORITHM, SECRET_KEY, decode_token, issue_access, issue_refresh
from util import error

# https://dev-blackcat.tistory.com/7
# https://mopil.tistory.com/182

from sqlalchemy.orm import Session

from model import database
from model import models

from starlette import status

from schema.user.user_schema import CreateUser, LoginUser
from core.user import user_service

from jose import jwt, JWTError

# from schema.user_schema import CreateUser

router = APIRouter(
    prefix="/auth",
    tags=["인증"]
)

# oauth2_scheme = Oauth2PasswordBearer()
# oauth2_scheme을 Oauth2PasswordBearer로 할 시에, 불필요한 Input 추가

# NO-AUTH
@router.post("/register", status_code=status.HTTP_204_NO_CONTENT)
def create_user(_user_info: CreateUser, db: Session = Depends(database.get_db)):
    # 추후 핸드폰번호 인증을 이 사이 추가.
    user = user_service.get_exist_user(db, _user_info)
    if user:
        raise HTTPException(status_code= status.HTTP_409_CONFLICT,
                            detail="존재계정")
    user_service.create_user(db, _user_info)

# NO-AUTH
@router.post("/login")
def login_user(_user_info: LoginUser, db: Session = Depends(database.get_db)):
    # 추후 핸드폰번호 인증을 이 사이 추가.
    user = user_service.get_user(db, phone_no=_user_info.phone_no)
    if not user:
        raise error.credentials_exception
    return {
        "access_token": issue_access(user.phone_no),
        "refresh_token": issue_refresh(user.phone_no),
        "nickname": user.nickname
    }
# 앱 실행 시 호출(401이면, 로그인으로)
@router.post("/refresh")
def refresh_user(refresh_token: str = Depends(HTTPBearer()), db: Session = Depends(database.get_db)):
    try:
        phone_no = decode_token(refresh_token)
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
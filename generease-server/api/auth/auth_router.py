from datetime import timedelta
from fastapi import APIRouter, Depends, HTTPException
from fastapi.security import HTTPBearer
from core.auth.auth_service import ALGORITHM, SECRET_KEY, decode_token, issue_access, issue_refresh
from util import error
from model.models import Requester, User, Auth
from sdk.api.message import Message
from sdk.exceptions import CoolsmsException

# https://dev-blackcat.tistory.com/7
# https://mopil.tistory.com/182

from sqlalchemy.orm import Session

from model import database
from model import models

from starlette import status

from schema.user.user_schema import CreateUser, LoginUser, RegisterUser
from core.user import user_service
from core.auth import auth_service
from core.connect import connect_service
from core.requester import requester_service
from core.responser import responser_service

from jose import jwt, JWTError

from util.constants import ROLE

from random import randint

router = APIRouter(
    prefix="/auth",
    tags=["인증"]
)

# 회원가입1: post 전화번호만 입력하면 랜덤 인증번호 4자리 전송
@router.post("/register", status_code=status.HTTP_200_OK, summary="회원가입1: 전화번호 입력 후 랜덤 인증번호 전송")
def create_user(_user_info: RegisterUser, db: Session = Depends(database.get_db)):
    # 랜덤 인증번호 생성
    auth_code = auth_service.generate_auth_code()

    # 생성된 인증번호 DB에 저장
    auth_data = Auth(phone_no=_user_info.phone_no, auth_code=auth_code)
    db.add(auth_data)
    db.commit()

    # 사용자가 입력한 핸드폰 번호로 SMS 전송
    auth_service.send_sms(_user_info.phone_no, f"인증번호는 {auth_code}입니다. 회원가입을 진행해주세요!")

    return {"message": "인증번호가 전송되었습니다."}

# 회원가입2: 전화번호의 랜덤 인증번호 auth가 db에 저장되어 같은 인증번호를 사용자가 입력하고 성공
@router.post("/verify", status_code=status.HTTP_200_OK, summary="회원가입2: 인증번호 확인")
def verify_auth_code(data: dict, db: Session = Depends(database.get_db)):
    phone_no = data.get("phone_no")
    auth_code = data.get("auth_code")

    # DB에서 해당 전화번호의 인증번호 조회
    auth_data = db.query(Auth).filter(Auth.phone_no == phone_no).first()
    if not auth_data:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail="인증번호가 발급되지 않았습니다.")

    # 사용자가 입력한 인증번호와 DB에 저장된 인증번호 일치 여부 확인
    if auth_data.auth_code == auth_code:
        return {"message": "인증 성공!"}
    else:
        raise HTTPException(status_code=status.HTTP_400_BAD_REQUEST, detail="인증번호가 일치하지 않습니다.")

# 회원가입3: 인증 성공한 사용자는 "username"과 "birth"를 입력할 수 있음. 양식에 맞게 완료하면 user테이블에 저장되며 회원가입 완료
@router.post("/register-complete", status_code=status.HTTP_200_OK, summary="회원가입3: 정보 입력 후 회원가입 완료")
def complete_registration(data: dict, db: Session = Depends(database.get_db)):
    username = data.get("username")
    birth = data.get("birth")
    phone_no = data.get("phone_no")

    # 사용자 정보 생성
    user_info = CreateUser(username=username, phone_no=phone_no, birth=birth)

    # 회원가입
    user_service.create_user(db, user_info)

    return {"message": "회원가입이 완료되었습니다."}

# # NO-AUTH
# # 회원가입 라우터:
# @router.post("/register", status_code=status.HTTP_200_OK, summary="회원가입(NO AUTH)")
# def create_user(_user_info: CreateUser, db: Session = Depends(database.get_db)):
    
#     # 추후 핸드폰번호 인증을 이 사이 추가.
#     user = user_service.get_exist_user(db, _user_info)
#     if user:
#         raise HTTPException(status_code= status.HTTP_500_INTERNAL_SERVER_ERROR,
#                             detail="이미 존재하는 유저의 핸드폰 번호")
#     user_service.create_user(db, _user_info)
    
#     # 사용자가 입력한 핸드폰 번호로 SMS 전송
#     auth_service.send_sms(_user_info.phone_no, "회원가입을 축하합니다!")

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
    
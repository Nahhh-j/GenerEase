from datetime import timedelta
from fastapi import APIRouter, Depends, HTTPException, Header, Request
from fastapi.security import HTTPBearer
from core.auth.auth_service import ALGORITHM, SECRET_KEY, decode_token, issue_access, issue_refresh
from util import error
from model.models import Requester, User, Auth
from sdk.api.message import Message
from sdk.exceptions import CoolsmsException
from typing import List

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

    # 전화번호로 기존 레코드 조회
    existing_auth = db.query(Auth).filter(Auth.phone_no == _user_info.phone_no).first()

    if existing_auth:
        # 기존 레코드가 있으면 인증번호 업데이트
        existing_auth.auth_code = auth_code
    else:
        # 기존 레코드가 없으면 새로운 레코드 생성
        auth_data = Auth(phone_no=_user_info.phone_no, auth_code=auth_code)
        db.add(auth_data)

    # 변경사항 저장
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
        # 사용자가 이미 user 테이블에 존재하는지 확인
        existing_user = db.query(User).filter(User.phone_no == phone_no).first()
        if existing_user:
            # 만약 존재하면, 토큰이 발급되며 자동 로그인 진행
            access_token = issue_access(phone_no)
            refresh_token = issue_refresh(phone_no)
            return {"message": "자동 로그인 성공!", "access_token": access_token, "refresh_token": refresh_token}
        else:
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

    # 토큰 발급
    access_token = issue_access(phone_no)
    refresh_token = issue_refresh(phone_no)

    return {
        "message": "회원가입이 완료되었습니다.",
        "access_token": access_token,
        "refresh_token": refresh_token
    }

@router.post("/refresh", summary="토큰 재발급 또는 자동로그인-ALL(AUTH)")
def refresh_user(refresh_token_str: str = Depends(HTTPBearer()), db: Session = Depends(database.get_db)):
    try:
        # 문자열로 변환
        refresh_token = refresh_token_str.credentials

        # 토큰 디코딩
        payload = auth_service.decode_token(refresh_token)
        
        # 페이로드에서 전화번호 추출
        phone_no: str = payload.get("sub")
        
        if phone_no is None:
            raise HTTPException(status_code=401, detail="Invalid token")
    except JWTError:
        raise HTTPException(status_code=401, detail="Invalid token")
    
    # 사용자 조회
    user = user_service.get_user(db, phone_no)
    if user is None:
        raise HTTPException(status_code=401, detail="User not found")
    
    # 새로운 액세스 토큰 발급
    new_access_token = auth_service.issue_access(phone_no)
    
    # 새로운 리프레시 토큰 발급
    new_refresh_token = auth_service.issue_refresh(phone_no)
    
    return {
        "access_token": new_access_token,
        "refresh_token": new_refresh_token,
        "nickname": user.nickname
    }

def current_user(token: str = Depends(HTTPBearer()), db: Session = Depends(database.get_db)) -> User:
    credentials_exception = HTTPException(
        status_code=status.HTTP_401_UNAUTHORIZED,
        detail="Could not validate credentials",
        headers={"WWW-Authenticate": "Bearer"},
    )
    try:
        payload = jwt.decode(token.credentials, str(auth_service.SECRET_KEY), algorithms=[auth_service.ALGORITHM])
        # type : Bearer, credentials: token
        phone_no: str = payload.get("sub")
        if phone_no is None:
            raise error.credentials_exception
    except JWTError:
        raise error.credentials_exception
    else:
        user = user_service.get_user(db, phone_no=phone_no)
        if user is None:
            raise credentials_exception
        return user

@router.post("/invite", status_code=status.HTTP_200_OK, summary="선택한 번호들에 초대 메세지 전송")
def send_invitation(request: Request, invited_numbers: List[str], current_user: User = Depends(current_user)):
    invited_names = []

    if not isinstance(invited_numbers, list):
        raise HTTPException(status_code=status.HTTP_400_BAD_REQUEST, detail="Input should be a valid list")

    # 초대 메시지에 로그인한 사용자의 이름 추가
    invitation_message = f"{current_user.username}님이 제너이즈의 사용자로 초대했습니다. 아래 URL을 클릭해 회원가입을 시작하세요."

    # 초대 메시지 전송
    for number in invited_numbers:
        try:
            # 사용자에게 초대 메시지 전송
            auth_service.send_sms(number, invitation_message)
            invited_names.append(number)  # 초대된 사용자 번호 기록
        except Exception as e:
            # 전송 중 오류가 발생한 경우, 해당 번호를 기록하고 계속 진행
            invited_names.append(f"Failed to invite: {number}")

    return {"message": "초대 메시지가 성공적으로 전송되었습니다.", "invited_names": invited_names}
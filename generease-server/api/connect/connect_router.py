from fastapi import APIRouter, Depends, HTTPException
from fastapi.security import HTTPBearer
from jose import JWTError

from sqlalchemy.orm import Session
from api.auth.auth_router import current_user
from model import database
from model.models import User
from schema.connect.connect_schema import ConnectReq
from util.constants import RESERVE_TYPE, ROLE

from core.connect.connect_service import create_connect_req, get_average_field, get_cnct_field
from util import error
from starlette import status

from util.http_error import http_forbidden_check

router = APIRouter(
    prefix="/connect",
    tags=["상담"]
)


@router.get("/cnct_avg_time", summary="상담 시간 리스트 조회-공통코드 조회(NO AUTH)")
def get_avg_time(db: Session = Depends(database.get_db)):
    try:
        return get_average_field(db)
    except JWTError:
        raise error.credentials_exception

@router.get("/cnct_field", summary="상담 카테고리 조회-공통코드 조회(NO AUTH)")
def get_connect_field(db: Session = Depends(database.get_db)):
    try:       
        return get_cnct_field(db) 
    except JWTError:
        raise error.credentials_exception

# 
@router.post("/create_cnct_req", summary="상담 생성 요청-NORMAL(AUTH)", description="호출 전에, /requester/whether_request API desc 참조바람.")
def create_cnct_req(_connect: ConnectReq, db: Session = Depends(database.get_db), _user: User = Depends(current_user)):
    try:
       http_forbidden_check(_user.role, ROLE.NORMAL)
       return create_connect_req(db, _connect, _user)
    except:
        return

#HD006
@router.post("/create_cnct_res", summary="상담 생성 응답-HELPER(AUTH)")
def create_cnct_res():
    try:
        #http_forbidden_check(_user.role, ROLE.HELPER)

    #    if _user.role != "01" : 
    #       raise HTTPException(
    #           status_code=status.HTTP_403_FORBIDDEN,
    #           detail= "권한없음"
    #)
        return
    except:
        return
    

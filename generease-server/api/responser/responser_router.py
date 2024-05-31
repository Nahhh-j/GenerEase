from fastapi import APIRouter, Depends, HTTPException
from fastapi.security import HTTPBearer
from requests import Session
from api.auth.auth_router import current_user
from core.user import user_service
from core.responser.responser_service import create_responser, get_responsers_by_type
from model import database
from model.models import User
from schema.responser.responser_schema import ResponserApply, ResponserListReq
from starlette import status

from util.constants import ROLE
from util.http_error import http_forbidden_check

router = APIRouter(
    prefix="/responser",
    tags=["도움"]
)

@router.post("/list_by_type", summary="분야별 도우미 조회-ALL(AUTH)")
def get_responsers(_reserve_type: ResponserListReq, token: str = Depends(HTTPBearer()), db: Session = Depends(database.get_db)):
   result = get_responsers_by_type(db, _reserve_type)
   return result

@router.post("/apply", summary="도우미 신청-NORMAL(AUTH)")
def apply_responser(_apply: ResponserApply, db: Session = Depends(database.get_db) , _user: User = Depends(current_user)):
    try:
        http_forbidden_check(_user.role, ROLE.NORMAL)
        result = create_responser(db, _apply, _user)
        return result
    except: 
        return

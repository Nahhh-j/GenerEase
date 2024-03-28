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

router = APIRouter(
    prefix="/responser",
    tags=["도움"]
)

@router.post("/list_by_type")
def get_responsers(_reserve_type: ResponserListReq, token: str = Depends(HTTPBearer()), db: Session = Depends(database.get_db)):
   result = get_responsers_by_type(db, _reserve_type)
   print(result)
   return result

@router.post("/apply")
def apply_responser(_apply: ResponserApply, db: Session = Depends(database.get_db) , _user: User = Depends(current_user)):
    result = create_responser(db, _apply, _user)
    return result
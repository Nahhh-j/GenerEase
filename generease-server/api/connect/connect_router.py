from fastapi import APIRouter, Depends
from fastapi.security import HTTPBearer
from jose import JWTError

from sqlalchemy.orm import Session
from api.auth.auth_router import current_user
from model import database
from model.models import User
from schema.connect.connect_schema import ConnectReq
from util.constants import RESERVE_TYPE

from core.connect.connect_service import create_connect_req, get_average_field, get_cnct_field
from util import error

router = APIRouter(
    prefix="/connect",
    tags=["상담"]
)

@router.get("/cnct_avg_time")
def get_avg_time(db: Session = Depends(database.get_db)):
    try:
        return get_average_field(db)
    except JWTError:
        raise error.credentials_exception

@router.get("/cnct_field")
def get_connect_field(db: Session = Depends(database.get_db)):
    try:       
        return get_cnct_field(db) 
    except JWTError:
        raise error.credentials_exception
    
@router.post("/create_cnct_req")
def create_cnct_req(_connect: ConnectReq, db: Session = Depends(database.get_db), _user: User = Depends(current_user)):
    try:
       return create_connect_req(db, _connect, _user)
    except:
        return
    
@router.post("/create_cnct_res")
def create_cnct_res():
    return
    

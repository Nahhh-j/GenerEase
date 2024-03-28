from fastapi import APIRouter, Depends
from requests import Session
from api.auth.auth_router import current_user
from core.requester.requester_service import create_requester, whether_request
from model import database
from model.models import User
from schema.requester.requester_schema import RequesterApply

router = APIRouter(
    prefix="/requester",
    tags=["요구"]
)

@router.get("/whether_request")
def whether_requester(db: Session = Depends(database.get_db), _user: User = Depends(current_user)):
    result = whether_request(db, _user)
    return result
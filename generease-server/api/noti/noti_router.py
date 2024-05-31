from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session
from model import database


from api.auth.auth_router import current_user
from model.models import User
from core.noti import noti_service


router = APIRouter(
    prefix="/noti",
    tags=["알림"]
)

@router.get("/get_noti", summary="알림 조회(AUTH)")
def get_noti_length(db: Session = Depends(database.get_db), _user: User = Depends(current_user)):
    try:
        noti = noti_service.get_noti(db, _user.user_id)
        
        return {
            "noti_len": len(noti),
            "noti_list": noti
            }
    except:
        return

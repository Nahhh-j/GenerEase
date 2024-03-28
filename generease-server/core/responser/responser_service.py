import json
from fastapi import Depends, HTTPException
from sqlalchemy.orm import Session
from starlette import status

from api.auth.auth_router import current_user
from model.models import Responser, User
from schema.responser.responser_schema import ResponserApply, ResponserListReq
from util.constants import ROLE

# 타입에 따른 responser의 유저 정보
def get_responsers_by_type(db: Session, _reserve_type: ResponserListReq):
    responsers = db.query(Responser).filter(Responser.best_way.contains(_reserve_type.reserve_type)).all()
    user_infos = []
    for responser in responsers:
        user = db.query(User).filter(User.user_id == responser.user_id).first()
        best_list = responser.best_way.strip('[]').replace("'", "").split(", ")
        filter_best_list =  [item for item in best_list if item.endswith("0")]
        user_info = {
            "username" : user.username,
            "user_img": user.user_img,
            "phone_no": user.phone_no,
            "nickname": user.nickname,
            "best_way": filter_best_list
        }
        user_infos.append(user_info)
    return user_infos

def create_responser(db: Session, _apply: ResponserApply, _user: User):
    if _user.role == ROLE.HELPER:
        raise HTTPException(status_code= status.HTTP_409_CONFLICT,
                            detail="역할이미도우미")
        
    db_responser = Responser(
        user_id = _user.user_id,
        best_way = str(_apply.best_way),
    )
    _user.role = ROLE.HELPER
    db.add(db_responser)
    db.commit()


    return json.dumps({"apply": "Y"})
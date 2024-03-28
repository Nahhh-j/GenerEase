import json

from sqlalchemy.orm import Session
from model.models import Connect, Requester, User
from schema.requester.requester_schema import ApplyResult, RequesterApply
from util.constants import ROLE

# 신청 여부 판단
def whether_request(db: Session, _user: User):
    whether_requester = db.query(Requester).filter(Requester.user_id == _user.user_id).first()

    if whether_requester is None:
        new_request = create_requester(db, _user)
        result = ApplyResult(requester_id=new_request.requester_id, apply="Y")
        return result
    elif whether_requester is not None:
        whether_connect = db.query(Connect).filter(Connect.requester_id == whether_requester.requester_id).all()
        if len(whether_connect) >= 2 :
            result = ApplyResult(requester_id=whether_requester.requester_id,apply="N")
        else:
            result = ApplyResult(requester_id=whether_requester.requester_id,apply="Y")
        return result

def create_requester(db: Session, _user: User):
    db_requester = Requester(
        user_id = _user.user_id
    )
    db.add(db_requester)
    db.commit()
    return db.query(Requester).filter(Requester.user_id == _user.user_id).first()

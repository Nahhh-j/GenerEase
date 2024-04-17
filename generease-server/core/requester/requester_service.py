import json

from sqlalchemy.orm import Session
from model.models import Connect, Requester, User
from schema.requester.requester_schema import ApplyResult, RequesterApply
from util.constants import ROLE

# 신청 여부 조회, 해당 로직은 (US010 상담 연결) 버튼 눌렀을 때, 요청 하는게 좋아보임.
# 아직 상담요청자가 아닌 상태이므로, 해당 로직에서 유효성 검사 이후, 성공 시 "도우미님과 상담연결을 신청하겠냐"는 팝업에서
# 상담생성요청 API를 호출하기 바람.

def whether_request(db: Session, _user: User):
    # 신청된 (상담) 여부를 판단한다.
    whether_requester = db.query(Requester).filter(Requester.user_id == _user.user_id).first()
    # 1. (상담)이 존재하지 않음.
    if whether_requester is None:
        # 1-1. 상담요청자 테이블에 유저 추가 후, 상담요청자로서 등록.
        new_request = create_requester(db, _user)
        # 1-2. 등록 후, 해당 요청자의 아이디로 요청 성공
        result = ApplyResult(requester_id=new_request.requester_id, apply="Y")
        return result
    # 2. (상담)이 존재함.
    elif whether_requester is not None:
        #2-1. (현재 진행중인 상담) 테이블 내에서 요청자의 아이디로 등록된 요청건 모두 가져옴.
        whether_connect = db.query(Connect).filter(Connect.requester_id == whether_requester.requester_id).all()
        #2-2. 해당 상담건이 2개 이상이면 상담요청 실패, 아닐 경우 성공
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

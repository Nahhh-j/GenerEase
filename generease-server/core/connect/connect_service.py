import json
from sqlalchemy.orm import Session

from model.models import Cmmd_code, Connect, User
from schema.connect.connect_schema import ConnectReq
from util.constants import RESERVE_STATUS, RESERVE_TYPE, RESPONSER_AVG_TIME

def get_cnct_field(db: Session):
    fields = db.query(Cmmd_code).filter(
        Cmmd_code.val.in_([code.value for code in RESERVE_TYPE])
    ).all()
    return [{field.nm: field.val} for field in fields]

def get_average_field(db: Session):
    avg_time = db.query(Cmmd_code).filter(
        Cmmd_code.val.in_([code.value for code in RESPONSER_AVG_TIME])
    ).all()
    return [{field.nm: field.val} for field in avg_time]

def get_connect_list(db: Session, _data: str, key: str):
    field = db.query(Connect).filter(
        getattr(Connect, key) == _data
    ).all()
    return field

def create_connect_req(db: Session, _connect: ConnectReq, _user: User):
    # sse-starlette
    # https://alive-wong.tistory.com/47
    db_connect = Connect(
        requester_id = _connect.requester_id,
        responser_id = _connect.responser_id,
        content = _connect.content,
        status = RESERVE_STATUS.PENDING
    )
    db.add(db_connect)
    db.commit()
    return json.dumps({"result" : "Y"})

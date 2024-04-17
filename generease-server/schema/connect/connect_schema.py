import datetime
from pydantic import BaseModel

class Connect(BaseModel):
    connect_id: int
    requester_id: int
    responser_id: int
    status: str
    connect_way: str
    place: str
    created_at: datetime.datetime
    updated_at: datetime.datetime

class ConnectReq(BaseModel):
    requester_id: int
    responser_id: int
    content: str
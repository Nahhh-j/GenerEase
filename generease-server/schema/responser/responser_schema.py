from typing import List
from fastapi import HTTPException
from pydantic import BaseModel, field_validator, EmailStr
from starlette import status

from schema.user.user_schema import User

class Responser(User):
    user_id: int
    best_way: str

class ResponserListReq(BaseModel):
    reserve_type: str

class ResponserApply(BaseModel):
    email: EmailStr
    belong: str # 소속
    attend: str # 소속기간
    best_way: List[str]
    active_time: str
    apply_motive: str

    @field_validator("*")
    def not_empty(cls, v):
        if isinstance(v, str) and not v.strip():
            raise HTTPException(status_code= status.HTTP_400_BAD_REQUEST, detail="하나라도 null일 경우")
        elif isinstance(v, list):
            for item in v:
                if not item or not item.strip():
                    raise HTTPException(status_code= status.HTTP_400_BAD_REQUEST, detail="하나라도 null일 경우")
        return v

import datetime
import re
from wsgiref.validate import validator
from fastapi import HTTPException
from pydantic import BaseModel, Field, EmailStr, ValidationError, field_validator
from starlette import status

class User(BaseModel):
    user_id: int
    username: str
    email : EmailStr
    phone_no : str
    password_hash: str
    nickname: str
    birth: str
    role: str
    user_img: bytes # ?
    created_at: datetime.datetime
    updated_at: datetime.datetime

# https://tech.isyncbrain.com/python/fastapi/pydantic/validation/2022/04/25/fast-api-validator.html
class CreateUser(BaseModel):
    username: str
    phone_no: str = Field(pattern='^\d{3}-\d{4}-\d{4}$')
    birth: str = Field(pattern='^\d{4}-\d{2}-\d{2}$')

    @field_validator('birth')
    def check_birth_date(cls, value):
        if not re.match(r'^\d{4}-\d{2}-\d{2}$', value):
            raise ValueError("잘못된 날짜 형식입니다. 'YYYY-MM-DD' 형식으로 날짜를 입력하세요.")

        year, month, day = map(int, value.split('-'))

        if not (1800 <= year <= 2200):
            raise ValueError("잘못된 연도입니다. 연도는 1800에서 2200 사이어야 합니다.")

        if not (1 <= month <= 12):
            raise ValueError("잘못된 월입니다. 월은 1에서 12 사이어야 합니다.")

        if not (1 <= day <= 31):
            raise ValueError("잘못된 일입니다. 일은 1에서 31 사이어야 합니다.")

        return value

class LoginUser(BaseModel):
    phone_no: str
import datetime
from pydantic import BaseModel, Field, EmailStr
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

class CreateUser(BaseModel):
    username: str
    birth: str
    phone_no: str
    created_at: datetime.datetime

class LoginUser(BaseModel):
    phone_no: str
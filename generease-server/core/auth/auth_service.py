from datetime import timezone, datetime, timedelta
import jwt

ACCESS_TOKEN_EXPIRE_MINUTES = 60*24
REFRESH_TOKEN_EXPIRE_MINUTES = 600*24
SECRET_KEY = "02958cc4bd3a07049b27c41939160867589617cc3da118f8b9ed55d975f2d785"
ALGORITHM = "HS256"

def issue_access(sub: str):
    data = {"sub": sub, "exp": datetime.now(timezone.utc) + timedelta(minutes=ACCESS_TOKEN_EXPIRE_MINUTES)}
    access_token = jwt.encode(data, SECRET_KEY, ALGORITHM).encode("utf-8")
    return access_token

def issue_refresh(sub: str):
    data = {"sub": sub, "exp": datetime.now(timezone.utc) + timedelta(minutes=REFRESH_TOKEN_EXPIRE_MINUTES)}
    refresh_token = jwt.encode(data, SECRET_KEY, ALGORITHM).encode("utf-8")
    return refresh_token

def decode_token(token: str):    
    payload = jwt.decode(token, SECRET_KEY, algorithms=[ALGORITHM])
    phone_no: str = payload.get("sub")
    return phone_no


from datetime import timezone, datetime, timedelta
import os
import jwt
from dotenv import load_dotenv
from twilio.rest import Client

load_dotenv()

SECRET_KEY = os.environ.get("SECRET_KEY")
ALGORITHM = os.environ.get("ALGORITHM")
ACCESS_TOKEN_EXPIRE_MINUTES = 60*24
REFRESH_TOKEN_EXPIRE_MINUTES = 600*24

TWILIO_RECOVERY_CODE = os.environ.get("TWILIO_RECOVERY_CODE")
TWILIO_ACCOUNT_SID = os.environ.get("TWILIO_ACCOUNT_SID")
TWILIO_AUTH_TOKEN = os.environ.get("TWILIO_AUTH_TOKEN")
TWILIO_PHONE_NO = os.environ.get("TWILIO_PHONE_NO")


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

def send_sms():
    client = Client(TWILIO_ACCOUNT_SID, TWILIO_AUTH_TOKEN)
    client.messages.create(
        to="+821082831292",
        from_=TWILIO_PHONE_NO,
        body="g2"
    )

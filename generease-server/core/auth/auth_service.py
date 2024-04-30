from datetime import timezone, datetime, timedelta
import os
import jwt
from sdk.api.message import Message
from sdk.exceptions import CoolsmsException
from random import randint

SECRET_KEY = os.environ.get("SECRET_KEY")
ALGORITHM = os.environ.get("ALGORITHM")
ACCESS_TOKEN_EXPIRE_MINUTES = 60*24
REFRESH_TOKEN_EXPIRE_MINUTES = 600*24

COOLSMS_API_KEY = "NCS8C6GNWSWEV8VG"
COOLSMS_API_SECRET = "C3GV8I9PHHR6ZPR4XOC5K1OSEISVLOOC"

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

def send_sms(recipient_number: str, message: str):
    params = {
        'type': 'sms',
        'to': recipient_number,
        'from': '01065392253',
        'text': message
    }
    cool = Message(COOLSMS_API_KEY, COOLSMS_API_SECRET)
    try:
        response = cool.send(params)
        print("Success Count : %s" % response['success_count'])
        print("Error Count : %s" % response['error_count'])
        print("Group ID : %s" % response['group_id'])
        if "error_list" in response:
            print("Error List : %s" % response['error_list'])
    except CoolsmsException as e:
        print("Error Code : %s" % e.code)
        print("Error Message : %s" % e.msg)
        
def generate_auth_code():
    return str(randint(1000, 9999))
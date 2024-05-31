from model.database import get_db
from model.models import User
from core.auth import auth_service
from sqlalchemy.orm import Session
from fastapi import Request, HTTPException, status
from typing import List

# 전체 user의 이름(실명) 및 전화번호 가져오기
def get_emergency_contacts(current_user: User, db: Session):
    db_users = db.query(User).all()

    # 본인 정보를 제외한 사용자 정보를 반환
    users_except_self = [{"username": user.username, "phone_no": user.phone_no} for user in db_users if user.user_id != current_user.user_id]
    
    return users_except_self

# 초대 메세지 전송
def send_invitation(request: Request, invited_numbers: List[str], current_user: User):
    invited_names = []

    # 초대된 번호가 하나 이상인지 확인
    if not invited_numbers:
        raise HTTPException(status_code=status.HTTP_400_BAD_REQUEST, detail="Invited numbers should not be empty")

    # 초대 메시지에 로그인한 사용자의 이름 추가
    invitation_message = f"{current_user.username}님이 제너이즈의 사용자로 초대했습니다. 아래 URL을 클릭해 회원가입을 시작하세요!"

    # 초대 메시지 전송
    for number in invited_numbers:
        try:
            # 사용자에게 초대 메시지 전송
            auth_service.send_sms(number, invitation_message)
            invited_names.append(number)  # 초대된 사용자 번호 기록
        except Exception as e:
            # 전송 중 오류가 발생한 경우, 해당 번호를 기록하고 계속 진행
            invited_names.append(f"Failed to invite: {number}")

    return {"message": "초대 메시지가 성공적으로 전송되었습니다.", "invited_names": invited_names}

# 사용자에게 메시지 전송
def send_message(request: Request, phone_number: str, current_user: User):
    try:
        message = f"{current_user.username}님이 제너이즈에서 비상 연락을 시도했습니다."

        auth_service.send_sms(phone_number, message)

        return {"message": "메시지가 성공적으로 전송되었습니다.", "recipient": phone_number}
    except Exception as e:
        # 전송 중 오류가 발생한 경우
        return {"message": f"메시지 전송 중 오류가 발생했습니다: {e}"}
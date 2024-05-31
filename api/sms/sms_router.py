from fastapi import APIRouter, Depends, HTTPException, status, Request, Query
from api.auth.auth_router import current_user
from model.models import User
from core.auth import auth_service
from typing import List
from sqlalchemy.orm import Session
from model.database import get_db
from core.sms.sms_service import get_emergency_contacts, send_invitation, send_message

router = APIRouter(
    prefix="/sms",
    tags=["SMS"]
)

# 테스트 방법 : POST /sms/invite?invited_numbers=01011111111&invited_numbers=01022222222&...
@router.post("/invite", status_code=status.HTTP_200_OK, summary="선택한 번호들에 초대 메세지 전송")
def post_send_invitation(request: Request, invited_numbers: List[str] = Query(...), current_user: User = Depends(current_user)):
    return send_invitation(request, invited_numbers, current_user)


# 프론트에서 전달한 연락처 필터링을 통해 user의 이름(실명) 및 전화번호 가져오기
# 테스트 방법 : GET /sms/emergency_contacts?phone_numbers=0100000000&phone_numbers=010111111111&phone_numbers=010-5888-1234&...
@router.get("/emergency_contacts", status_code=status.HTTP_200_OK, summary="비상연락망 조회")
def get_emergency_contacts(phone_numbers: List[str] = Query(...), current_user: User = Depends(current_user), db: Session = Depends(get_db)):
    # 프론트엔드에서 전달한 연락처 리스트를 기준으로 일치하는 회원 정보 조회
    db_users = db.query(User).filter(User.phone_no.in_(phone_numbers)).all()

    # 본인 정보를 제외한 사용자 정보를 반환
    users_except_self = [{"username": user.username, "phone_no": user.phone_no} for user in db_users if user.user_id != current_user.user_id]
    
    return users_except_self


# 비상연락 전화 버튼 선택 시 문자도 전송
# 테스트 방법 : POST sms/send_message?phone_number=01065392253
@router.post("/send_message", status_code=status.HTTP_200_OK, summary="사용자에게 메시지 전송")
def post_send_message(request: Request, phone_number: str, current_user: User = Depends(current_user)):
    return send_message(request, phone_number, current_user)

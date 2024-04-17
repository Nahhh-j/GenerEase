from fastapi import APIRouter, Depends
from requests import Session
from api.auth.auth_router import current_user
from core.requester.requester_service import create_requester, whether_request
from model import database
from model.models import User
from schema.requester.requester_schema import RequesterApply
from util.constants import ROLE
from util.http_error import http_forbidden_check

router = APIRouter(
    prefix="/requester",
    tags=["요구"]
)

@router.get("/whether_request", summary="신청 여부 조회-NORMAL(AUTH)", description="신청 여부 조회 API, 해당 로직은 (US010 상담 연결) 버튼 눌렀을 때, 요청 하는게 좋아보임. 아직 상담요청자가 아닌 상태이므로, 해당 로직에서 유효성 검사 이후, 성공 시 도우미님과 상담연결을 신청하겠냐 는팝업에서 상담생성요청 API를 호출하기 바람.")
def whether_requester(db: Session = Depends(database.get_db), _user: User = Depends(current_user)):
    http_forbidden_check(_user.role, ROLE.NORMAL)
    result = whether_request(db, _user)
    return result
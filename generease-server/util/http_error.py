from fastapi import HTTPException
from starlette import status

def http_success_check(status_code: int):
    return {
        'status': status_code,
        "detail": "성공"
    }

def http_bad_request_check():
    raise HTTPException(
        status_code=status.HTTP_400_BAD_REQUEST,
        detail= "잘못된 요청입니다."
    )

def http_forbidden_check(role, permit_role):
    if role != permit_role :
        raise HTTPException(
            status_code=status.HTTP_403_FORBIDDEN,
            detail="고객 ROLE에 접근할 수 없는 API"
        )

def http_server_error_check():
    raise HTTPException(
        status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
        detail="서버에러"
    )
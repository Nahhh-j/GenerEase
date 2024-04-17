from fastapi import HTTPException
from starlette import status


def http_forbidden_check(role, permit_role):
    if role != permit_role :
        raise HTTPException(
            status_code=status.HTTP_403_FORBIDDEN,
            detail="고객 ROLE에 접근할 수 없는 API"
        )
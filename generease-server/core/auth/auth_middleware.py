import json
from fastapi import Request, applications
from starlette.responses import Response
from starlette.middleware.base import BaseHTTPMiddleware

from core.auth.auth_service import decode_token, issue_access

# 요청 시 마다 ACCESS 갱신
class renew_auth(BaseHTTPMiddleware):
    async def dispatch(self, request: Request, call_next) -> Response:
        response = await call_next(request)
        if request.headers.get('Authorization') != None: # NOT NO_AUTH
            request_token = request.headers.get('Authorization').split(' ')[1]
            status = response.status_code
            decoding_info = decode_token(request_token)
            if status == 200 :
                response.headers["Authorization"] = f"Bearer {issue_access(decoding_info)}"       
        return response
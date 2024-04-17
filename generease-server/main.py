from urllib import request
from fastapi import Depends, FastAPI, HTTPException
from fastapi.responses import JSONResponse
from fastapi.security import HTTPBearer
from starlette.middleware.cors import CORSMiddleware

from api.user import user_router
from api.auth import auth_router
from api.connect import connect_router
from api.responser import responser_router
from api.requester import requester_router

from core.auth.auth_middleware import renew_auth

app = FastAPI()

origins = [
    "http://127.0.0.1:5173",    # 또는 "http://localhost:5173"
]

app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

app.add_middleware(
    renew_auth,
)

app.include_router(user_router.router)
app.include_router(auth_router.router)
app.include_router(connect_router.router)
app.include_router(responser_router.router)
app.include_router(requester_router.router)
from fastapi import HTTPException
from starlette import status

credentials_exception = HTTPException(
        status_code=status.HTTP_401_UNAUTHORIZED,
        detail="COULD NOT VALIDATE CREDENTIALS",
        headers={"WWW-Authenticate": "Bearer"},
    )
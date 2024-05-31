from pydantic import BaseModel

class RequesterApply(BaseModel):
    responser_id: int

class ApplyResult(BaseModel):
    requester_id: int
    apply: str
    
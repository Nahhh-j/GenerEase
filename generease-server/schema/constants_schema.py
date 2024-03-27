from pydantic import BaseModel

class Reserve_type(BaseModel):
    reserve_culture: str
    reserve_education: str
    reserve_sport: str
    reserve_medical: str
    reserve_restaurant: str
    reserve_etc: str

class Role(BaseModel):
    normal: str
    helper: str
    manager:str

    class config:
        orm_mode = True
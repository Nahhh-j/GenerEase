from sqlalchemy import ARRAY, Column, Integer, String, DateTime, ForeignKey, BLOB, func
from sqlalchemy.orm import relationship

from model import database

class User(database.Base):
    __tablename__ = "user"

    user_id = Column(Integer, primary_key=True, unique=True, nullable=False, autoincrement=True)
    username = Column(String(255),unique=True, nullable=False)
    email = Column(String(255))
    phone_no = Column(String(20),unique=True, nullable=False)
    password_hash = Column(String(255), nullable=False)
    nickname= Column(String(20))
    birth = Column(String(255), nullable=False)
    role = Column(String(20), nullable=False)
    user_img = Column(BLOB)
    created_at = Column(DateTime, default=func.now())
    updated_at = Column(DateTime, default=func.now())

class Connect(database.Base):
    __tablename__ = "connect"

    connect_id = Column(Integer, primary_key=True, unique=True, nullable= False, autoincrement=True)
    responser_id = Column(Integer, ForeignKey("responser.responser_id"), nullable=False)
    requester_id = Column(Integer, ForeignKey("requester.requester_id"), nullable=False)
    status = Column(String(255), nullable=False)
    connect_way = Column(String(255), nullable=False)
    content = Column(String(255))
    place = Column(String(255))
    created_at = Column(DateTime, default=func.now())
    updated_at = Column(DateTime, default=func.now())

    requester = relationship("Requester", backref="connect")
    responser = relationship("Responser", backref="connect")

class ConnectHistory(database.Base):
    __tablename__ = "connect_history"
    connect_history_id = Column(Integer, primary_key=True, unique=True, nullable= False, autoincrement=True)
    connect_id = Column(Integer, ForeignKey("connect.connect_id"), nullable=False)
    responser_id = Column(Integer, ForeignKey("responser.responser_id"), nullable=False)
    requester_id = Column(Integer, ForeignKey("requester.requester_id"), nullable=False)
    connect_way = Column(String(255))
    content = Column(String(255))
    place = Column(String(255))
    created_at = Column(DateTime, default=func.now())
    
    requester = relationship("Requester", backref="connectHistory")
    responser = relationship("Responser", backref="connectHistory")

class Requester(database.Base):
    __tablename__ = "requester"
    requester_id = Column(Integer, primary_key=True, unique=True, nullable=False, autoincrement=True)
    user_id = Column(Integer, ForeignKey("user.user_id"), unique=True)

class Responser(database.Base):
    __tablename__ = "responser"
    responser_id = Column(Integer, primary_key=True, unique=True, nullable=False, autoincrement=True)
    user_id = Column(Integer, ForeignKey("user.user_id"), unique=True)
    best_way = Column(String(255))
    active_time = Column(String(255))
    
class Cmmd_code(database.Base):
    __tablename__ = "cmmd_code"
    id = Column(Integer, primary_key=True, unique=True, nullable=False)
    nm = Column(String(400))
    val = Column(String(400))
    tsk = Column(String(400))




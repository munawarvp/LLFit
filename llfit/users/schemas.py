from datetime import datetime

from ninja import ModelSchema, Schema


class UserCreate(Schema):
    email: str
    name: str
    username: str
    password: str

class UserPasswordReset(Schema):
    username: str
    password: str

class UserOut(Schema):
    username: str
    first_name: str
    last_name: str
    email: str
    is_staff: bool
    date_joined: datetime

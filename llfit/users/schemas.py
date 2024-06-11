from ninja import ModelSchema, Schema


class UserCreate(Schema):
    email: str
    name: str
    username: str
    password: str


class UserLogin(Schema):
    username: str
    password: str
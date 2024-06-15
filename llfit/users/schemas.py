from datetime import datetime

from ninja import ModelSchema, Schema

from users.models import UserMetrics


class UserCreate(Schema):
    email: str
    name: str
    username: str
    password: str

class UserPasswordReset(Schema):
    username: str
    password: str

class UserOut(Schema):
    id: int
    username: str
    first_name: str
    last_name: str
    email: str
    is_staff: bool
    date_joined: datetime


class UserMetricsSchema(Schema):
    weight: float
    height: float
    age: int
    gender: str
    shift: str
class UserMetricsCreate(UserMetricsSchema):
    user: int

class UserMetricsUpdate(UserMetricsSchema):
    level: str

class UserMetricsOut(ModelSchema):
    user : UserOut | None = None
    class Meta:
        model = UserMetrics
        fields = ('id', 'weight', 'height', 'bmi', 'age', 'gender', 'shift')
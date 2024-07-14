from datetime import datetime
from typing import Optional

from ninja import ModelSchema, Schema

from users.models import UserMetrics, UserProfile


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

class UserMetricsCreate(UserMetricsSchema):
    user: int

class UserMetricsOut(ModelSchema):
    user : UserOut | None = None
    class Meta:
        model = UserMetrics
        fields = ('id', 'weight', 'height', 'bmi')


class UserProfileSchema(Schema):
    age: Optional[int] = None
    gender: Optional[str] = None
    shift: Optional[str] = None
    level: Optional[str] = None
    address: Optional[str] = None
    phone_number: Optional[str] = None

class UserProfileCreate(UserProfileSchema):
    user: int

class UserProfileOut(ModelSchema):
    user: UserOut | None = None
    class Meta:
        model = UserProfile
        fields = ('id', 'age', 'gender', 'shift', 'level', 'address', 'phone_number')
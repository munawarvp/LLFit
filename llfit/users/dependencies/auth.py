import jwt

from ninja.security import HttpBearer
from decouple import config

from django.contrib.auth.models import User


class AuthBearer(HttpBearer):
    ALGORITHM = "HS256"

    def authenticate(self, request, token):
        user = self.decode_jwt(token)
        return user
    
    def decode_jwt(self, token):
        try:
            payload = jwt.decode(token, key=config('SECRET_KEY'), algorithms=[self.ALGORITHM])
            user = User.objects.get(id=payload['user_id'])
            return user
        except Exception as e:
            return None
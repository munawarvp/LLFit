from ninja import NinjaAPI
from ninja_extra import NinjaExtraAPI

from django.contrib.auth.models import User
from ninja_jwt.controller import NinjaJWTDefaultController
from ninja_jwt.authentication import JWTAuth
from django.contrib.auth import authenticate, login

from users.schemas import UserCreate, UserLogin

app = NinjaAPI()
api = NinjaExtraAPI()
api.register_controllers(NinjaJWTDefaultController)


from ninja_extra import api_controller
from ninja_jwt.controller import TokenObtainPairController

@api_controller('token', tags=['Auth'])
class MyCustomController(TokenObtainPairController):
    pass


api.register_controllers(MyCustomController)

@app.get('/users')
def get_users(request):
    return {'data': [], 'message': 'Users fetched success'}


@app.post('/user/register')
def register_new_user(request, data: UserCreate):
    try:
        user = User.objects.create_user(
            email=data.email,
            username=data.username,
            password=data.password,
            first_name=data.name,
            is_active=False
        )
        if user:
            return {"success": True, "message": "User created successfully"}
        else:
            return {"success": False, "message": "User creation failed..!"}
    except Exception as e:
        return {"success": False, "message": f"Error --- {e}"}
    

@app.post('/user/login')
def authenticate_user(request, data: UserLogin):
    user = authenticate(username=data.username, password=data.password)
    if user:
        login(request, user)
        return {'success': True, 'message': user}
    else:
        return {'success': False, 'message': 'Login failed..!'}
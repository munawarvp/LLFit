from ninja import NinjaAPI
from ninja_extra import NinjaExtraAPI

from django.contrib.auth.models import User
from ninja_extra import api_controller
from ninja_jwt.controller import NinjaJWTDefaultController

from users.schemas import UserCreate
from users.helper import send_activation_mail

app = NinjaAPI()
api = NinjaExtraAPI()


@api_controller('/auth', tags=['User'])
class AuthController:

    @api.get('/users', tags=['User'])
    def get_users(request):
        return {'data': [], 'message': 'Users fetched success'}
    
    @api.post('/user/register', tags=['User'])
    def register_new_user(request, data: UserCreate):
        # try:
        user = User.objects.create_user(
            email=data.email,
            username=data.username,
            password=data.password,
            first_name=data.name,
            is_active=False
        )
        if user:
            response = send_activation_mail(user)
            return {"success": True, "message": "User created successfully", "response": response}
        else:
            return {"success": False, "message": "User creation failed..!"}
        # except Exception as e:
        #     return {"success": False, "message": f"Error --- {e}"}

api.register_controllers(NinjaJWTDefaultController)
api.register_controllers(AuthController)



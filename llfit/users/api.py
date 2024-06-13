from ninja_extra import NinjaExtraAPI

from django.contrib.auth.models import User
from ninja_extra import route, api_controller
from ninja_jwt.controller import NinjaJWTDefaultController

from users.models import UserMetrics
from users.schemas import UserCreate, UserPasswordReset, UserOut, UserMetricsCreate, UserMetricsOut
from users.helper import send_activation_mail, get_or_create_user_metrics_record

api = NinjaExtraAPI()


@api_controller('/user', tags=['User'])
class AuthController:
    @route.get('/', tags=['User'])
    def get_users(self, request):
        return {'data': [], 'message': 'Users fetched success'}
    
    @route.post('/register', tags=['User'])
    def register_new_user(self, request, data: UserCreate):
        try:
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
        except Exception as e:
            return {"success": False, "message": f"Error --- {e}"}
        
    @route.post('/reset-password')
    def reset_user_password(self, request, data: UserPasswordReset):
        try:
            user = User.objects.get(username=data.username)
            if user:
                user.set_password(data.password)
                user.save()
                return {'success': True, 'message': f"Password changed for user: {user.username}"}
            else:
                return {'success': False, 'message': f"User not found for username: {data.username}"}
        except Exception as e:
            return {"success": False, "message": f"Error --- {e}"}
        
    @route.get('/get-user/{user_id}', response=UserOut)
    def get_single_user(self, request, user_id: int):
        try:
            user = User.objects.get(id=user_id)
            if user:
                return user
            else:
                return {'success': False, 'message': "User not found..!"}
        except Exception as e:
            return {"success": False, "message": f"Error --- {e}"}

    @route.post('/add-user-matrix')
    def create_user_matrix(self, request, data: UserMetricsCreate):
        user_metrics = get_or_create_user_metrics_record(data)
        if user_metrics:
            return {'success': True, 'message': 'User metrics created successfully..!'}
        else:
            return {'success': False, 'message': 'Couldnt make user metrics..!'}
        
    @route.get('/user-metrics/{id}', response=UserMetricsOut)
    def get_user_metrics(self, request, id: int):
        user_metrics = UserMetrics.objects.get(id=id)
        if user_metrics:
            return user_metrics
        else:
            return {'success': False, 'message': 'user metrics not found..!'}
        
    
api.register_controllers(NinjaJWTDefaultController)
api.register_controllers(AuthController)
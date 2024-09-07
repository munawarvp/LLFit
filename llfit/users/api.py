from datetime import datetime

from ninja_extra import NinjaExtraAPI

from django.contrib.auth.models import User
from ninja_extra import route, api_controller
from ninja_jwt.controller import NinjaJWTDefaultController

from users.dependencies.auth import AuthBearer
from users.models import UserMetrics, UserProfile
from users.schemas import (
                            UserCreate,
                            UserPasswordReset,
                            UserOut,
                            UserMetricsCreate,
                            UserMetricsOut,
                            UserMetricsSchema,
                            UserProfileSchema,
                            UserProfileCreate,
                            UserProfileOut,
                            MetricsReport
                        )
from users.helper import send_activation_mail, create_user_metrics_record, activate_user_token, create_user_profile_record, calculate_latest_bmi, schedule_job, metrics_report

api = NinjaExtraAPI(auth=AuthBearer())


@api_controller('/user', tags=['User'])
class AuthController:
    
    @route.post('/register', auth=None, tags=['User'])
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
                send_activation_mail(request, user)
                return {"success": True, "message": "User created successfully"}
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
        

    @route.get('/activate-user', auth=None, tags=['User'])
    def activate_registered_user(self, uid: str, token: str):
        try:
            valid_user = activate_user_token(uid, token)
            if valid_user:
                return {"success": True, "message": "User activated successfully..!"}
            else:
                return {"success": False, "message": "User activation failed..!"}
        except Exception as e:
            return {"success": False, "message": f"Error --- {e}"}
        

    @route.get('/get-user', response=UserOut)
    def get_single_user(self, request, user_id: int):
        try:
            user = User.objects.get(id=user_id)
            if user:
                return user
            else:
                return {'success': False, 'message': "User not found..!"}
        except Exception as e:
            return {"success": False, "message": f"Error --- {e}"}
        

    @route.get('/get-profile', response=UserProfileOut)
    def get_user_profile(self, request, profile_id:int=None):
        '''
        Get UserProfile record
        args:
            profile_id: int
        '''
        try:
            user = request.auth
            if profile_id:
                user_profile = UserProfile.objects.get(id=profile_id)
            else:
                user_profile = UserProfile.objects.get(user=user.id)
            return user_profile
        except Exception as e:
            return {"success": False, "message": f"Error --- {e}"}


    @route.get('/user-metrics', response=UserMetricsOut)
    def get_user_metrics(self, request, metrics_id:int=None):
        try:
            user = request.auth
            if metrics_id:
                user_metrics = UserMetrics.objects.get(id=metrics_id)
            else:
                user_metrics = UserMetrics.objects.filter(user=user.id).latest('created_at')
            return user_metrics
        except Exception as e:
            return {"success": False, "message": f"Error --- {e}"}
    

    @route.get('/calculate-bmi', auth=None, response=UserMetricsOut)
    def calculate_user_bmi(self, request, metrics_id: int):
        '''Calculate BMI for user'''
        user_metrics = UserMetrics.objects.get(id=metrics_id)
        if user_metrics:
            user_metrics = calculate_latest_bmi(metrics_id)
            return user_metrics
        else:
            return {'success': False, 'message': "user metrics not found..!"}


    @route.get('metrics-report', response=MetricsReport)
    def fetch_metrics_reports(self, request, filter_model : datetime = None):
        user = request.auth
        data = metrics_report(user, filter_model)
        return MetricsReport(success=True, data=data).dict()

    @route.post('/add-profile')
    def create_user_profile(self, request, data: UserProfileCreate):
        '''
            Create UserProfile record for a user
            args:
                request,
                data: UserMetricsCreate
        '''
        user_profile = create_user_profile_record(data)
        if user_profile:
            return {'success': True, 'message': 'User profile created successfully..!'}
        else:
            return {'success': False, 'message': 'Couldnt make user profile..!'}


    @route.post('/add-metrics')
    def create_user_metrics(self, request, data: UserMetricsCreate):
        '''Create UsermMetrics record for a user
        args:
            request,
            data: UserMetricsCreate
        '''
        user_metrics = create_user_metrics_record(data)
        if user_metrics:
            return {'success': True, 'message': 'User metrics created successfully..!'}
        else:
            return {'success': False, 'message': 'Couldnt make user metrics..!'}
        
        
    @route.put('/apporve-staff')
    def approve_user_to_staff(self, request, user_id: int):
        try:
            user = User.objects.get(id=user_id)
            if user:
                user.is_staff=True
                user.save()
                return {'success': True, 'message': "User upgraded to staff..!"}
            else:
                return {'success': False, 'message': "User not found..!"}
        except Exception as e:
            return {"success": False, "message": f"Error --- {e}"}
        

    @route.put('/update-profile')
    def update_user_profile(self, request, profile_id: int, data: UserProfileSchema):
        try:
            user_profile = UserProfile.objects.get(id=profile_id)
            if user_profile:
                UserProfile.objects.update(**data.__dict__)
                return {'success': True, 'message': 'record updated successfully..!'}
            else:
                return {'success': False, 'message': 'user profile not found..!'}
        except Exception as e:
            return {"success": False, "message": f"Error --- {e}"}


    @route.put('/update-metrics')
    def update_user_metrics(self, request, metrics_id: int, data: UserMetricsSchema):
        user_metrics = UserMetrics.objects.get(id=metrics_id)
        if user_metrics:
            UserMetrics.objects.update(**data.__dict__)
            return {'success': True, 'message': 'record updated successfully..!'}
        else:
            return {'success': False, 'message': 'user metrics not found..!'}
        

    @route.delete('/delete-user')
    def delete_user(self, request, user_id: int):
        try:
            user = User.objects.get(id=user_id)
            user.delete()
            return {'success': True, 'message': 'record deleted successfully..!'}
        except Exception as e:
            return {"success": False, "message": f"Error --- {e}"}


    @route.delete('/delete-metrics')
    def delete_user_metrics_record(self, request, metrics_id: int):
        try:
            result = UserMetrics.objects.get(id=metrics_id)
            result.delete()
            return {'success': True, 'message': 'record deleted successfully..!'}
        except Exception as e:
            return {"success": False, "message": f"Error --- {e}"}
    

    @route.get('/health', auth=None)
    def check_application_health(self, request):
        return {'success': True, 'message': 'health check..!'}
    

    @route.get('/keep-server-alive', auth=None)
    def keep_server_alive_using_job(self, request):
        resposne = schedule_job()
        return resposne

api.register_controllers(NinjaJWTDefaultController)
api.register_controllers(AuthController)
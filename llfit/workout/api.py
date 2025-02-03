from datetime import datetime

from ninja_extra import route, api_controller
from django.contrib.auth.models import User

from workout.models import Excerise, UserWorkout
from workout.schemas import WorkoutSchemaCreate
from utils.excerise import ApiNinja

@api_controller('/workout', tags=['Workout'])
class WorkoutController:
    
    @route.get('get-workouts')
    def get_workouts(self, request, muscle: str):
        try:
            user = request.auth
            if not user.is_superuser:
                return {"success": False, "message": "Permission denied"}
            api_ninja = ApiNinja()
            response = api_ninja.get_muscle_based_excerise(muscle=muscle)
            return {'success': True, 'message': 'workouts fetched successfully..!', 'data': response}
        except Exception as e:
            return {"success": False, "message": f"Error --- {e}"}
        

    @route.post('/add-user-excerise')
    def add_user_excerise(self, request, data: WorkoutSchemaCreate, user_id: int):
        try:
            user = request.auth
            if not user.is_superuser:
                return {"success": False, "message": "Permission denied"}
            client = User.objects.get(id=user_id)
            data = data.dict()
            day = data.pop('day', None)
            excersise, _ = Excerise.objects.get_or_create(**data, defaults={'name': data['name']})
            
            UserWorkout.objects.create(
                user=client,
                excerise=excersise,
                day=day,
            )
            return {'success': True, 'message': 'workouts added successfully..!'}
        except User.DoesNotExist:
            return {"success": False, "message": "User not found"}
        except Exception as e:
            return {"success": False, "message": f"Error --- {e}"}
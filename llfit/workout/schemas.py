from typing import Optional

from workout.models import UserWorkout, Excerise
from ninja import Schema, ModelSchema

class WorkoutSchemaCreate(Schema):
    name: str
    muscle: str
    difficulty: str
    instructions: str
    day: str
    type: Optional[str] = None
    equipment: Optional[str] = None
    image: Optional[str] = None

class ExceriseOut(ModelSchema):
    
    class Meta:
        model = Excerise
        fields = ('id', 'name', 'muscle', 'difficulty', 'instructions', 'type', 'equipment', 'image')

class UserWorkoutOut(ModelSchema):
    excerise: ExceriseOut
    class Meta:
        model = UserWorkout
        fields = ('id', 'excerise', 'day', 'is_completed')
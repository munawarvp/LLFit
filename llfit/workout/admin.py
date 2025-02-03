from django.contrib import admin

from workout.models import Excerise, UserWorkout

# Register your models here.
admin.site.register(Excerise)
admin.site.register(UserWorkout)
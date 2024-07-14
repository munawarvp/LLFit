from django.contrib import admin
from .models import UserMetrics, UserProfile

# Register your models here.
admin.site.register(UserMetrics)
admin.site.register(UserProfile)
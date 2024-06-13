from django.db import models
from django.contrib.auth.models import User

# Create your models here.
class UserMetrics(models.Model):
    MORNING = 'morning'
    EVENING = 'evening'
    NIGHT = 'night'
    SHIFT_CHOICES = [
        (MORNING, 'Morning'),
        (EVENING, 'Evening'),
        (NIGHT, 'Night'),
    ]
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    weight = models.FloatField(null=True, blank=True)
    height = models.FloatField(null=True, blank=True)
    bmi = models.FloatField(null=True, blank=True)
    age = models.IntegerField(null=True, blank=True)
    gender = models.CharField(max_length=10, blank=True)
    shift = models.CharField(max_length=10, choices=SHIFT_CHOICES, default=MORNING)

    def __str__(self):
        return f"{self.user.username} details"
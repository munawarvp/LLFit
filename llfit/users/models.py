from django.db import models
from django.contrib.auth.models import User

# Create your models here.
class UserMetrics(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    weight = models.FloatField(null=True, blank=True)
    height = models.FloatField(null=True, blank=True)
    bmi = models.FloatField(null=True, blank=True)

    def __str__(self):
        return f"{self.user.username} metrics details"
    
class UserProfile(models.Model):
    MORNING = 'morning'
    EVENING = 'evening'
    NIGHT = 'night'
    SHIFT_CHOICES = [
        (MORNING, 'Morning'),
        (EVENING, 'Evening'),
        (NIGHT, 'Night'),
    ]
    BEGINNER = 'beginner'
    INTERMEDIATE = 'intermediate'
    EXPERT = 'expert'

    LEVEL_CHOICES = [
        (BEGINNER, 'Beginner'),
        (INTERMEDIATE, 'Intermediate'),
        (EXPERT, 'Expert'),
    ]
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    phone_number = models.CharField(max_length=20)
    age = models.IntegerField(null=True, blank=True)
    gender = models.CharField(max_length=10, blank=True)
    shift = models.CharField(max_length=10, choices=SHIFT_CHOICES, default=MORNING)
    level = models.CharField(max_length=20,choices=LEVEL_CHOICES,default=BEGINNER)
    address = models.CharField(max_length=100)

    def __str__(self):
        return f"{self.user.username} profile details"
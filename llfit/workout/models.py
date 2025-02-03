from django.db import models
from django.contrib.auth.models import User

# Create your models here.

class Excerise(models.Model):
    BEGINNER = 'beginner'
    INTERMEDIATE = 'intermediate'
    EXPERT = 'expert'

    LEVEL_CHOICES = [
        (BEGINNER, 'Beginner'),
        (INTERMEDIATE, 'Intermediate'),
        (EXPERT, 'Expert'),
    ]
    name = models.CharField(max_length=255)
    type = models.CharField(max_length=255, null=True, blank=True)
    muscle = models.CharField(max_length=255)
    equipment = models.CharField(max_length=255, null=True, blank=True)
    difficulty = models.CharField(max_length=255, choices=LEVEL_CHOICES)
    instructions = models.TextField()
    image = models.CharField(null=True, blank=True)

    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def __str__(self):
        return self.name
    

class UserWorkout(models.Model):
    WEEK_DAYS = [
        ('monday', 'Monday'),
        ('tuesday', 'Tuesday'),
        ('wednesday', 'Wednesday'),
        ('thursday', 'Thursday'),
        ('friday', 'Friday'),
        ('saturday', 'Saturday'),
        ('sunday', 'Sunday'),
    ]
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    excerise = models.ForeignKey(Excerise, on_delete=models.CASCADE)
    day = models.CharField(max_length=255, choices=WEEK_DAYS)
    is_completed = models.BooleanField(default=False)

    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def __str__(self):
        return f"{self.user.username} - {self.excerise.name}"
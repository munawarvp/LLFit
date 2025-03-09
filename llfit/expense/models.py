from django.db import models

from django.contrib.auth.models import User

# Create your models here.

class Expense(models.Model):
    EXPENSE_TYPES = [
        ('paid in', 'PAID IN'),
        ('paid out', 'PAID OUT'),
    ]
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    amount = models.DecimalField(max_digits=10, decimal_places=2)
    category = models.CharField(max_length=255)
    description = models.CharField(max_length=255)
    date = models.DateField()
    type = models.CharField(max_length=255, choices=EXPENSE_TYPES)

    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def __str__(self):
        return f"{self.user.username} - {self.date} - {self.category}"

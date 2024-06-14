

from django.contrib.auth.models import User
from django.core.mail import EmailMessage, get_connection
from django.conf import settings

from users.models import UserMetrics
from .schemas import UserMetricsCreate


def send_activation_mail(user):
    with get_connection(  
        host=settings.EMAIL_HOST, 
        port=settings.EMAIL_PORT,  
        username=settings.EMAIL_HOST_USER, 
        password=settings.EMAIL_HOST_PASSWORD, 
        use_tls=settings.EMAIL_USE_TLS  
    ) as connection: 
        subject = "Account Creation Success..!" 
        email_from = settings.EMAIL_HOST_USER  
        recipient_list = [user.email]  
        message = f"You account with {user.email} has created, Please verify"  
        response = EmailMessage(subject, message, email_from, recipient_list, connection=connection).send()
        return response
    

def get_or_create_user_metrics_record(data_obj: UserMetricsCreate):
    try:
        user = User.objects.get(id=data_obj.user)
        user_metrics = UserMetrics.objects.filter(user=user.id)
        if not user_metrics:
            data = data_obj.model_dump()
            user = User.objects.get(id=data_obj.user)
            data['user'] = user
            user_metrics = UserMetrics.objects.create(**data)
    except Exception as e:
        user_metrics=None
    return user_metrics
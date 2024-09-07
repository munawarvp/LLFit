import requests

from decouple import config
from django.conf import settings
from django.core.mail import send_mail
from django.contrib.auth.models import User
from django.utils.encoding import force_bytes
from django.contrib.auth.tokens import default_token_generator
from django.utils.http import urlsafe_base64_encode, urlsafe_base64_decode
from django.contrib.sites.shortcuts import get_current_site
from apscheduler.schedulers.background import BackgroundScheduler

from llfit.constants import activation_mail_content
from users.models import UserMetrics, UserProfile
from .schemas import UserMetricsCreate, UserProfileCreate


def send_activation_mail(request, user):
    domain = get_current_site(request)
    mail_subject = 'User activation mail'
    user_en_id = urlsafe_base64_encode(force_bytes(user.id))
    token = default_token_generator.make_token(user)
    activation_link = f"{domain}/api/user/activate-user?uid={user_en_id}&token={token}"
    mail_message = activation_mail_content(user.username, activation_link)

    result = send_mail(
        subject=mail_subject,
        message=mail_message,
        from_email=settings.EMAIL_HOST_USER,
        recipient_list=[user.email],
        fail_silently=False
    )
    return result
    
def activate_user_token(uid: str, token: str):
    user_id = urlsafe_base64_decode(uid).decode()
    user = User.objects.get(id=user_id)
    validate_token = default_token_generator.check_token(user, token)
    if validate_token:
        user.is_active=True
        user.save()
        return validate_token
    else:
        return False


def create_user_metrics_record(data_obj: UserMetricsCreate):
    try:
        data = data_obj.model_dump()
        user = User.objects.get(id=data_obj.user)
        data['user'] = user
        user_metrics = UserMetrics.objects.create(**data)
    except Exception as e:
        user_metrics=None
    return user_metrics


def create_user_profile_record(data_obj: UserProfileCreate):
    try:
        data = data_obj.model_dump()
        user = User.objects.get(id=data_obj.user)
        data['user'] = user
        user_profile = UserProfile.objects.create(**data)
    except Exception as e:
        user_profile=None
    return user_profile


def calculate_latest_bmi(metrics_id: int):
    try:
        user_metrics = UserMetrics.objects.get(id=metrics_id)
        height = (user_metrics.height/100) ** 2
        bmi = user_metrics.weight/height
        user_metrics.bmi = round(bmi, 2)
        user_metrics.save()
    except Exception as e:
        user_metrics = None
    return user_metrics


def health_checking():
    domain = config('DOMAIN')
    response = requests.get(f"{domain}/api/user/health")
    return response

def schedule_job():
    scheduler = BackgroundScheduler()
    if not scheduler.get_jobs():
        scheduler.add_job(
            health_checking,
            "interval",
            seconds=45
        )
        scheduler.start()
        return {'success': True, 'message': 'Job scheduled'}
    else:
        return {'success': False, 'message': 'Job already running'}


def metrics_report(user, filter_model):
    metrics = UserMetrics.objects.filter(user=user.id).values('weight', 'created_at')
    return metrics
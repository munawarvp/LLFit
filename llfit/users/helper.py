from django.core.mail import EmailMessage, get_connection
from django.conf import settings


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
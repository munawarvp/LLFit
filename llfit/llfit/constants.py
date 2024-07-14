
def activation_mail_content(user_name: str, activation_link: str):
    message = f"Hello {user_name}, Please click the link below to activate your account..! {activation_link}"
    return message
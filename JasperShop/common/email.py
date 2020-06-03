from main.models import User, SystemConfig, ActivationEmail
from email.mime.text import MIMEText
from common.config import *
from django.utils import timezone
import smtplib, random, datetime, string

def SendActivationEmail(user):

    activationEmail = CreateActivationData(user)
    enable_url = base_url + 'user/enable/' + activationEmail.random_string
    mail = SystemConfig.objects.get(name="gmail")
    mailAC = mail.value1
    mailPW = mail.value2

    message = MIMEText('%s 您好！\n\n　　歡迎您加入 Jasper Shop！請點擊以下連結以啟用帳號享受全部的功能！\n\n　　%s\n\n祝 順心\n\nJasper Shop 營運團隊敬上'  % (user.name, enable_url))
    message['Subject'] = '【Jasper Shop】 %s 您好！帳號驗證啟用信 ※30分鐘內有效' % user.name
    message['From'] = mailAC
    message['To'] = user.email

    server = smtplib.SMTP_SSL("smtp.gmail.com", 465)
    server.ehlo()
    server.login(mailAC, mailPW)
    server.send_message(message)
    server.quit()

    return True

def CreateActivationData(user):
    
    now = timezone.now()

    if ActivationEmail.objects.filter(to_user_id=user.id, is_expired=False).count() > 0:

        ActivationEmail.objects.filter(to_user_id=user.id, is_expired=False).update(is_expired=True, expire_time=now)
    
    randomString = ''.join(random.choices(string.ascii_letters + string.digits, k=70))

    activationEmail = ActivationEmail.objects.create(to_user_id=user.id,
                                                    random_string=randomString,
                                                    send_time=now,
                                                    expire_time=now+datetime.timedelta(minutes=30))

    return activationEmail

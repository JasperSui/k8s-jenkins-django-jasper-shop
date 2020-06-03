from django.shortcuts import render, HttpResponse
from django.http import JsonResponse
from django.contrib.auth.hashers import *
from main.forms import UserRegisterForm
from main.models import User, SystemConfig, ActivationEmail, Carousel, Product, Order
from common.email import *
from common.config import *
from email.mime.text import MIMEText
from django.utils import timezone
from django.forms.models import model_to_dict
from django.http import HttpResponseRedirect
import pdb
import json
import datetime

def purchase(request, order_status_id):

    userRegisterForm = UserRegisterForm()

    if 'user_id' in request.session:

        user = User.objects.get(id=request.session['user_id'])

    else:

        user = None

    if not user:

        return HttpResponseRedirect(base_url + '?ShowLoginModal=true&RedirectURL=user/purchase')

    else:

        cart_list = request.session.get("cart_list")

        cart_number = len(cart_list)

        order_list = Order.objects.filter(user_id=user.id,
                                          order_status_id=order_status_id)

        all_order_list = Order.objects.filter(user_id=user.id)

        waiting_for_pay_number = len(all_order_list.filter(order_status_id=1))
        waiting_for_ship_number = len(all_order_list.filter(order_status_id=2))
        waiting_for_receive_number = len(all_order_list.filter(order_status_id=3))
        finished_number = len(all_order_list.filter(order_status_id=4))
        cancelled_number = len(all_order_list.filter(order_status_id=5))
        

    return render(request, 'user/purchase.html', locals())

# Create your views here.

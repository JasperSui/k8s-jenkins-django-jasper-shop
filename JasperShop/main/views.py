from django.shortcuts import render, HttpResponse
from django.http import JsonResponse
from django.contrib.auth.hashers import *
from .forms import UserRegisterForm
from .models import User, SystemConfig, ActivationEmail, Carousel, Product, Order, Tag, ProductTag, LimitedTimeProduct
from common.email import *
from email.mime.text import MIMEText
from django.utils import timezone
from django.forms.models import model_to_dict
from django.http import HttpResponseRedirect
from django.db import transaction
from main.tasks import TaskChangeOrderStatus
import pdb, json, datetime
from django.views.decorators.csrf import csrf_exempt

def Index(request):

    userRegisterForm = UserRegisterForm()

    if 'user_id' in request.session:

        user = User.objects.get(id=request.session['user_id'])
    
    else:

        user = None
    
    if user:

        cart_list = request.session.get("cart_list")

        if cart_list:

            cart_number = len(cart_list)
        
        else:

            cart_number = 0
    
    carousel = Carousel.objects.filter(is_enabled=True)

    product = Product.objects.filter(is_enabled=True)

    return render(request, 'main/index.html', locals())

def Item(request, product_id):

    userRegisterForm = UserRegisterForm()

    if 'user_id' in request.session:

        user = User.objects.get(id=request.session['user_id'])

    else:

        user = None

    if user:

        cart_list = request.session.get("cart_list")

        if cart_list:

            cart_number = len(cart_list)

        else:

            cart_number = 0

    product = Product.objects.get(id=product_id)

    original_price = round(product.price * 1.4)

    return render(request, 'main/item.html', locals())

def LimitedItem(request, limited_product_id):

    userRegisterForm = UserRegisterForm()

    if 'user_id' in request.session:

        user = User.objects.get(id=request.session['user_id'])

    else:

        user = None

    if user:

        cart_list = request.session.get("cart_list")

        if cart_list:

            cart_number = len(cart_list)

        else:

            cart_number = 0

    
    limited_product = LimitedTimeProduct.objects.get(id=limited_product_id)

    return render(request, 'main/limited_item.html', locals())

def Cart(request):

    if 'user_id' in request.session:

        user = User.objects.get(id=request.session['user_id'])

    else:

        user = None

    if not user:

        return HttpResponseRedirect(base_url + '?ShowLoginModal=true&RedirectURL=cart')

    else:

        cart_list = request.session.get("cart_list")

        if cart_list:

            cart_number = len(cart_list)

        else:

            cart_number = 0

    product_number_list = list()
    total_product_number = 0
    total_product_amount = 0

    if cart_list:

        for unit in cart_list:

            temp_product = Product.objects.get(id=unit[0])
            product_number_list.append([temp_product, unit[1], temp_product.price*unit[1]])

            total_product_number += unit[1]
            total_product_amount += temp_product.price*unit[1]
    
    return render(request, 'main/cart.html', locals())

def Search(request, keyword):

    if 'user_id' in request.session:

        user = User.objects.get(id=request.session['user_id'])

    else:

        user = None

    if not user:

        return HttpResponseRedirect(base_url + '?ShowLoginModal=true&RedirectURL=cart')

    else:

        cart_list = request.session.get("cart_list")

        if cart_list:

            cart_number = len(cart_list)

        else:

            cart_number = 0
    
    keyword_list = keyword.split(' ')
    product_list = Product.objects.none()

    '''
    1. 先找Keyword有沒有在標籤裡
        1A. 有，找有此標籤的product，存入到product_list
        1B. 無，找出所有Product，找有沒有包含該字元的商品名
    '''
    
    for k in keyword_list:

        try:

            tag = Tag.objects.get(name=k)

        except Tag.DoesNotExist:

            tag = None

        if tag:

            product_id_list = ProductTag.objects.filter(tag_id=tag.id).values_list('product_id', flat=True)

            temp_product_list = Product.objects.filter(id__in=product_id_list)

            product_list |= temp_product_list
        
        else:

            temp_product_list = Product.objects.filter(name__contains=k)

            product_list |= temp_product_list

    product_list = product_list.values().distinct()

    keyword = keyword

    result_number = len(product_list)

    return render(request, 'main/search.html', locals())

def UserLogout(request):

    del request.session['user_id']

    return HttpResponseRedirect("/")

def UserEnable(request, randomString):

    now = timezone.now()

    try:

        originalData = ActivationEmail.objects.get(random_string=randomString)

    except ActivationEmail.DoesNotExist:

        originalData = None

    if originalData is None:

        message = "未知錯誤。"

        return render(request, 'main/enable.html', locals())

    try:

        user = User.objects.get(id=originalData.to_user_id)

    except User.DoesNotExist:

        user = None

    if user is None:

        message = "未知錯誤。"

        return render(request, 'main/enable.html', locals())

    if originalData.expire_time < now:

        message = "該連結已過期，請重新收取驗證信！"

        return render(request, 'main/enable.html', locals())

    if user.is_enabled:

        message = "該帳號已啟用！"

    else:

        user.is_enabled = True
        user.update_time = now
        user.save()

        originalData.is_expired = True
        originalData.expire_time = now
        originalData.save()

        message = "帳號啟用成功！"

    return render(request, 'main/enable.html', locals())

def LimitedTimeSale(request):

    if 'user_id' in request.session:

        user = User.objects.get(id=request.session['user_id'])

    else:

        user = None

    if user:

        cart_list = request.session.get("cart_list")

        if cart_list:

            cart_number = len(cart_list)

        else:

            cart_number = 0

    product_list = LimitedTimeProduct.objects.all()
    
    return render(request, 'main/limited_time_sale.html', locals())

# ----- AJAX View Functions Below -----

def UserLogin(request):

    result = {"status": False, "errcode": None, "errmsg": None}
    
    # 登入 Post
    if request.is_ajax():

        if request.method == "POST":

            login_account = request.POST.get('login_account')
            login_password = request.POST.get('login_password')

            if '@' in login_account:

                try:

                    user = User.objects.get(email=login_account)

                except User.DoesNotExist:

                    user = None
            else:

                try:

                    user = User.objects.get(telephone=login_account)

                except User.DoesNotExist:

                    user = None
            
            if user is None:

                result['errcode'] = 40003
                result['errmsg'] = "你的帳號或密碼不正確，請稍後再試。"

                return JsonResponse(result)
            
            if check_password(login_password, user.password):

                request.session['user_id'] = user.id
                result['status'] = True

                return JsonResponse(result)
            
            else:

                result['errcode'] = 40003
                result['errmsg'] = "你的帳號或密碼不正確，請稍後再試。"
  
        else:

            result['errcode'] = 40001
            result['errmsg'] = "非 Post 請求"

    else:

        result['errcode'] = 40002
        result['errmsg'] = "非 Ajax 請求"

    return JsonResponse(result)

def UserRegister(request):

    result = {"status": False, "errcode": None, "errmsg": None}

    if request.is_ajax():

        if request.method == "POST":

            userRegisterForm = UserRegisterForm(request.POST)

            if userRegisterForm.is_valid():

                user = User(email=userRegisterForm.cleaned_data['email'],
                            telephone=userRegisterForm.cleaned_data['telephone'],
                            account=userRegisterForm.cleaned_data['account'],
                            password=make_password(userRegisterForm.cleaned_data['password']),
                            name=userRegisterForm.cleaned_data['name'],
                            create_time=timezone.now())
                user.save()

                if user is None:

                    result['errcode'] = 50000
                    result['errmsg'] = "未知錯誤，使用者創建失敗"
                
                else:

                    result['status'] = SendActivationEmail(user)

            else:

                result['errcode'] = 40000
                result['errmsg'] = userRegisterForm.errors

        else:

            result['errcode'] = 40001
            result['errmsg'] = "非 Post 請求"

    else:

        result['errcode'] = 40002
        result['errmsg'] = "非 Ajax 請求"

    return JsonResponse(result)

def UserResendActivationEmail(request):

    result = {"status": False, "errcode": None, "errmsg": None}

    if request.is_ajax():

        if request.method == "POST":

            email = request.POST.get('reactivate_email')

            try:

                user = User.objects.get(email=email)

            except User.DoesNotExist:

                user = None

            if user is None:

                result['errcode'] = 50001
                result['errmsg'] = "使用者不存在！"

            if user.is_enabled:

                result['errcode'] = 50002
                result['errmsg'] = "使用者已啟用！"

            else:

                result['status'] = SendActivationEmail(user)

        else:

            result['errcode'] = 40001
            result['errmsg'] = "非 Post 請求"

    else:

        result['errcode'] = 40002
        result['errmsg'] = "非 Ajax 請求"

    return JsonResponse(result)

def AddToCart(request):

    result = {"status": False, "errcode": None, "errmsg": None}

    if request.is_ajax():

        if request.method == "POST":

            product_id = request.POST.get('product_id')
            product_number = int(request.POST.get('product_number'))

            try:

                product = Product.objects.get(id=product_id)

            except Product.DoesNotExist:

                product = None

            if product is None:

                result['errcode'] = 50001
                result['errmsg'] = "商品不存在！"
            
            else:
                #cart_list = list() ex:[[1, 50], [2, 3]]
                cart_list = request.session.get("cart_list")
                
                if cart_list:

                    is_existed_in_cart = False

                    for product_number_list in cart_list:
                        
                        if product_number_list[0] == product.id:

                            product_number_list[1] += product_number

                            is_existed_in_cart = True
                    
                    if not is_existed_in_cart:

                        cart_list.append([product.id, product_number])

                    request.session["cart_list"] = cart_list
                
                else:

                    request.session["cart_list"] = [[product.id, product_number]]
                
                result['status'] = True

        else:

            result['errcode'] = 40001
            result['errmsg'] = "非 Post 請求"

    else:

        result['errcode'] = 40002
        result['errmsg'] = "非 Ajax 請求"

    return JsonResponse(result)

def RemoveFromCart(request):

    result = {"status": False, "errcode": None, "errmsg": None}

    if request.is_ajax():

        if request.method == "POST":

            product_id = request.POST.get('product_id')

            try:

                product = Product.objects.get(id=product_id)

            except Product.DoesNotExist:

                product = None

            if product is None:

                result['errcode'] = 50001
                result['errmsg'] = "商品不存在！"

            else:
                #cart_list = list() ex:[[1, 50], [2, 3]]
                cart_list = request.session.get("cart_list")
                temp_list = list()

                if cart_list:

                    for product_number_list in cart_list:

                        if product_number_list[0] == product.id:

                            temp_list = [product_number_list[0], product_number_list[1]]

                            break

                    cart_list.remove(temp_list)

                    request.session["cart_list"] = cart_list
                    result['status'] = True

                else:

                    result['errcode'] = 50003
                    result['errmsg'] = "未知錯誤！"


        else:

            result['errcode'] = 40001
            result['errmsg'] = "非 Post 請求"

    else:

        result['errcode'] = 40002
        result['errmsg'] = "非 Ajax 請求"

    return JsonResponse(result)

@csrf_exempt
def BuyItem(request):
    
    result = {"status": False, "errcode": None, "errmsg": None}
    #pdb.set_trace()
    if 'user_id' in request.session:

        user = User.objects.get(id=request.session['user_id'])

    else:

        user = None

    cart_list = request.session.get('cart_list')
    product_number_list = list()

    if not user:

        result['errcode'] = 50005
        result['errmsg'] = "使用者無權限。"

        return JsonResponse(result)

    '''if not cart_list:

        result['errcode'] = 50006
        result['errmsg'] = "未知錯誤。"

        return JsonResponse(result)
'''
    #pdb.set_trace()
    if True:

        if request.method == "POST":

            '''if len(request.POST) <= 0:

                result['errcode'] = 50006
                result['errmsg'] = "未知錯誤。"

                return JsonResponse(result)
            pdb.set_trace()
            for i in range(0, len(request.POST)):

                temp_list = request.POST.getlist('product_number_list[%s][]' % str(i))

                product_number_list.append(temp_list)
'''
            product_number_list = [[2,1]]
            with transaction.atomic():

                for unit in product_number_list:

                    product_id = int(unit[0])
                    product_number = int(unit[1])

                    try:

                        product = Product.objects.select_for_update().get(id=product_id)

                    except Product.DoesNotExist:

                        product = None

                    if not product:

                        result['errcode'] = 50006
                        result['errmsg'] = "未知錯誤。"

                        return JsonResponse(result)

                    if product.stock < product_number:

                        result['errcode'] = 50004
                        result['errmsg'] = "商品庫存不足！"

                        return JsonResponse(result)
                    
                    else:

                        order = Order(user_id=user.id,
                                    product_id=product.id,
                                    order_status_id=1,
                                    number=product_number,
                                    price=product.price,
                                    amount=product.price*product_number,
                                    buy_time=timezone.now()
                                    )

                        order.save()

                        #cart_list.remove([product.id, product_number])
                        product.stock -= product_number
                        product.save()

                        #TaskChangeOrderStatus.apply_async((order.id,), countdown=300)
                        #TaskChangeOrderStatus.apply_async((order.id,), countdown=1800)
                        #TaskChangeOrderStatus.apply_async((order.id,), countdown=3600)


                result['status'] = True
                request.session['cart_list'] = cart_list

        else:

            result['errcode'] = 40001
            result['errmsg'] = "非 Post 請求"

    else:

        result['errcode'] = 40002
        result['errmsg'] = "非 Ajax 請求"

    return JsonResponse(result)

def PurchaseDirectly(request):

    result = {"status": False, "errcode": None, "errmsg": None}

    if request.is_ajax():

        if request.method == "POST":

            product_id = request.POST.get('product_id')
            product_number = int(request.POST.get('product_number'))

            try:

                product = Product.objects.get(id=product_id)

            except Product.DoesNotExist:

                product = None

            if product is None:

                result['errcode'] = 50001
                result['errmsg'] = "商品不存在！"

            else:
                #cart_list = list() ex:[[1, 50], [2, 3]]
                cart_list = request.session.get("cart_list")

                if cart_list:

                    is_existed_in_cart = False

                    for product_number_list in cart_list:

                        if product_number_list[0] == product.id:

                            product_number_list[1] += product_number

                            is_existed_in_cart = True

                    if not is_existed_in_cart:

                        cart_list.append([product.id, product_number])

                    request.session["cart_list"] = cart_list

                else:

                    request.session["cart_list"] = [
                        [product.id, product_number]]

                result['status'] = True

        else:

            result['errcode'] = 40001
            result['errmsg'] = "非 Post 請求"

    else:

        result['errcode'] = 40002
        result['errmsg'] = "非 Ajax 請求"

    return JsonResponse(result)

def BuyLimitedItem(request):

    result = {"status": False, "errcode": None, "errmsg": None}

    if 'user_id' in request.session:

        user = User.objects.get(id=request.session['user_id'])

    else:

        user = None

    if not user:

        result['errcode'] = 50005
        result['errmsg'] = "使用者無權限。"

        return JsonResponse(result)

    if request.is_ajax():

        if request.method == "POST":

            if len(request.POST) <= 0:

                result['errcode'] = 50006
                result['errmsg'] = "未知錯誤。"

                return JsonResponse(result)

            limited_product_id = request.POST.get('limited_product_id')
            now = timezone.now()

            with transaction.atomic():

                try:
                    
                    limited_product = LimitedTimeProduct.objects.get(id=limited_product_id)

                except LimitedTimeProduct.DoesNotExist:

                    product = None

                if not limited_product:

                    result['errcode'] = 50006
                    result['errmsg'] = "未知錯誤。"

                    return JsonResponse(result)

                if limited_product.stock == 0:

                    result['errcode'] = 50004
                    result['errmsg'] = "商品庫存不足！"

                    return JsonResponse(result)

                if timezone.now() < limited_product.start_time:

                    result['errcode'] = 50007
                    result['errmsg'] = "還未開放！"

                    return JsonResponse(result)

                if timezone.now() > limited_product.end_time:

                    result['errcode'] = 50008
                    result['errmsg'] = "已過期！"

                    return JsonResponse(result)

                else:

                    order = Order(user_id=user.id,
                                  product_id=limited_product.product.id,
                                  order_status_id=1,
                                  number=1,
                                  price=limited_product.special_price,
                                  amount=limited_product.special_price,
                                  buy_time=timezone.now()
                                    )

                    order.save()

                    limited_product.stock -= 1
                    limited_product.save()

                    #TaskChangeOrderStatus.apply_async(
                    #    (order.id,), countdown=300)
                    #TaskChangeOrderStatus.apply_async(
                    #    (order.id,), countdown=1800)
                    #TaskChangeOrderStatus.apply_async(
                    #    (order.id,), countdown=3600)

                result['status'] = True

        else:

            result['errcode'] = 40001
            result['errmsg'] = "非 Post 請求"

    else:

        result['errcode'] = 40002
        result['errmsg'] = "非 Ajax 請求"

    return JsonResponse(result)

def StaticPage(request):

    return HttpResponse('')
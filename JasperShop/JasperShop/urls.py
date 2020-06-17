"""JasperShop URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/2.2/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
from django.urls import path
from django.urls import include
from django.contrib.staticfiles.urls import staticfiles_urlpatterns
from django.conf.urls.static import static
from django.conf import settings
from main import views

urlpatterns = [
    path('', views.Index, name='Index'),
    path('cart/', views.Cart, name='Cart'),
    path('item/<int:product_id>', views.Item, name='Item'),
    path('limited_item/<int:limited_product_id>', views.LimitedItem, name='LimitedItem'),
    path('user/enable/<str:randomString>', views.UserEnable, name='UserEnable'),
    path('search/<str:keyword>', views.Search, name='Search'),
    path('limited_time_sale/', views.LimitedTimeSale, name='LimitedTimeSale'),
    path('static_page/', views.StaticPage, name='StaticPage'),
    path('UserLogout/', views.UserLogout, name='UserLogout'),
    path('ajax/UserLogin/', views.UserLogin, name='UserLogin'),
    path('ajax/UserRegister/', views.UserRegister, name='UserRegister'),
    path('ajax/UserResendActivationEmail/', views.UserResendActivationEmail, name='UserResendActivationEmail'),
    path('ajax/AddToCart/', views.AddToCart, name='AddToCart'),
    path('ajax/RemoveFromCart/', views.RemoveFromCart, name='RemoveFromCart'),
    path('ajax/BuyItem/', views.BuyItem, name='BuyItem'),
    path('ajax/BuyLimitedItem/', views.BuyLimitedItem, name='BuyLimitedItem'),
    path('ajax/PurchaseDirectly/', views.PurchaseDirectly, name='PurchaseDirectly'),
    path('ajax/PurchaseDirectlyy/', views.PurchaseDirectly, name='PurchaseDirectly'),
    path('user/', include('user.urls'))
] + static(settings.STATIC_URL, document_root=settings.STATIC_ROOT)

urlpatterns += staticfiles_urlpatterns()

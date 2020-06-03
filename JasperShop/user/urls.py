from django.urls import path
from user import views

urlpatterns = [
    path('purchase/<int:order_status_id>/', views.purchase, name="Purchase")
]

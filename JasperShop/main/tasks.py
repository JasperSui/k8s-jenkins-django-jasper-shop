from __future__ import absolute_import, unicode_literals
from JasperShop.celery import app
from main.models import Order

@app.task
def TaskChangeOrderStatus(order_id):
    order = Order.objects.get(id=order_id)
    order.order_status_id = order.order_status_id + 1
    order.save()
    if order.order_status_id == order.order_status_id + 1:
        return True
    else:
        return False

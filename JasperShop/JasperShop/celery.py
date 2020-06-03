from __future__ import absolute_import, unicode_literals
import os
from celery import Celery, platforms
from django.conf import settings

platforms.C_FORCE_ROOT = True

# set the default Django settings module for the 'celery' program.
os.environ.setdefault('DJANGO_SETTINGS_MODULE',
                      'JasperShop.settings')

app = Celery('JasperShop')

app.config_from_object('django.conf:settings')

app.autodiscover_tasks(lambda: settings.INSTALLED_APPS)


@app.task(bind=True)
def debug_task(self):
    print('Request: {0!r}'.format(self.request))

# celery -A JasperShop worker -l info
# celery flower -A JasperShop

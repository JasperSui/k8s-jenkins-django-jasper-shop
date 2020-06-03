import os

os_name = os.name

if os_name == 'nt':
    base_url = 'http://127.0.0.1:8000/'
elif os_name == 'posix':
    base_url = 'http://127.0.0.1:8000/'

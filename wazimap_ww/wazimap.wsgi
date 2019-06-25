import os
import sys

path='/home/wider/wazimap_ww/'

if path not in sys.path:
  sys.path.append(path)

os.environ['DJANGO_SETTINGS_MODULE'] = 'wazimap_ww.settings'

import django.core.handlers.wsgi
application = django.core.handlers.wsgi.WSGIHandler()

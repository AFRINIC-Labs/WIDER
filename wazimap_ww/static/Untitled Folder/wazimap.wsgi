import os
import sys
import site

# Add the site-packages of the chosen virtualenv to work with
site.addsitedir('/home/wider/ENV/lib/python2.7/site-packages')

# Add the app's directory to the PYTHONPATH
sys.path.append('/home/wider/wazimap_ww/')
sys.path.append('/home/wider/wazimap_ww/wazimap_ww')

# Activate your virtual env
activate_env=os.path.expanduser("/home/wider/ENV/bin/activate_this.py")
execfile(activate_env, dict(__file__=activate_env))

os.environ['DJANGO_SETTINGS_MODULE'] = 'wazimap_ww.settings'

import django.core.handlers.wsgi
application = django.core.handlers.wsgi.WSGIHandler()
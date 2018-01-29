# pull in the default wazimap settings
from wazimap.settings import *  # noqa

# install this app before Wazimap
INSTALLED_APPS = ['wazimap_ww'] + INSTALLED_APPS

# Localise this instance of Wazimap
WAZIMAP['name'] = 'WIDER'
# NB: this must be https if your site supports HTTPS.
WAZIMAP['url'] = ' http://widerlouw.vanilla.co.za/'
WAZIMAP['country_code'] = 'WW'

WAZIMAP['levels'] = {
    'world': {
        'plural': 'worlds',
        'children': ['country']
    },
    'country': {
        'plural': 'countries'
    }
}

WAZIMAP['comparative_levels'] = ['world', 'country']

WAZIMAP['geometry_data'] = {
  '': {
      'country': 'geo/world.geojson', 
      'vdc': 'geo/country.geojson'
  }
}

WAZIMAP['profile_builder'] = 'wazimap_ww.profiles.get_profile'
WAZIMAP['map_centre'] = [0, 0]
WAZIMAP['map_zoom'] = 2

LOGGING = {
    'version': 1,
    'disable_existing_loggers': True,
    'formatters': {
      'standard': {
        'format': '%(asctime)s [%(levelname)s] %(name)s: %(message)s'
      }
    },
    'filters':{

    },
    'handlers': {
      'default': {
        'level': 'DEBUG',
        'class': 'logging.handlers.RotatingFileHandler',
        'filename': 'logs/mylog.log',
        'maxBytes': 1024*1024*5, # 5 MB,
        'backupCount': 5,
        'formatter': 'standard',
      },
      'request_handler': {
        'level': 'DEBUG',
        'class': 'logging.handlers.RotatingFileHandler',
        'filename': 'logs/django_request.log',
        'maxBytes': 1024*1024*5, # 5 MB,
        'backupCount': 5,
        'formatter': 'standard',
      }
    },
    'loggers': {
      '': {
        'handlers': ['default'],
        'level': 'DEBUG',
        'propagate': True
      },
      'django.request': {
        'handlers': ['request_handler'],
        'level': 'DEBUG',
        'propagate': False
      },
      'gdal.request': {
        'handlers': ['request_handler'],
        'level': 'DEBUG',
        'propagate': False
      }
    }
}
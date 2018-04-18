# pull in the default wazimap settings
from wazimap.settings import *  # noqa
import dj_database_url
import django
import logging.config


# install this app before Wazimap
INSTALLED_APPS = ['wazimap_ww'] + INSTALLED_APPS

# Localise this instance of Wazimap
WAZIMAP['name'] = 'WIDER'
# NB: this must be https if your site supports HTTPS.
WAZIMAP['url'] = 'https://wider.isoc.org.za'
WAZIMAP['country_code'] = 'WW'

ROOT_URLCONF = 'wazimap.urls'
WSGI_APPLICATION = 'wazimap.wsgi.application'

WAZIMAP['levels'] = {
    'world': {
        'plural': 'worlds',
        'children': ['continent']
    },
    'continent': {
        'plural': 'continents',
        'children': ['country']
    },
    'country': {
        'plural': 'countries',
        'children': []
    }
}


WAZIMAP['comparative_levels'] = ['world', 'continent', 'country']

WAZIMAP['geometry_data'] = {
  '2018-03': {
      'world': 'geo/world.topojson',
      'continent': 'geo/continent.topojson',
      'country': 'geo/country.topojson'
  }
}

WAZIMAP['default_geo_version'] = '2018-03'
WAZIMAP['profile_builder'] = 'wazimap_ww.profiles.get_profile'
WAZIMAP['map_centre'] = [45, 0]
WAZIMAP['map_zoom'] = 2

django.setup()

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
        'level': 'ERROR',
        'class': 'logging.handlers.RotatingFileHandler',
        'filename': '/home/wider/wazimap_ww/logs/mylog.log',
        'maxBytes': 1024*1024*5, # 5 MB,
        'backupCount': 5,
        'formatter': 'standard',
      },
      'request_handler': {
        'level': 'DEBUG',
        'class': 'logging.handlers.RotatingFileHandler',
        'filename': '/home/wider/wazimap_ww/logs/django_request.log',
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

logging.config.dictConfig(LOGGING)

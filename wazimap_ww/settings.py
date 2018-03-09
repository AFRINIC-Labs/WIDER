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
WAZIMAP['url'] = 'http://wider.isoc.org.za'
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
  '': {
      'world': 'geo/world.topojson', 
      'continent': 'geo/continent.topojson', 
      'country': 'geo/country.topojson'
  }
}


WAZIMAP['default_geo_version'] = ''
WAZIMAP['profile_builder'] = 'wazimap_ww.profiles.get_profile'
WAZIMAP['map_centre'] = [45, 0]
WAZIMAP['map_zoom'] = 2

django.setup()
LOGGING = {
    'version': 1,
    'disable_existing_loggers': True,
    'formatters': {
        'verbose': {
            'format': '%(asctime)s %(levelname)s %(module)s %(process)d %(thread)d %(message)s'
        },
    },
    'handlers': {
        'console': {
            'level': 'DEBUG',
            'class': 'logging.FileHandler',
            'filename': 'logs/mylog.log',
            'formatter': 'verbose'
        },
    },
    'loggers': {
        '': {
            'handlers': ['console'],
            'level': 'ERROR',
        },
        'census': {
            'level': 'DEBUG' if DEBUG else 'INFO',
        },
        'django': {
            'level': 'DEBUG' if DEBUG else 'INFO',
        },
        'django.template': {
            'level': 'ERROR',
        },
        'wazimap': {
            'level': 'DEBUG' if DEBUG else 'INFO',
        },
    }
}



logging.config.dictConfig(LOGGING)
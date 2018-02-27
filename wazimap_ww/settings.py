# pull in the default wazimap settings
from wazimap.settings import *  # noqa

# install this app before Wazimap
# INSTALLED_APPS = ['wazimap_ww'] + INSTALLED_APPS

# Localise this instance of Wazimap
WAZIMAP['name'] = 'WIDER'
# NB: this must be https if your site supports HTTPS.
WAZIMAP['url'] = 'http://wider.isoc.org.za/wider/'
WAZIMAP['country_code'] = 'WW'

DATABASE_URL = os.environ.get('DATABASE_URL', 'postgresql://wider:w1d3r@localhost/wider')
DATABASES = {
    'default': dj_database_url.parse(DATABASE_URL),
}

WAZIMAP['levels'] = {
    'world': {
        'plural': 'worlds',
        'children': ['country']
    },
    'country': {
        'plural': 'countries',
        'children': []
    }
}

WAZIMAP['comparative_levels'] = ['world', 'country']

WAZIMAP['geometry_data'] = {
  '': {
      'world': 'geo/world.topojson', 
      'country': 'geo/country.topojson'
  }
}


WAZIMAP['default_geo_version'] = ''
WAZIMAP['profile_builder'] = 'wazimap_ww.profiles.get_profile'
WAZIMAP['map_centre'] = [0, 0]
WAZIMAP['map_zoom'] = 2

LOGGING = {
        'version': 1,
        'disable_existing_loggers': False,
        'filters': {
            'require_debug_false': {
                '()': 'django.utils.log.RequireDebugFalse'
            }
        },
        'handlers': {
            'mail_admins': {
                'level': 'ERROR',
                'filters': ['require_debug_false'],
                'class': 'django.utils.log.AdminEmailHandler'
            },
            'console':{
                'level': 'DEBUG',
                'class': 'logging.StreamHandler'
            },
        },
        'loggers': {
            'django.request': {
                'handlers': ['mail_admins'],
                'level': 'ERROR',
                'propagate': True,
                },
            'cities': {
                'handlers': ['console'],
                'level': 'INFO'
            },

            }
    }
# -*- coding: utf-8 -*-

from collections import OrderedDict

from wazimap.data.tables import get_datatable, get_model_from_fields
from wazimap.data.utils import get_stat_data, get_objects_by_geo, \
    calculate_median
import populationjson
import logging

logger = logging.getLogger(__name__)

def get_demographics_profile(geo, session):
    simple_v6pop = get_datatable('st_v6pop')
    
    total_users, _ = simple_v6pop.get_stat_data(geo, 'total_users')
    total_isps, _ = simple_v6pop.get_stat_data(geo, 'total_isps')
    total_v6, _ = simple_v6pop.get_stat_data(geo, 'total_v6')

    return {
        'has_data': True,
        'total_users': {
            "name": "People",
            "values": {"this": total_users['total_users']['numerators']['this']}
        },
        'total_isps': {
            "name": "ISPs",
            "values": {"this": total_isps['total_isps']['numerators']['this']}
        },
        'total_v6': {
            "name": "IPv6",
            "values": {"this": total_v6['total_v6']['numerators']['this']}
        }
    }

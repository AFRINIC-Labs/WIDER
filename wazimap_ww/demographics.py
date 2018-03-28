# -*- coding: utf-8 -*-

from collections import OrderedDict

from wazimap.data.tables import get_datatable, get_model_from_fields
from wazimap.data.utils import get_stat_data, get_objects_by_geo, \
    calculate_median

import logging
logger = logging.getLogger(__name__)

def get_demographics_profile(geo, session):
    simple_v6pop = get_datatable('st_v6pop')
    total_users = OrderedDict()
    total_isps = OrderedDict()
    total_v6 = OrderedDict()

    try:
        total_users, _ = simple_v6pop.get_stat_data(geo, 'total_users')
    except Exception as e:
        total_users = {'total_users': {'numerators': {'this': 0}}}

    try:
        total_isps, _ = simple_v6pop.get_stat_data(geo, 'total_isps')
    except Exception as e:
        total_isps = {'total_users': {'numerators': {'this': 0}}}

    try:
        total_v6, _ = simple_v6pop.get_stat_data(geo, 'total_v6')
    except Exception as e:
        total_v6 = {'total_users': {'numerators': {'this': 0}}}
    

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

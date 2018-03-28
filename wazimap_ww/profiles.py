from wazimap.data.utils import get_session, merge_dicts, group_remainder
from wazimap.geo import geo_data

import logging
logger = logging.getLogger(__name__)

from wazimap_ww import (
    demographics,
    access,
    ipv6,
    marketshare,
    v6marketshare,
    asntypes
)


# ensure tables are loaded

PROFILE_SECTIONS = (
    'demographics',
    'access',
    'ipv6',
    'marketshare',
    'v6marketshare',
    'asntypes'
)


def get_profile(geo, profile_name, request):
    session = get_session()

    try:
        geo_summary_levels = geo_data.get_geometry(geo)
        data = {}

        for section in PROFILE_SECTIONS:
            function_name = 'get_%s_profile' % section
            if function_name in globals():
                func = globals()[function_name]
                data[section] = func(geo, session)

    finally:
        session.close()

    
    return data


def get_demographics_profile(geo, session):
    return demographics.get_demographics_profile(geo, session)

def get_access_profile(geo, session):
    return access.get_access_profile(geo, session)

def get_ipv6_profile(geo, session):
    return ipv6.get_ipv6_profile(geo, session)

def get_marketshare_profile(geo, session):
    return marketshare.get_marketshare_profile(geo, session)

def get_v6marketshare_profile(geo, session):
    return v6marketshare.get_v6marketshare_profile(geo, session)

def get_asntypes_profile(geo, session):
    return asntypes.get_asntypes_profile(geo, session)

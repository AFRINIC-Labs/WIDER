from collections import OrderedDict

from wazimap.data.tables import get_datatable, get_model_from_fields
from wazimap.data.utils import get_stat_data, get_objects_by_geo, \
    calculate_median

import logging

logger = logging.getLogger(__name__)

def get_ipv6_profile(geo, session):

	view_ft_v6users = None
	view_ft_v4_v6 = OrderedDict()
	REGION_RECODES = OrderedDict()
	REGION_IP = OrderedDict()

	try:
		if geo.geo_level == 'country':
			REGION_RECODES = OrderedDict([
			    ('country', geo.name),
			    ('continent', geo.parent.name)
			])
			view_ft_v6users, _ = get_stat_data(['type'], geo, session, table_name='ft_v6users_country_continent', recode=dict(REGION_RECODES), key_order=REGION_RECODES.values())
		elif geo.geo_level == 'continent':
			REGION_RECODES = OrderedDict([
			    ('continent', geo.name),
			    ('world', geo.parent.name)
			])
			view_ft_v6users, _ = get_stat_data(['type'], geo, session, table_name='ft_v6users_continent_world', recode=dict(REGION_RECODES), key_order=REGION_RECODES.values())
		elif geo.geo_level == 'world':
			view_ft_v6users, _ = get_stat_data(['type'], geo, session, table_name='ft_v6users_world_continent')
	except Exception as e:
		view_ft_v6users = None

	try:
		REGION_IP = OrderedDict([
			    ('ipv6', 'IPv6'),
			    ('ipv4', 'IPv4')
		])
		view_ft_v4_v6, _ = get_stat_data(['type'], geo, session, table_name='ft_v4_v6', recode=dict(REGION_IP), key_order=REGION_IP.values())
	except Exception as e:
		view_ft_v4_v6 =  {'IPv6': {'numerators': {'this': 0}}}

	#view_ft_v6_alloc_vs_usage, _ = get_stat_data(['usage_vs_alloc'], geo, session, table_name='ft_v6_alloc_vs_usage')

	return	{'view_ft_v4_v6_users':{
		"name": "Active IPv6 users",
		"values": {"this": view_ft_v4_v6['IPv6']['numerators']['this']}
	},
	'view_ft_v4_v6': view_ft_v4_v6,
	'view_ft_v6users': view_ft_v6users
	#'view_ft_v6_alloc_vs_usage': view_ft_v6_alloc_vs_usage
	}

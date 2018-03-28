from collections import OrderedDict

from wazimap.data.tables import get_datatable, get_model_from_fields
from wazimap.data.utils import get_stat_data, get_objects_by_geo, \
    calculate_median

def get_ipv6_profile(geo, session):

	view_ft_v6users = None
	view_ft_v4_v6 = OrderedDict()

	try:
		if geo.geo_level == 'country':
			view_ft_v6users, _ = get_stat_data(['type'], geo, session, table_name='ft_v6users_country_continent')
		elif geo.geo_level == 'continent':
			view_ft_v6users, _ = get_stat_data(['type'], geo, session, table_name='ft_v6users_continent_world')
		elif geo.geo_level == 'world':
			view_ft_v6users, _ = get_stat_data(['type'], geo, session, table_name='ft_v6users_world_continent')
	except Exception as e:
		view_ft_v6users = None

	try:
		view_ft_v4_v6, _ = get_stat_data(['type'], geo, session, table_name='ft_v4_v6')
	except Exception as e:
		view_ft_v4_v6 =  {'Ipv6': {'numerators': {'this': 0}}}


	#view_ft_v6_alloc_vs_usage, _ = get_stat_data(['usage_vs_alloc'], geo, session, table_name='ft_v6_alloc_vs_usage')

	return	{'view_ft_v4_v6_users':{
		"name": "Active IPv6 users in " + geo.name,
		"values": {"this": view_ft_v4_v6['Ipv6']['numerators']['this']}
	},
	'view_ft_v4_v6': view_ft_v4_v6,
	'view_ft_v6users': view_ft_v6users
	#'view_ft_v6_alloc_vs_usage': view_ft_v6_alloc_vs_usage
	}

from collections import OrderedDict

from wazimap.data.tables import get_datatable, get_model_from_fields
from wazimap.data.utils import get_stat_data, get_objects_by_geo, \
    calculate_median

import logging
import populationjson

logger = logging.getLogger(__name__)

def get_access_profile(geo, session):
	
	view_ft_users = None

	if geo.geo_level == 'country':
		view_ft_users, _ = get_stat_data(['type'], geo, session, table_name='view_ft_users_country_continent')
	elif geo.geo_level == 'continent':
		view_ft_users, _ = get_stat_data(['type'], geo, session, table_name='view_ft_users_continent_world')
	elif geo.geo_level == 'world':
		view_ft_users, _ = get_stat_data(['type'], geo, session, table_name='view_ft_users_world_continent')


	view_ft_users_population, _ = get_stat_data(['type'], geo, session, table_name='view_ft_users_population')

	return	{
	'view_ft_users_population_users':{
		"name": "Population data can be pulled from",
		"values": {"this": view_ft_users_population['Population']['numerators']['this']}
	},
	'view_ft_users': view_ft_users,
	'view_ft_users_population': view_ft_users_population,
	}

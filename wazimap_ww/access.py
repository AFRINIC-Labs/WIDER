from collections import OrderedDict

from wazimap.data.tables import get_datatable, get_model_from_fields
from wazimap.data.utils import get_stat_data, get_objects_by_geo, \
    calculate_median

import logging

logger = logging.getLogger(__name__)

def get_access_profile(geo, session):
	
	view_ft_users = OrderedDict()
	view_ft_users_population = OrderedDict()

	REGION_RECODES = OrderedDict()
	REGION_POPULATION = OrderedDict()

	try:
		if geo.geo_level == 'country':
			REGION_RECODES = OrderedDict([
			    ('country', geo.name),
			    ('continent', geo.parent.name)
			])
			view_ft_users, _ = get_stat_data(['type'], geo, session, table_name='ft_users_country_continent', recode=dict(REGION_RECODES), key_order=REGION_RECODES.values())
		elif geo.geo_level == 'continent':
			REGION_RECODES = OrderedDict([
			    ('continent', geo.name),
			    ('world', geo.parent.name)
			])
			view_ft_users, _ = get_stat_data(['type'], geo, session, table_name='ft_users_continent_world', recode=dict(REGION_RECODES), key_order=REGION_RECODES.values())
		elif geo.geo_level == 'world':
			view_ft_users, _ = get_stat_data(['type'], geo, session, table_name='ft_users_world_continent')
	except Exception as e:
		view_ft_users = None

	try:
		REGION_POPULATION = OrderedDict([
		    ('users', 'Users'),
		    ('population', 'Non-users')
		])
		view_ft_users_population, _ = get_stat_data(['type'], geo, session, table_name='ft_users_population', recode=dict(REGION_POPULATION), key_order=REGION_POPULATION.values())
	except Exception as e:
		view_ft_users_population = {'Non-users': {'numerators': {'this': 0}}}


	return	{
	'view_ft_users_population_users':{
		"name": "World bank data.",
		"values": {"this": view_ft_users_population['Non-users']['numerators']['this']}
	},
	'view_ft_users': view_ft_users,
	'view_ft_users_population': view_ft_users_population,
	}

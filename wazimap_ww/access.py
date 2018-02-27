from collections import OrderedDict

from wazimap.data.tables import get_datatable, get_model_from_fields
from wazimap.data.utils import get_stat_data, get_objects_by_geo, \
    calculate_median

import logging
import populationjson

logger = logging.getLogger(__name__)

def get_ipv4_profile(geo, session):

	countriesTable = get_datatable('countries')
	countrieUsers, total = get_stat_data('users_or_not', geo, session,table_fields=['users_or_not'])
	worldUsers, total = get_stat_data('country_or_world', geo, session,table_fields=['country_or_world'])
	marketShare, total = get_stat_data('asn', geo, session, '-total',table_fields=['asn'])

	users, _ = countriesTable.get_stat_data(geo, 'users')

	
	
	return	{
	'users':{
		"name": "Active internet users in " + geo.name,
        "values": {"this": users["users"]["numerators"]["this"]}
	},
	'users_in_country':countrieUsers,
	'users_in_world':worldUsers,
	'marketshare':marketShare}

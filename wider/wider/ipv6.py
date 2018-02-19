from collections import OrderedDict

from wazimap.data.tables import get_datatable, get_model_from_fields
from wazimap.data.utils import get_stat_data, get_objects_by_geo, \
    calculate_median

def get_ipv6_profile(geo, session):

	countriesTable = get_datatable('countries')

	users, _ = countriesTable.get_stat_data(geo, 'v6users')

	return	{'ipv6_users':{
		"name": "Active IPV6 Internet users in " + geo.name,
        "values": {"this": users["v6users"]["numerators"]["this"]}
	}}
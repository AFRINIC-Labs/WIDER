from collections import OrderedDict

from wazimap.data.tables import get_datatable, get_model_from_fields
from wazimap.data.utils import get_stat_data, get_objects_by_geo, \
    calculate_median

import populationjson

def get_v6marketshare_profile(geo, session):
	simple_v6pop = get_datatable('st_v6pop')
	total_v6, _ = simple_v6pop.get_stat_data(geo, 'total_v6')
	
	view_ft_marketshare_v6users, _ = get_stat_data('asname', geo, session, order_by='-total',table_fields='total',table_name='ft_marketshare_v6users')

	return	{
	'isp_count':{
		"name": "IPv6 users in " + geo.name,
        "values": {'this': total_v6['total_v6']['numerators']['this']}
	},
	'view_ft_marketshare_v6users':view_ft_marketshare_v6users}

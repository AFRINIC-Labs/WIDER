from collections import OrderedDict

from wazimap.data.tables import get_datatable, get_model_from_fields
from wazimap.data.utils import get_stat_data, get_objects_by_geo, \
    calculate_median

import populationjson

import logging
import populationjson

logger = logging.getLogger(__name__)

def get_marketshare_profile(geo, session):

	simple_v6pop = get_datatable('st_v6pop')

	# view_ft_marketshare_matching = marketshare_matching.get_stat_data(geo, 'asn', total=None, percent=None)


	total_isps, _ = simple_v6pop.get_stat_data(geo, 'total_isps')

	view_ft_marketshare_users, _ = get_stat_data('asname', geo, session, order_by='-total',table_fields='total',table_name='ft_marketshare_users')


	return	{
	'isp_count':{
		"name": "ISP's in " + geo.name,
        "values": {'this': total_isps['total_isps']['numerators']['this']}
	},
	'view_ft_marketshare_users':view_ft_marketshare_users}

from collections import OrderedDict

from wazimap.data.tables import get_datatable, get_model_from_fields
from wazimap.data.utils import get_stat_data, get_objects_by_geo, \
    calculate_median

import logging

logger = logging.getLogger(__name__)

def get_marketshare_profile(geo, session):

	view_ft_marketshare_users = OrderedDict()
	ispAmount = 0

	try:
		view_ft_marketshare_users, _ = get_stat_data('asname', geo, session, order_by='-total',table_fields='total',table_name='ft_marketshare_users', exclude_zero=True)
		ispAmount = len(view_ft_marketshare_users)
	except Exception as e:
		ispAmount = 0
		view_ft_marketshare_users = None



	return	{
	'isp_count':{
		"name": "ISP's in " + geo.name,
        "values": {'this': ispAmount}
	},
	'view_ft_marketshare_users':view_ft_marketshare_users}

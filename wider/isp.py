from collections import OrderedDict

from wazimap.data.tables import get_datatable, get_model_from_fields
from wazimap.data.utils import get_stat_data, get_objects_by_geo, \
    calculate_median

import logging
import populationjson

logger = logging.getLogger(__name__)

def get_isp_profile(geo, session):

	marketShare, total = get_stat_data('asn', geo, session, '-total',table_fields=['asn'])

	return	{
	'isp_count':{
		"name": "ISP's in " + geo.name,
        "values": {'this': len(marketShare)}
	},
	'marketshare':marketShare}

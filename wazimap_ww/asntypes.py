from collections import OrderedDict

from wazimap.data.tables import get_datatable, get_model_from_fields
from wazimap.data.utils import get_stat_data, get_objects_by_geo, \
    calculate_median

import populationjson

# logger = logging.getLogger(__name__)

def get_asntypes_profile(geo, session):
	
	view_ft_asn_type, _ = get_stat_data('type', geo, session,table_name='view_asn_type')

	return	{'view_ft_asn_type':view_ft_asn_type}
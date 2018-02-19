# -*- coding: utf-8 -*-

from collections import OrderedDict

from wazimap.data.tables import get_datatable, get_model_from_fields
from wazimap.data.utils import get_stat_data, get_objects_by_geo, \
    calculate_median
import logging
import populationjson

logger = logging.getLogger(__name__)

# Demographic recodes

def get_demographics_profile(geo, session):
	
	demographic_data = {
	    'has_data': True,
	    'total_population': {
	        "name": "People",
	        "values": {"this": populationjson.get_population_json(geo.name)}
	    }
	}

	return demographic_data

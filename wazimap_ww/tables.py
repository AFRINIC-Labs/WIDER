from wazimap.data.tables import FieldTable, SimpleTable

FieldTable(['users_or_not'],
		id='users_in_country',
		universe='Internet users',
		description='What percentage of a country are internet users',
		dataset='Stats from stats.labs.apnic.net',
		year='2017')


FieldTable(['country_or_world'],
        id='users_in_world',
        universe='Internet users',
        description='How much of the worlds internet users does this country make',
        dataset='Stats from stats.labs.apnic.net',
        year='2017')

# Define our tables so the data API can discover them.
#Ipv4
# FieldTable(['main type of cooking fuel'],
#            universe='Households',
#            description='Main type of cooking fuel',
#            dataset='National Population and Housing Census 2011',
#            year='2011',
#            table_per_level=False)

# Household tables

SimpleTable(
    id='countries',
    universe='Countries',
    total_column=None,
    description='Countries and their codes',
    dataset='',
    year='2017'
)


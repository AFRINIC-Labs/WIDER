from wazimap.data.tables import FieldTable, SimpleTable

# Ipv4

FieldTable(['users_or_not'],
		id='users_in_country',
		universe='Internet users',
        value_type='BIGINT',
		description='What percentage of a country are internet users',
		dataset='Stats from stats.labs.apnic.net',
		year='2017')



FieldTable(['country_or_world'],
        id='users_in_world',
        universe='Internet users',
        value_type='BIGINT',
        description='How much of the worlds internet users does this country make make up of',
        dataset='Stats from stats.labs.apnic.net',
        year='2017')




FieldTable(['asn'],
        id='market_share',
        universe='Internet users',
        value_type='BIGINT',
        description='The market share in a given country.',
        dataset='Stats from stats.labs.apnic.net',
        year='2017')

# Ipv6


FieldTable(['v6users_in_country'],
        id='v6user_or_not',
        universe='Internet users',
        value_type='BIGINT',
        description='What percentage of a country are internet IPv6 users',
        dataset='Stats from stats.labs.apnic.net',
        year='2017')

FieldTable(['v6coutry_or_world'],
        id='v6users_in_world',
        universe='Internet users',
        value_type='BIGINT',
        description='How much of the worlds Ipv6 internet users does this country make up of',
        dataset='Stats from stats.labs.apnic.net',
        year='2017')

FieldTable(['v6asn'],
        id='v6market_share',
        universe='Internet users',
        value_type='BIGINT',
        description='The IPv6 market share in a given country.',
        dataset='Stats from stats.labs.apnic.net',
        year='2017')

# Simple tables

SimpleTable(
    id='regions',
    universe='regions',
    total_column=None,
    description='Regions and their codes',
    dataset='',
    year='2018'
)

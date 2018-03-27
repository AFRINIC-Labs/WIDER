from wazimap.data.tables import FieldTable, SimpleTable

#access
    #level=country 
FieldTable(['type'],
        id='view_ft_users_country_continent',
        universe='Access',
        value_type='BIGINT',
        description='Internet users coutry vs Internet users in the world.',
        dataset='Stats from stats.labs.apnic.net',
        year='2018')

    #level=continent 
FieldTable(['type'],
        id='view_ft_users_continent_world',
        universe='Access',
        value_type='BIGINT',
        description='Internet users continent vs Internet users in the world.',
        dataset='Stats from stats.labs.apnic.net',
        year='2018')

    #level=world 
FieldTable(['type'],
        id='view_ft_users_world_continent',
        universe='Access',
        value_type='BIGINT',
        description='Internet users vs Internet users in the world.',
        dataset='Stats from stats.labs.apnic.net',
        year='2018')

FieldTable(['type'],
        id='view_ft_users_population',
        universe='Access',
        value_type='BIGINT',
        description='Number of users (source APNIC).',
        dataset='Stats from stats.labs.apnic.net',
        year='2018')

#v6

FieldTable(['type'],
        id='view_ft_v4_v6',
        universe='IPv6',
        value_type='BIGINT',
        description='The IPv6 market share in a given country.',
        dataset='Stats from stats.labs.apnic.net',
        year='2018')

    #level=country 
FieldTable(['type'],
        id='view_ft_v6users_country_continent',
        universe='IPv6',
        value_type='BIGINT',
        description='Active IPv6 users.',
        dataset='Stats from stats.labs.apnic.net',
        year='2018')

    #level=continent 
FieldTable(['type'],
        id='view_ft_v6users_continent_world',
        universe='IPv6',
        value_type='BIGINT',
        description='Active IPv6 users.',
        dataset='Stats from stats.labs.apnic.net',
        year='2018')

    #level=world 
FieldTable(['type'],
        id='view_ft_v6users_world_continent',
        universe='IPv6',
        value_type='BIGINT',
        description='Active IPv6 users.',
        dataset='Stats from stats.labs.apnic.net',
        year='2018')

#Removed until v1.1
# FieldTable(['usage_vs_alloc'],
#         id='view_ft_v6_alloc_vs_usage',
#         universe='usage',
#         value_type='BIGINT',
#         description='Active IPv6 users.',
#         dataset='Stats from stats.labs.apnic.net',
#         year='2018')

#market share
FieldTable(['asn'],
        id='view_ft_marketshare_users',
        universe='Marketshare',
        total_column='total',
        value_type='BIGINT',
        description='Active IPv6 users.',
        dataset='Stats from stats.labs.apnic.net',
        year='2018')



#v6 market share
FieldTable(['asname','asn'],
        id='view_ft_marketshare_v6users',
        universe='Marketshare',
        total_column='total',
        value_type='BIGINT',
        description='Active IPv6 users.',
        dataset='Stats from stats.labs.apnic.net',
        year='2018')

# SimpleTable(id='view_ft_marketshare_users',
#         universe='Marketshare',
#         total_column=None,
#         description='Active IPv6 users.',
#         dataset='Stats from stats.labs.apnic.net',
#         year='2018')

#ASN type
FieldTable(['type'],
        id='view_asn_type',
        universe='ASN types',
        value_type='BIGINT',
        description='Active IPv6 users.',
        dataset='Stats from stats.labs.apnic.net',
        year='2018')

#Demographics
SimpleTable(
    id='view_st_v6pop',
    universe='Internet users',
    total_column=None,
    description='v6pop data',
    dataset='',
    year='2018'
)

#market share
# SimpleTable(id='view_ft_marketshare_matching',
#         universe='Marketshare',
#         total_column=None,
#         description='Active IPv6 users.',
#         dataset='Stats from stats.labs.apnic.net',
#         year='2018')
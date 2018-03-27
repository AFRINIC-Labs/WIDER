truncate ft_asn_type;
COPY ft_asn_type FROM '/tmp/ft_asn_type.csv' CSV HEADER quote '"' DELIMITER ',';

truncate ft_marketshare_users;
COPY ft_marketshare_users FROM '/tmp/ft_marketshare_users.csv' CSV HEADER quote '"' DELIMITER ',';

truncate ft_marketshare_v6users;
COPY ft_marketshare_v6users FROM '/tmp/ft_marketshare_v6users.csv' CSV HEADER quote '"' DELIMITER ',';

truncate ft_users_continent_world;
COPY ft_users_continent_world FROM '/tmp/ft_users_continent_world.csv' CSV HEADER quote '"' DELIMITER ',';

truncate ft_users_country_continent;
COPY ft_users_country_continent FROM '/tmp/ft_users_country_continent.csv' CSV HEADER quote '"' DELIMITER ',';

truncate ft_users_country_world;
COPY ft_users_country_world FROM '/tmp/ft_users_country_world.csv' CSV HEADER quote '"' DELIMITER ',';

truncate ft_users_population;
COPY ft_users_population FROM '/tmp/ft_users_population.csv' CSV HEADER quote '"' DELIMITER ',';

truncate ft_users_world_continent;
COPY ft_users_world_continent FROM '/tmp/ft_users_world_continent.csv' CSV HEADER quote '"' DELIMITER ',';

truncate ft_v4_v6;
COPY ft_v4_v6 FROM '/tmp/ft_v4_v6.csv' CSV HEADER quote '"' DELIMITER ',';

truncate ft_v6_alloc_vs_usage;
COPY ft_v6_alloc_vs_usage FROM '/tmp/ft_v6_alloc_vs_usage.csv' CSV HEADER quote '"' DELIMITER ',';

truncate ft_v6users_continent_world;
COPY ft_v6users_continent_world FROM '/tmp/ft_v6users_continent_world.csv' CSV HEADER quote '"' DELIMITER ',';

truncate ft_v6users_country_continent;
COPY ft_v6users_country_continent FROM '/tmp/ft_v6users_country_continent.csv' CSV HEADER quote '"' DELIMITER ',';

truncate ft_v6users_country_world;
COPY ft_v6users_country_world FROM '/tmp/ft_v6users_country_world.csv' CSV HEADER quote '"' DELIMITER ',';

truncate ft_v6users_world_continent;
COPY ft_v6users_world_continent FROM '/tmp/ft_v6users_world_continent.csv' CSV HEADER quote '"' DELIMITER ',';

truncate ft_asn_rank_cc_users;
COPY ft_asn_rank_cc_users FROM '/tmp/ft_asn_rank_cc_users.csv' CSV HEADER quote '"' DELIMITER ',';

truncate ft_asn_rank_cc_v6users;
COPY ft_asn_rank_cc_v6users FROM '/tmp/ft_asn_rank_cc_v6users.csv' CSV HEADER quote '"' DELIMITER ',';

truncate ft_asn_rank_continent_users;
COPY ft_asn_rank_continent_users FROM '/tmp/ft_asn_rank_continent_users.csv' CSV HEADER quote '"' DELIMITER ',';

truncate ft_asn_rank_continent_v6users;
COPY ft_asn_rank_continent_v6users FROM '/tmp/ft_asn_rank_continent_v6users.csv' CSV HEADER quote '"' DELIMITER ',';

truncate ft_asn_rank_world_users;
COPY ft_asn_rank_world_users FROM '/tmp/ft_asn_rank_world_users.csv' CSV HEADER quote '"' DELIMITER ',';

truncate ft_asn_rank_world_v6users;
COPY ft_asn_rank_world_v6users FROM '/tmp/ft_asn_rank_world_v6users.csv' CSV HEADER quote '"' DELIMITER ',';

truncate st_v6pop;
COPY st_v6pop FROM '/tmp/st_v6pop.csv' CSV HEADER quote '"' DELIMITER ',';

truncate wazimap_geography;
COPY wazimap_geography FROM '/tmp/wazimap_geography.csv' CSV HEADER quote '"' DELIMITER ',';

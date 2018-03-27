COPY (select * from view_ft_asn_type) TO '/tmp/ft_asn_type.csv' CSV HEADER quote '"' DELIMITER ',';
COPY (select * from view_ft_marketshare_users) TO '/tmp/ft_marketshare_users.csv' CSV HEADER quote '"' DELIMITER ',';
COPY (select * from view_ft_marketshare_v6users) TO '/tmp/ft_marketshare_v6users.csv' CSV HEADER quote '"' DELIMITER ',';
COPY (select * from view_ft_users_continent_world) TO '/tmp/ft_users_continent_world.csv' CSV HEADER quote '"' DELIMITER ',';
COPY (select * from view_ft_users_country_continent) TO '/tmp/ft_users_country_continent.csv' CSV HEADER quote '"' DELIMITER ',';
COPY (select * from view_ft_users_country_world) TO '/tmp/ft_users_country_world.csv' CSV HEADER quote '"' DELIMITER ',';
COPY (select * from view_ft_users_population) TO '/tmp/ft_users_population.csv' CSV HEADER quote '"' DELIMITER ',';
COPY (select * from view_ft_users_world_continent) TO '/tmp/ft_users_world_continent.csv' CSV HEADER quote '"' DELIMITER ',';
COPY (select * from view_ft_v4_v6) TO '/tmp/ft_v4_v6.csv' CSV HEADER quote '"' DELIMITER ',';
COPY (select * from view_ft_v6_alloc_vs_usage) TO '/tmp/ft_v6_alloc_vs_usage.csv' CSV HEADER quote '"' DELIMITER ',';
COPY (select * from view_ft_v6users_continent_world) TO '/tmp/ft_v6users_continent_world.csv' CSV HEADER quote '"' DELIMITER ',';
COPY (select * from view_ft_v6users_country_continent) TO '/tmp/ft_v6users_country_continent.csv' CSV HEADER quote '"' DELIMITER ',';
COPY (select * from view_ft_v6users_country_world) TO '/tmp/ft_v6users_country_world.csv' CSV HEADER quote '"' DELIMITER ',';
COPY (select * from view_ft_v6users_world_continent) TO '/tmp/ft_v6users_world_continent.csv' CSV HEADER quote '"' DELIMITER ',';
COPY (select * from view_main_asn_rank_cc_users) TO '/tmp/ft_asn_rank_cc_users.csv' CSV HEADER quote '"' DELIMITER ',';
COPY (select * from view_main_asn_rank_cc_v6users) TO '/tmp/ft_asn_rank_cc_v6users.csv' CSV HEADER quote '"' DELIMITER ',';
COPY (select * from view_main_asn_rank_continent_users) TO '/tmp/ft_asn_rank_continent_users.csv' CSV HEADER quote '"' DELIMITER ',';
COPY (select * from view_main_asn_rank_continent_v6users) TO '/tmp/ft_asn_rank_continent_v6users.csv' CSV HEADER quote '"' DELIMITER ',';
COPY (select * from view_main_asn_rank_world_users) TO '/tmp/ft_asn_rank_world_users.csv' CSV HEADER quote '"' DELIMITER ',';
COPY (select * from view_main_asn_rank_world_v6users) TO '/tmp/ft_asn_rank_world_v6users.csv' CSV HEADER quote '"' DELIMITER ',';
COPY (select * from view_st_v6pop) TO '/tmp/st_v6pop.csv' CSV HEADER quote '"' DELIMITER ',';
#####with views

drop view view_ft_v6_alloc_vs_usage;
drop view view_v6_allocation_usage_ww;
drop view view_v6_allocation_usage_cc;
drop view view_asn_type;
drop view view_ft_marketshare_v6users;
drop view view_main_asn_rank_top10_world_v6users;
drop view view_main_asn_rank_top10_continent_v6users;
drop view view_main_asn_rank_top10_cc_v6users;
drop view view_ft_marketshare_users;
drop view view_main_asn_rank_top10_world_users;
drop view view_main_asn_rank_top10_continent_users;
drop view view_main_asn_rank_top10_cc_users;

drop view view_main_asn_rank_cc;
drop view view_ft_users_world;
drop view view_ft_users_population;
drop view view_ft_v4_v6;
drop view view_st_v6pop;
drop view view_v6pop_world;
drop view view_v6pop_continent;
DROP VIEW view_v6pop_country;

CREATE or replace view view_v6pop_country AS
SELECT
wg.geo_level::VARCHAR,
wg.geo_code::VARCHAR,
TO_CHAR(NOW(), 'YYYY-MM')::VARCHAR AS geo_version,
SUM(m.users)::BIGINT AS total_users,
COUNT(m.asn)::BIGINT AS total_isps,
(SELECT p.value FROM population p, country c WHERE p.country_code = c."alpha-3" AND c."alpha-2"=wg.geo_code AND p.year=2016)::BIGINT AS population,
SUM(m.v6users)::BIGINT AS total_v6,
SUM(m.samples)::BIGINT AS total_samples,
wg.parent_code::VARCHAR,
wg.parent_level::VARCHAR
FROM wazimap_geography wg, main m
WHERE wg.geo_code = m.country_code
GROUP BY wg.geo_level, wg.geo_code, wg.parent_code, wg.parent_level

CREATE or replace view view_v6pop_continent AS
SELECT
v.parent_level::VARCHAR AS geo_level,
v.parent_code::VARCHAR AS geo_code,
TO_CHAR(NOW(), 'YYYY-MM')::VARCHAR AS geo_version,
SUM(v.total_users)::BIGINT AS total_users,
SUM(v.total_isps)::BIGINT AS total_isps,
SUM(v.population)::BIGINT AS population,
SUM(v.total_v6)::BIGINT AS total_v6,
SUM(v.total_samples)::BIGINT AS total_samples,
'WW'::VARCHAR AS parent_code,
'world'::VARCHAR AS parent_level
FROM view_v6pop_country v
GROUP BY v.parent_level, v.parent_code

CREATE or replace view view_v6pop_world AS
SELECT
'world'::VARCHAR AS geo_level,
'WW'::VARCHAR AS geo_code,
TO_CHAR(NOW(), 'YYYY-MM')::VARCHAR AS geo_version,
SUM(v.total_users)::BIGINT AS total_users,
SUM(v.total_isps)::BIGINT AS total_isps,
SUM(v.population)::BIGINT AS population,
SUM(v.total_v6)::BIGINT AS total_v6,
SUM(v.total_samples)::BIGINT AS total_samples,
NULL::VARCHAR AS parent_code,
NULL::VARCHAR AS parent_level
FROM view_v6pop_continent v
GROUP BY v.parent_level, v.parent_code

CREATE view view_st_v6pop AS
SELECT * FROM view_v6pop_world
UNION
SELECT * FROM view_v6pop_continent
UNION
SELECT * FROM view_v6pop_country


#####field v4 vs v6
CREATE view view_ft_v4_v6 AS
SELECT
v.geo_level AS geo_level,
v.geo_code AS geo_code,
TO_CHAR(NOW(), 'YYYY-MM')::VARCHAR AS geo_version,
'ipv4' AS type,
v.total_users AS total
FROM view_st_v6pop v
UNION
SELECT
v.geo_level AS geo_level,
v.geo_code AS geo_code,
TO_CHAR(NOW(), 'YYYY-MM')::VARCHAR AS geo_version,
'ipv6' AS type,
v.total_v6 AS total
FROM view_st_v6pop v

####field users vs population
CREATE view view_ft_users_population AS
SELECT
v.geo_level AS geo_level,
v.geo_code AS geo_code,
TO_CHAR(NOW(), 'YYYY-MM')::VARCHAR AS geo_version,
'users' AS type,
v.total_users AS total
FROM view_st_v6pop v
UNION
SELECT
v.geo_level AS geo_level,
v.geo_code AS geo_code,
TO_CHAR(NOW(), 'YYYY-MM')::VARCHAR AS geo_version,
'population' AS type,
v.population AS total
FROM view_st_v6pop v



####field user vs users in the world
CREATE view view_ft_users_world AS
SELECT
vc.geo_level AS geo_level,
vc.geo_code AS geo_code,
TO_CHAR(NOW(), 'YYYY-MM')::VARCHAR AS geo_version,
'country' AS type,
vc.total_users AS total
FROM view_v6pop_country vc
UNION
SELECT
vc.geo_level AS geo_level,
vc.geo_code AS geo_code,
TO_CHAR(NOW(), 'YYYY-MM')::VARCHAR AS geo_version,
'world' AS type,
(SELECT total_users FROM view_v6pop_world) AS total
FROM view_v6pop_country vc
UNION
SELECT
v.geo_level AS geo_level,
v.geo_code AS geo_code,
TO_CHAR(NOW(), 'YYYY-MM')::VARCHAR AS geo_version,
'continent' AS type,
v.total_users AS total
FROM view_v6pop_continent v
UNION
SELECT
v.geo_level AS geo_level,
v.geo_code AS geo_code,
TO_CHAR(NOW(), 'YYYY-MM')::VARCHAR AS geo_version,
'world' AS type,
(SELECT total_users FROM view_v6pop_world) AS total
FROM view_v6pop_continent v


##### view main with AS ranked by users and v6 users
CREATE view view_main_asn_rank_cc AS
WITH ranked_main AS (
    SELECT *, 
    RANK() OVER(PARTITION by m.country_code ORDER BY m.users DESC) AS rnk_users,
    RANK() OVER(PARTITION by m.country_code ORDER BY m.v6users DESC) AS rnk_v6
    FROM main m
)
SELECT 
wg.geo_level AS geo_level,
rm.country_code AS geo_code,
TO_CHAR(NOW(), 'YYYY-MM')::VARCHAR AS geo_version,
rm.asn, 
CASE rm.asname WHEN NULL THEN rm.asn ELSE rm.asname END AS asname,  
rm.users, 
rm.rnk_users, 
rm.v6users::INT, 
rm.rnk_v6 
FROM ranked_main rm, wazimap_geography wg
WHERE wg.geo_code = rm.country_code
ORDER BY country_code, rnk_users



####### view asn ranked top 10 users by continent
CREATE view view_main_asn_rank_top10_continent_users AS
WITH ranked_asn AS (
    SELECT 
    *,
    RANK() OVER(PARTITION by wg.parent_code ORDER BY m.users DESC) AS rnk_users
    FROM main m, wazimap_geography wg
    WHERE m.country_code = wg.geo_code
)
SELECT
rm.parent_level AS geo_level,
rm.parent_code AS geo_code,
TO_CHAR(NOW(), 'YYYY-MM')::VARCHAR AS geo_version,
CASE rm.asname WHEN NULL THEN rm.asn ELSE rm.asname END AS asname,
rm.asn,  
rm.users AS total
FROM ranked_asn rm
WHERE rm.rnk_users BETWEEN 1 AND 10
UNION
SELECT 
rm.parent_level AS geo_level,
rm.parent_code AS geo_code,
TO_CHAR(NOW(), 'YYYY-MM')::VARCHAR AS geo_version,
'OTHERS' AS asname,
'OTHERS' AS asn,
SUM(rm.users) AS total
FROM ranked_asn rm
WHERE rm.rnk_users > 10
GROUP BY rm.parent_level, rm.parent_code 

####### view asn ranked top 10 v6 users by continent
CREATE view view_main_asn_rank_top10_continent_v6users AS
WITH ranked_asn AS (
    SELECT 
    *,
    RANK() OVER(PARTITION by wg.parent_code ORDER BY m.v6users DESC) AS rnk_v6users
    FROM main m, wazimap_geography wg
    WHERE m.country_code = wg.geo_code
)
SELECT
rm.parent_level AS geo_level,
rm.parent_code AS geo_code,
TO_CHAR(NOW(), 'YYYY-MM')::VARCHAR AS geo_version,
CASE rm.asname WHEN NULL THEN rm.asn ELSE rm.asname END AS asname,
rm.asn,   
rm.v6users AS total
FROM ranked_asn rm
WHERE rm.rnk_v6users BETWEEN 1 AND 10
UNION
SELECT 
rm.parent_level AS geo_level,
rm.parent_code AS geo_code,
TO_CHAR(NOW(), 'YYYY-MM')::VARCHAR AS geo_version,
'OTHERS' AS asname,
'OTHERS' AS asn,
SUM(rm.v6users) AS total
FROM ranked_asn rm
WHERE rm.rnk_v6users > 10
GROUP BY rm.parent_level, rm.parent_code 

##### view asn ranked top 10 users by country
CREATE view view_main_asn_rank_top10_cc_users AS
WITH ranked_main AS (
    SELECT *, 
    RANK() OVER(PARTITION by m.country_code ORDER BY m.users DESC) AS rnk_users
    FROM main m
)
SELECT 
wg.geo_level AS geo_level,
rm.country_code AS geo_code,
TO_CHAR(NOW(), 'YYYY-MM')::VARCHAR AS geo_version,
CASE rm.asname WHEN NULL THEN rm.asn ELSE rm.asname END AS asname,
rm.asn,  
rm.v6users AS total
FROM ranked_main rm, wazimap_geography wg
WHERE wg.geo_code = rm.country_code
AND rm.rnk_users BETWEEN 1 AND 10
UNION
SELECT 
wg.geo_level AS geo_level,
rm.country_code AS geo_code,
TO_CHAR(NOW(), 'YYYY-MM')::VARCHAR AS geo_version,
'OTHERS' AS asname, 
'OTHERS' AS asn, 
SUM(rm.v6users) AS total
FROM ranked_main rm, wazimap_geography wg
WHERE wg.geo_code = rm.country_code
AND rm.rnk_users > 10
GROUP BY wg.geo_level, rm.country_code

##### view asn ranked top 10 v6 ysers by country
CREATE view view_main_asn_rank_top10_cc_v6users AS
WITH ranked_main AS (
    SELECT *, 
    RANK() OVER(PARTITION by m.country_code ORDER BY m.v6users DESC) AS rnk_v6users
    FROM main m
)
SELECT 
wg.geo_level AS geo_level,
rm.country_code AS geo_code,
TO_CHAR(NOW(), 'YYYY-MM')::VARCHAR AS geo_version,
CASE rm.asname WHEN NULL THEN rm.asn ELSE rm.asname END AS asname,
rm.asn,  
rm.v6users AS total
FROM ranked_main rm, wazimap_geography wg
WHERE wg.geo_code = rm.country_code
AND rm.rnk_v6users BETWEEN 1 AND 10
UNION
SELECT 
wg.geo_level AS geo_level,
rm.country_code AS geo_code,
TO_CHAR(NOW(), 'YYYY-MM')::VARCHAR AS geo_version,
'OTHERS' AS asname,
'OTHERS' AS asn,  
SUM(rm.v6users) AS total
FROM ranked_main rm, wazimap_geography wg
WHERE wg.geo_code = rm.country_code
AND rm.rnk_v6users > 10
GROUP BY wg.geo_level, rm.country_code

#### top 10 world users
CREATE view view_main_asn_rank_top10_world_users AS
SELECT
'world' AS geo_level,
'WW' AS geo_code,
TO_CHAR(NOW(), 'YYYY-MM')::VARCHAR AS geo_version,
CASE m.asname WHEN NULL THEN m.asn ELSE m.asname END AS asname,
m.asn AS asn, 
m.users AS total
FROM main m, wazimap_geography wg
WHERE m.country_code = wg.geo_code
AND m.asnrank BETWEEN 1 AND 10
UNION
SELECT
'world' AS geo_level,
'WW' AS geo_code,
TO_CHAR(NOW(), 'YYYY-MM')::VARCHAR AS geo_version,
'OTHERS' AS asname,
'OTHERS' AS asn,  
SUM(m.users) AS total
FROM main m, wazimap_geography wg
WHERE m.country_code = wg.geo_code
AND m.asnrank > 10

#### top 10 world v6 users

CREATE view view_main_asn_rank_top10_world_v6users AS
SELECT
'world' AS geo_level,
'WW' AS geo_code,
TO_CHAR(NOW(), 'YYYY-MM')::VARCHAR AS geo_version,
CASE m.asname WHEN NULL THEN m.asn ELSE m.asname END AS asname,
m.asn,  
m.v6users AS total
FROM main m, wazimap_geography wg
WHERE m.country_code = wg.geo_code
AND m.asnrank BETWEEN 1 AND 10
UNION
SELECT
'world' AS geo_level,
'WW' AS geo_code,
TO_CHAR(NOW(), 'YYYY-MM')::VARCHAR AS geo_version,
'OTHERS' AS asname,
'OTHERS' AS asn,  
SUM(m.v6users) AS total
FROM main m, wazimap_geography wg
WHERE m.country_code = wg.geo_code
AND m.asnrank > 10

#### view market share users
CREATE view view_ft_marketshare_users AS
SELECT * FROM view_main_asn_rank_top10_cc_users
UNION
SELECT * FROM view_main_asn_rank_top10_continent_users
UNION
SELECT * FROM view_main_asn_rank_top10_world_users

#### view market share v6 users
CREATE view view_ft_marketshare_v6users AS
SELECT * FROM view_main_asn_rank_top10_cc_v6users
UNION
SELECT * FROM view_main_asn_rank_top10_continent_v6users
UNION
SELECT * FROM view_main_asn_rank_top10_world_v6users


##### ASN type

CREATE view view_ft_asn_type AS
SELECT 
wg.geo_level,
wg.geo_code,
TO_CHAR(NOW(), 'YYYY-MM')::VARCHAR AS geo_version,
COALESCE(c.type, 'Unknown') AS type,
COUNT(c.type) AS total
FROM wazimap_geography wg INNER JOIN main m ON wg.geo_code = m.country_code
LEFT JOIN as_classification c ON TRIM('AS' FROM m.asn)::INT = c.asn 
GROUP BY wg.geo_level, wg.geo_code, c.type
UNION
SELECT 
wg.parent_level AS geo_level,
wg.parent_code AS geo_code,
TO_CHAR(NOW(), 'YYYY-MM')::VARCHAR AS geo_version,
COALESCE(c.type, 'Unknown') AS type,
COUNT(c.type) AS total
FROM wazimap_geography wg INNER JOIN main m ON wg.geo_code = m.country_code
LEFT JOIN as_classification c ON TRIM('AS' FROM m.asn)::INT = c.asn 
GROUP BY wg.parent_level, wg.parent_code, c.type
UNION
SELECT 
'world' AS geo_level,
'WW' AS geo_code,
TO_CHAR(NOW(), 'YYYY-MM')::VARCHAR AS geo_version,
COALESCE(c.type, 'Unknown') AS type,
COUNT(c.type) AS total
FROM wazimap_geography wg INNER JOIN main m ON wg.geo_code = m.country_code
LEFT JOIN as_classification c ON TRIM('AS' FROM m.asn)::INT = c.asn 
GROUP BY c.type


#### view v6 allocation vs usage by cc
CREATE view view_v6_allocation_usage_cc AS
SELECT
wg.geo_level,
wg.geo_code,
TO_CHAR(NOW(), 'YYYY-MM')::VARCHAR AS geo_version,
'allocation' AS usage_vs_alloc,
SUM(POWER(2,48 - n.prefix_len))::BIGINT total
FROM wazimap_geography wg, nro_allocation n
WHERE wg.geo_code = n.cc
AND n.type='ipv6'
AND n.rir <> 'iana'
AND n.status = 'assigned'
GROUP BY wg.geo_code, wg.geo_level
UNION
SELECT
wg.geo_level,
wg.geo_code,
TO_CHAR(NOW(), 'YYYY-MM')::VARCHAR AS geo_version,
'usage' AS usage_vs_alloc,
SUM(m.v6users)::BIGINT AS total
FROM wazimap_geography wg, main m
WHERE wg.geo_code = m.country_code
GROUP BY wg.geo_code, wg.geo_level


#### view v6 alloc vs usage by ww
CREATE view view_v6_allocation_usage_ww AS
SELECT
wg.parent_level AS geo_level,
wg.parent_code AS geo_code,
TO_CHAR(NOW(), 'YYYY-MM')::VARCHAR AS geo_version,
'allocation' AS usage_vs_alloc,
SUM(v.total)::BIGINT AS total
FROM wazimap_geography wg, view_v6_allocation_usage_cc v
WHERE wg.geo_code = v.geo_code
GROUP BY wg.parent_code, wg.parent_level
UNION
SELECT
v.parent_level AS geo_level,
v.parent_code AS geo_code,
TO_CHAR(NOW(), 'YYYY-MM')::VARCHAR AS geo_version,
'usage' AS usage_vs_alloc,
SUM(v.total_v6)::BIGINT AS total
FROM view_st_v6pop v
WHERE v.parent_level IS NOT NULL
GROUP BY v.parent_level, v.parent_code

#### FT alloc vs usage v6

CREATE view view_ft_v6_alloc_vs_usage AS
SELECT * FROM view_v6_allocation_usage_cc
UNION
SELECT * FROM view_v6_allocation_usage_ww


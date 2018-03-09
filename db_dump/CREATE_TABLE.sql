CREATE TABLE public.main
(
  asnrank integer,
  asn character(50),
  asname character(200),
  country_code character(2),
  users integer,
  gdpxusers real,
  percentageofcountry real,
  percentageofinternet real,
  v6users real,
  percentageofas real,
  percentageofcountryv6total real,
  percentageofinternetv6total real,
  samples integer
)
WITH (
  OIDS=FALSE
);
ALTER TABLE public.main
  OWNER TO wider;

CREATE TABLE public.regions
(
  name text,
  geo_code character(2),
  date date,
  geo_level text,
  parent_level text,
  users bigint,
  gdpxusers real,
  percentageofcountry real,
  percentageofinternet real,
  v6users bigint,
  percentageofas real,
  percentageofcountryv6total real,
  percentageofinternetv6total real,
  samples bigint,
  geo_version text
)
WITH (
  OIDS=FALSE
);
ALTER TABLE public.regions
  OWNER TO wider;

COPY wazimap_geography (geo_level, geo_code, name, parent_level, parent_code, long_name, version) FROM '/home/louw/dev/projects/afrinic/firstdjango/wazimap_ww/db_dump/data/wazimap-geography.csv' CSV HEADER DELIMITER ',';




/*

CREATE OR REPLACE FUNCTION public.populate_market_share()
  RETURNS void AS
$BODY$DECLARE
rec record;
BEGIN

FOR rec IN
SELECT * 
FROM "main"
LOOP
  INSERT INTO market_share VALUES(
    'country',
    rec.country_code,
    '',
    rec.asn,
    rec.users
  );
END LOOP;


END$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION public.populate_market_share()
  OWNER TO wider;

  CREATE OR REPLACE FUNCTION public.suppress(droptable boolean DEFAULT false)
  RETURNS void AS
$BODY$DECLARE
rec record;

BEGIN

IF dropTable THEN
DROP TABLE IF EXISTS public.countries;
END IF;

CREATE TABLE IF NOT EXISTS public.countries
(
    name text COLLATE pg_catalog."default",
    geo_code character(2) COLLATE pg_catalog."default",
    date date,
    geo_level text COLLATE pg_catalog."default",
    parent_level text COLLATE pg_catalog."default",
    users bigint,
    gdpxusers real,
    percentageofcountry real,
    percentageofinternet real,
    v6users bigint,
    percentageofas real,
    percentageofcountryv6total real,
    percentageofinternetv6total real,
    samples bigint,
    geo_version text
)

WITH (
    OIDS = FALSE
)

TABLESPACE pg_default;

ALTER TABLE public.countries
    OWNER to wazimap;

  FOR rec IN
      SELECT * 
        FROM "countriescc"
     LOOP
    PERFORM public."suppressByCC"(rec.cname,rec.code);
     END LOOP;

END

$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION public.suppress(boolean)
  OWNER TO wider;

CREATE OR REPLACE FUNCTION public."suppressByCC"(
    cname text,
    cc text)
  RETURNS boolean AS
$BODY$DECLARE 
    geo_level  text :='country';
    parent_level  text :='world';

BEGIN 

 INSERT INTO countries VALUES(
  cname, 
  CC, 
  current_date, 
  geo_level, 
  parent_level, 
  (SELECT SUM(cr.users) FROM main AS cr WHERE cr.country_code = CC), 
  (SELECT SUM(cr.gdpxusers) FROM main AS cr WHERE cr.country_code = CC), 
  (SELECT SUM(cr.percentageofcountry) FROM main AS cr WHERE cr.country_code = CC), 
  (SELECT SUM(cr.percentageofinternet) FROM main AS cr WHERE cr.country_code = CC), 
  (SELECT SUM(cr.v6users) FROM main AS cr WHERE cr.country_code = CC), 
  (SELECT SUM(cr.percentageofas) FROM main AS cr WHERE cr.country_code = CC), 
  (SELECT SUM(cr.percentageofcountryv6total) FROM main AS cr WHERE cr.country_code = CC),
  (SELECT SUM(cr.percentageofinternetv6total) FROM main AS cr WHERE cr.country_code = CC), 
  (SELECT SUM(cr.samples) FROM main AS cr WHERE cr.country_code = CC),
  current_date);
  RETURN FALSE;
END
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION public."suppressByCC"(text, text)
  OWNER TO wider;

  CREATE OR REPLACE FUNCTION public.update_geo()
  RETURNS void AS
$BODY$
BEGIN
UPDATE wazimap_geography SET version = current_date WHERE version = '0.1';
END
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION public.update_geo()
  OWNER TO wider;


CREATE OR REPLACE FUNCTION public.users_in_country_generator()
  RETURNS void AS
$BODY$DECLARE
rec record;
users  text :='users';
non_users  text :='non_users';
BEGIN
CREATE TABLE IF NOT EXISTS public.users_in_country
(
  geo_level text COLLATE pg_catalog."default",
  geo_code character(2) COLLATE pg_catalog."default",
  geo_version text,
  users_or_not text,
  total integer
)

WITH (
  OIDS=FALSE
)

TABLESPACE pg_default;

ALTER TABLE public.users_in_country
  OWNER TO wider;

    
FOR rec IN SELECT *  FROM "countries"
LOOP
  INSERT INTO users_in_country VALUES(
    rec.geo_level,
    rec.geo_code,
    rec.geo_version,
    users,
    rec.users
  );
  INSERT INTO users_in_country VALUES(
    rec.geo_level,
    rec.geo_code,
    rec.geo_version,
    non_users,
    1000000
  );
END LOOP;

END$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION public.users_in_country_generator()
  OWNER TO wider;


  CREATE OR REPLACE FUNCTION public.users_in_world_generator()
  RETURNS void AS
$BODY$DECLARE
rec record;
usersInct  text :='users';
usersInwrld  text :='world_users';
usersInwrldcnt bigint := (SELECT users FROM countries where name = 'Earth');
usersInwrldcntdiv bigint;
BEGIN
CREATE TABLE IF NOT EXISTS public.users_in_world
(
  geo_level text COLLATE pg_catalog."default",
  geo_code character(2) COLLATE pg_catalog."default",
  geo_version text,
  country_or_world text,
  total bigint
)

WITH (
  OIDS=FALSE
)

TABLESPACE pg_default;

ALTER TABLE public.users_in_world
  OWNER TO wider;

    
FOR rec IN SELECT *  FROM "countries"
LOOP
  usersInwrldcntdiv := usersInwrldcnt - rec.users;
  INSERT INTO users_in_world VALUES(
    rec.geo_level,
    rec.geo_code,
    rec.geo_version,
    usersInct,
    rec.users
  );
  INSERT INTO users_in_world VALUES(
    rec.geo_level,
    rec.geo_code,
    rec.geo_version,
    usersInwrld,
    usersInwrldcntdiv
  );
END LOOP;

END$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION public.users_in_world_generator()
  OWNER TO wider;
*/
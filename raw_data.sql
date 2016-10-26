-- Table definitions for the Lake Pend Oreille data project.
DROP DATABASE IF EXISTS lake_data;
CREATE DATABASE lake_data;
\c lake_data;

--
-- RAW_DATA
--
CREATE TABLE raw_data (
    original_timestamp VARCHAR(40),
    timestamp timestamp,
    air_temperature NUMERIC,
    barometric_pressure NUMERIC,
    dew_point NUMERIC,
    relative_humidity NUMERIC,
    wind_direction NUMERIC,
    wind_gust NUMERIC,
    wind_speed NUMERIC
);

--
-- IMPORT RAW DATA FROM A FILE
--
COPY raw_data(original_timestamp,
              air_temperature,
              barometric_pressure,
              dew_point,
              relative_humidity,
              wind_direction,
              wind_gust,
              wind_speed)
FROM '/vagrant/data/complete_data.txt';

UPDATE raw_data SET timestamp=to_timestamp(original_timestamp, 'YYYY_MM_DD HH24:MI:SS');

--
-- USER WITH READ-ONLY ACCESS TO THE TABLE CONTAINING THE DATA.
--
DROP USER IF EXISTS lpo;
CREATE USER lpo WITH PASSWORD 'mysecurepassword';
GRANT CONNECT ON DATABASE lake_data TO lpo;
GRANT SELECT ON raw_data TO lpo;


--
-- FUNCTION TO CALCULATE MEDIAN
-- https://wiki.postgresql.org/wiki/Aggregate_Median
--
CREATE OR REPLACE FUNCTION _final_median(NUMERIC[])
   RETURNS NUMERIC AS
$$
   SELECT AVG(val)
   FROM (
     SELECT val
     FROM unnest($1) val
     ORDER BY 1
     LIMIT  2 - MOD(array_upper($1, 1), 2)
     OFFSET CEIL(array_upper($1, 1) / 2.0) - 1
   ) sub;
$$
LANGUAGE 'sql' IMMUTABLE;

CREATE AGGREGATE median(NUMERIC) (
  SFUNC=array_append,
  STYPE=NUMERIC[],
  FINALFUNC=_final_median,
  INITCOND='{}'
);

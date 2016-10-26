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
    air_temperature REAL,
    barometric_pressure REAL,
    dew_point REAL,
    relative_humidity REAL,
    wind_direction REAL,
    wind_gust REAL,
    wind_speed REAL
);

--
-- Import raw data from files
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

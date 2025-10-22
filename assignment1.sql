/*Note: Change <usern> to your username (user1, user2, etc)*/

--Create folder structure in user folder--
CREATE FOLDER IF NOT EXISTS workshop.<usern>.raw;
CREATE FOLDER IF NOT EXISTS workshop.<usern>.preparation;
CREATE FOLDER IF NOT EXISTS workshop.<usern>.business;
CREATE FOLDER IF NOT EXISTS workshop.<usern>.application;

--Ingesting data into Enterprise Catalog--
CREATE TABLE workshop.<usern>.raw.nyc_trips_raw AS SELECT * FROM nessie.raw.nyc_trips_raw;

CREATE TABLE workshop.<usern>.raw.nyc_weather_raw AS SELECT * FROM nessie.raw.nyc_weather_raw;

--Create View--
CREATE OR REPLACE VIEW workshop.<usern>.preparation.nyc_taxi_trips AS SELECT 
    TO_TIME(pickup_time, 'HH24:MI:SS', 1) AS pickup_time,
    TO_DATE(pickup_date, 'YYYY-MM-DD', 1) AS pickup_date,
    passenger_count,
    trip_distance,
    fare_amount,
    tip_amount,
    total_amount
FROM   (SELECT 
            CASE WHEN LENGTH(SUBSTR(nyc_trips."pickup_datetime", 12, LENGTH(nyc_trips."pickup_datetime") - 15)) > 0 THEN SUBSTR(nyc_trips."pickup_datetime", 12, LENGTH(nyc_trips."pickup_datetime") - 15) ELSE NULL END AS pickup_time,
            CASE WHEN LENGTH(SUBSTR(nyc_trips."pickup_datetime", 1, 10)) > 0 THEN SUBSTR(nyc_trips."pickup_datetime", 1, 10) ELSE NULL END AS pickup_date,
            passenger_count,
            trip_distance_mi AS trip_distance,
            fare_amount,
            tip_amount,
            total_amount
        FROM  workshop.<usern>.raw.nyc_trips_raw AS nyc_trips
) nested_0;

CREATE OR REPLACE VIEW workshop.<usern>.preparation.nyc_weather AS SELECT 
        station,
        location_name,
        TO_DATE(calendar_date, 'YYYY-MM-DD', 1) AS calendar_date,
        average_wind,
        precipitation,
        snow,
        snow_depth,
        temp_max,
        temp_min
FROM   (SELECT 
                station,
                name AS location_name,
                CASE WHEN LENGTH(SUBSTR(nyc_weather."date", 1, 10)) > 0 THEN SUBSTR(nyc_weather."date", 1, 10) ELSE NULL END AS calendar_date,
                CASE WHEN nyc_weather."awnd" != '' THEN CAST(nyc_weather."awnd" AS FLOAT) ELSE NULL END AS average_wind,
                CAST(nyc_weather."prcp" AS FLOAT) AS precipitation,
                CAST(nyc_weather."snow" AS FLOAT) AS snow,
                CAST(nyc_weather."snwd" AS FLOAT) AS snow_depth,
                CAST(nyc_weather."tempmax" AS FLOAT) AS temp_max,
                CAST(nyc_weather."tempmin" AS FLOAT) AS temp_min
        FROM   workshop.<usern>.raw.nyc_weather_raw AS nyc_weather
) nested_0;

CREATE OR REPLACE VIEW workshop.<usern>.business.trips_weather AS SELECT 
    location_name,
    pickup_date,
    pickup_time,
    passenger_count,
    trip_distance,
    fare_amount,
    tip_amount,
    total_amount,
    average_wind,
    precipitation,
    snow,
    snow_depth,
    temp_max,
    temp_min
FROM 
    workshop.<usern>.preparation.nyc_taxi_trips as t INNER JOIN workshop.<usern>.preparation.nyc_weather as w ON t.pickup_date = w.calendar_date;

--Manage user access and role--
CREATE USER analyst1a;
ALTER USER analyst1a SET PASSWORD 'login123';

CREATE ROLE analyst1;
GRANT ROLE analyst1 TO USER analyst1a;

GRANT USAGE ON FOLDER workshop.<usern> TO ROLE analyst1;
GRANT USAGE,SELECT ON FOLDER workshop.<usern>.preparation TO ROLE analyst1;
GRANT USAGE,SELECT,ALTER ON FOLDER workshop.<usern>.business TO ROLE analyst1;
GRANT USAGE,SELECT,ALTER ON FOLDER workshop.<usern>.application TO ROLE analyst1;

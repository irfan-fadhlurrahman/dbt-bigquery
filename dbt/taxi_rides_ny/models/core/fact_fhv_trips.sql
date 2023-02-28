{{ config(materialized='table') }}

WITH fhv_tripdata AS (
    SELECT
        *
    FROM
        {{ ref('stg_fhv_tripdata') }}
),
dim_zones AS (
    SELECT
        *
    FROM 
        {{ ref('dim_zones') }}
    WHERE
        borough != 'Unknown'
)
SELECT
    tripdata.trip_id
    ,tripdata.dispatching_base_number
    ,tripdata.pickup_datetime
    ,tripdata.dropoff_datetime
    ,tripdata.pickup_location_id
    ,pickup_zones.borough AS pickup_borough
    ,pickup_zones.zone AS pickup_zone
    ,tripdata.dropoff_location_id
    ,dropoff_zones.borough AS dropoff_borough
    ,dropoff_zones.zone AS dropoff_zone
    ,tripdata.shared_ride_flag
    ,tripdata.affiliated_base_number
FROM
    fhv_tripdata AS tripdata
INNER JOIN
    dim_zones AS pickup_zones
    ON tripdata.pickup_location_id = pickup_zones.location_id
INNER JOIN
    dim_zones AS dropoff_zones
    ON tripdata.pickup_location_id = dropoff_zones.location_id
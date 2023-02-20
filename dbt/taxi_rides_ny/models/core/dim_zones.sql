{{ config(materialized='table') }}

SELECT 
    locationid AS location_id
    ,borough 
    ,zone 
FROM 
    {{ ref('taxi_zone_lookup') }}
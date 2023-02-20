{{ config(materialized='view') }}

WITH tripdata AS (
    -- To filter unique values of surrogate key (vendorid and tpep_pickup_datetime)
    SELECT 
        *
        ,ROW_NUMBER() OVER(PARTITION BY vendorid, tpep_pickup_datetime) AS rn
    FROM
        {{ source('staging', 'external_yellow_tripdata') }}
    WHERE
        vendorid IS NOT NULL
        AND tpep_pickup_datetime BETWEEN '2019-01-01' AND '2020-12-31'
)
SELECT
    -- Identifiers
    {{ dbt_utils.surrogate_key(['vendorid', 'tpep_pickup_datetime']) }} AS trip_id
    ,vendorid AS vendor_id
    ,ratecodeid AS rate_code_id
    ,pulocationid AS pickup_location_id
    ,dolocationid AS dropoff_location_id

    -- Timestamps
    ,tpep_pickup_datetime  AS pickup_datetime
    ,tpep_dropoff_datetime AS dropoff_datetime

    -- Trip Information
    ,store_and_fwd_flag
    ,passenger_count
    ,CAST(trip_distance AS NUMERIC) AS trip_distance

    -- Yellow cabs are always street-hail
    ,1 AS trip_type
    
    -- Payment Information
    ,CAST(fare_amount AS NUMERIC) AS fare_amount
    ,CAST(extra AS NUMERIC) AS extra
    ,CAST(mta_tax AS NUMERIC) AS mta_tax
    ,CAST(tip_amount AS NUMERIC) AS tip_amount
    ,CAST(tolls_amount AS NUMERIC) AS tolls_amount
    ,CAST(0 AS NUMERIC) AS ehail_fee
    ,CAST(improvement_surcharge AS NUMERIC) AS improvement_surcharge
    ,CAST(total_amount AS NUMERIC) AS total_amount
    ,payment_type
    ,{{ get_payment_type_description('payment_type') }} AS payment_type_description
    ,CAST(congestion_surcharge AS NUMERIC) AS congestion_surcharge
FROM
    tripdata
WHERE
    rn = 1
    
-- To include or exclude test run
-- i.e. dbt build --m <model.sql> --var 'is_test_run: false'
{% if var('is_test_run', default=true) %}
    
    limit 100

{% endif %}
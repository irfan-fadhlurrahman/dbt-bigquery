{{ config(materialized='view') }}

SELECT
    {{ dbt_utils.generate_surrogate_key(["dispatching_base_num", "pickup_datetime"]) }} AS trip_id
    ,dispatching_base_num AS dispatching_base_number
    ,pickup_datetime
    ,dropoff_datetime
    ,pulocationid AS pickup_location_id
    ,dolocationid AS dropoff_location_id
    ,sr_flag AS shared_ride_flag
    ,affiliated_base_number
FROM
    {{ source('staging', 'external_fhv_tripdata') }}
WHERE
    pickup_datetime BETWEEN '2019-01-01' AND '2019-12-31'

-- To include or exclude test run
-- i.e. dbt build --m <model.sql> --var 'is_test_run: false'
-- {% if var('is_test_run', default=true) %}
    
--     limit 100

-- {% endif %}
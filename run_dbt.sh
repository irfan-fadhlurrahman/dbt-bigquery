# echo "Run the dbt Core"
# echo "command 'docker-compose run --workdir="//usr/app/dbt/taxi_rides_ny dbt-bq-dtc"' equal 'dbt'"

# echo "Run dbt model"
# docker-compose run --workdir="//usr/app/dbt/taxi_rides_ny" dbt-bq-dtc run -m stg_green_tripdata

# echo "Build the packages.yml"
# docker-compose run --workdir="//usr/app/dbt/taxi_rides_ny" dbt-bq-dtc deps

# echo 'Run dbt seeds'
# docker-compose run --workdir="//usr/app/dbt/taxi_rides_ny" dbt-bq-dtc seed --full-refresh

echo 'Run dbt model without test run'
docker-compose run --workdir="//usr/app/dbt/taxi_rides_ny" dbt-bq-dtc run -m fact_trips --var 'is_test_run: false'

# echo "Run all dbt models"
# docker-compose run --workdir="//usr/app/dbt/taxi_rides_ny" dbt-bq-dtc build --var 'is_test_run: false'
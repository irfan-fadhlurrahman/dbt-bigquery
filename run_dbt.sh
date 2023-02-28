#!/bin/bash
# Source: https://linuxhint.com/bash_if_else_examples/
set -e

FOLDER=$1
TASK_INPUT=$2

if [[ ${TASK_INPUT} == 'debug' ]]; then
    echo "Test dbt connection"; sleep 2
    docker-compose run --workdir="//usr/app/dbt/${FOLDER}" dbt-bq-dtc debug
elif [[ ${TASK_INPUT} == 'deps' ]]; then
    echo "Build the packages.yml"; sleep 2
    docker-compose run --workdir="//usr/app/dbt/${FOLDER}" dbt-bq-dtc deps
elif [[ ${TASK_INPUT} == 'seed' ]]; then
    echo 'Run dbt seeds'; sleep 2
    docker-compose run --workdir="//usr/app/dbt/${FOLDER}" dbt-bq-dtc seed --full-refresh
elif [[ ${TASK_INPUT} == 'build' ]]; then
    echo "Run all dbt models"; sleep 2
    docker-compose run --workdir="//usr/app/dbt/${FOLDER}" dbt-bq-dtc build --var 'is_test_run: false'
else
    echo "Invalid task input"
fi

# echo "Run dbt model"
# docker-compose run --workdir="//usr/app/dbt/${FOLDER}" dbt-bq-dtc run -m stg_green_tripdata

# echo 'Run dbt model without test run'
# docker-compose run --workdir="//usr/app/dbt/${FOLDER}" dbt-bq-dtc run -m fact_trips --var 'is_test_run: false'
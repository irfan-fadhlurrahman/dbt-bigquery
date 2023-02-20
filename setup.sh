# Check here:
# https://github.com/DataTalksClub/data-engineering-zoomcamp/tree/main/week_4_analytics_engineering/docker_setup

# echo "Copy Dockerfile and docker-compose.yaml from Week 4 Material"
# sleep 3
# cd ~/dbt_bigquery
# wget https://github.com/DataTalksClub/data-engineering-zoomcamp/raw/main/week_4_analytics_engineering/docker_setup/Dockerfile
# wget https://github.com/DataTalksClub/data-engineering-zoomcamp/raw/main/week_4_analytics_engineering/docker_setup/docker-compose.yaml

# echo "Create ~/.dbt/profiles.yml"
# sleep 3
# mkdir ~/.dbt
# touch ~/.dbt/profiles.yml

# echo "Edit profiles.yml as per your GCP account information"
# sleep 3

# echo "Build an image"
# sleep 3
# docker-compose build
# docker-compose run dbt-bq-dtc init

# https://stackoverflow.com/questions/66496890/vs-code-nopermissions-filesystemerror-error-eacces-permission-denied
# echo "Edit permissions of dbt folder"
# sleep 3
# sudo chown -R irfanfadh43 /home/irfanfadh43/dbt_bigquery/dbt/taxi_rides_ny/

# echo "Test dbt connection"
# sleep 3
# cd ~/dbt_bigquery
# docker-compose run --workdir="//usr/app/dbt/taxi_rides_ny" dbt-bq-dtc debug

# echo "Shell output must be 'All checks passed!'"
# sleep 3
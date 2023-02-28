# echo "Go to piperider directory"; sleep 2
# cd ~/${PROJECT_FOLDER}/piperider-dbt-bq

# echo "Install Neccessary Packages"; sleep 2
# sudo apt update
# sudo apt install python-is-python3 -y
# sudo apt install python3.10-venv -y

echo "Create Virtual Environment"; sleep 2
python -m venv ./venv

echo "Activate Virtual Environment"; sleep 2
source ./venv/bin/activate

# NOTES: Use python 3.9 to avoid error
echo "Install necessary packages"; sleep 2
pip install -U pip
pip install 'piperider[bigquery]' dbt-core dbt-bigquery sqlalchemy pybigquery

echo "Install dbt packages and build dbt models"; sleep 2
cd ~/piperider-dbt-bq/dbt/taxi_rides_ny
dbt deps
dbt build

echo "Initialize PipeRider"; sleep 2
piperider init

echo "Check PipeRider Settings"; sleep 2
piperider diagnose

echo "TODO manually: Install VSCode extension: Live Server to check outputs/index.html"
# Source: https://www.alphr.com/vs-code-open-in-browser/#:~:text=Open%20your%20HTML%20file%20in,that%20matches%20your%20search%20term.
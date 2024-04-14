# Install pip3
sudo apt install python3-pip
sudo apt install python3.8-venv

# create env and activate
python3 -m venv dbt-env
source dbt-env/bin/activate

# Install dbt core and bigquery plugin
pip3 install dbt-bigquery

alias dbt-env="source $HOME/dbt-env/bin/activate"

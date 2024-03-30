from mage_ai.settings.repo import get_repo_path
from mage_ai.io.bigquery import BigQuery
from mage_ai.io.config import ConfigFileLoader
from pandas import DataFrame
import os

if 'data_exporter' not in globals():
    from mage_ai.data_preparation.decorators import data_exporter


@data_exporter
def export_data_to_big_query(df: DataFrame, **kwargs) -> None:

    path_to_credentials = f"{os.environ['GCP_SERVICE_ACCT_FILE']}"    
    project_id = f"{os.environ['PROJECT_ID']}"
    table_name = 'lacity-active-businesses'
    table_id = f'{project_id}.bq_default.{table_name}'

    BigQuery.with_credentials_file(path_to_credentials).export(
        df,
        table_id,
        if_exists='replace',  # Specify resolution policy if table name already exists
    )

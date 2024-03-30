import pyarrow as pa
import pyarrow.parquet as pq
import os

if 'data_exporter' not in globals():
    from mage_ai.data_preparation.decorators import data_exporter

bucket_name = f"{os.environ['GENERATED_BUCKET_NAME']}"
project_id = f"{os.environ['PROJECT_ID']}"
table_name = 'lacity-active-businesses'

user_code_path = f"{os.environ['USER_CODE_PATH']}"
service_acct_file_name = f"{os.environ['SERVICE_ACCT_FILE_NAME']}"

# set the enviroment variable
os.environ['GOOGLE_APPLICATION_CREDENTIALS'] = f'{user_code_path}/credentials/{service_acct_file_name}'


root_path = f'{bucket_name}/{table_name}'

@data_exporter
def export_data(data, *args, **kwargs):
    data['location_start_year'] = data['location_start_date'].dt.year

    table = pa.Table.from_pandas(data)

    gcs = pa.fs.GcsFileSystem()

    pq.write_to_dataset(
        table,
        root_path=root_path,
        partition_cols=['location_start_year'],
        filesystem=gcs
    )
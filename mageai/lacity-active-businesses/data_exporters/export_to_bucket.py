import pyarrow as pa
import pyarrow.parquet as pq
import os

if 'data_exporter' not in globals():
    from mage_ai.data_preparation.decorators import data_exporter

bucket_name = f"{os.environ['GENERATED_BUCKET_NAME']}"
project_id = f"{os.environ['PROJECT_ID']}"
table_name = 'lacity-active-businesses'

# set the enviroment variable
os.environ['GOOGLE_APPLICATION_CREDENTIALS'] = f"{os.environ['GCP_SERVICE_ACCT_FILE']}"


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
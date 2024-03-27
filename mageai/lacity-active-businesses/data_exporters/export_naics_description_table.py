import pyarrow as pa
import pyarrow.parquet as pq
import os

if 'data_exporter' not in globals():
    from mage_ai.data_preparation.decorators import data_exporter

# set the enviroment variable
os.environ['GOOGLE_APPLICATION_CREDENTIALS'] = '/home/src/lacity-pipeline-service-acct-credential.json'

bucket_name = ''
project_id = ''
table_name = 'naics_description'

root_path = f'{bucket_name}/{table_name}'

@data_exporter
def export_data(naics_description_table, *args, **kwargs):

   table = pa.Table.from_pandas(naics_description_table)

   gcs = pa.fs.GcsFileSystem()

   pq.write_to_dataset(
    table,
    root_path=root_path,
    partition_cols=['location_start_year'],
    filesystem=gcs
   )
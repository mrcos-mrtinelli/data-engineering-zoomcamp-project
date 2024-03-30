import io
import pandas as pd
import requests
from pandas import DataFrame

if 'data_loader' not in globals():
    from mage_ai.data_preparation.decorators import data_loader
if 'test' not in globals():
    from mage_ai.data_preparation.decorators import test

LACITY_DATA_URL = "https://data.lacity.org/resource/6rrh-rzua.csv"
LIMIT = 50000

@data_loader
def load_data_from_api(**kwargs) -> DataFrame:
    end_of_data = False
    offset = 0

    df = []
    data_dtype = {
    "naics": pd.Int64Dtype(),
    "zip_code": str,
    "council_district": pd.Int64Dtype()
    }
    dates = ["location_start_date", "location_end_date"]

    while not(end_of_data):
        # limit and offset used together to page through
        # offset sets next page, e.g., page 2 = $limit=50&$offset=50
        url = f"{LACITY_DATA_URL}?$limit={LIMIT}&$offset={offset}"

        lacity_data = pd.read_csv(url, dtype=data_dtype, parse_dates=dates)

        if len(lacity_data) < 50000:
            end_of_data = True
        else: 
            offset += LIMIT
        
        df.append(lacity_data)
        
        # for testing - remove when done testing
        if offset > 100000:
            break
    
    df = pd.concat(df)

    return df


@test
def test_output(df) -> None:
    
    assert len(df.columns) == 16, f'Found {df.columns} cols. Expecting 16 cols.'


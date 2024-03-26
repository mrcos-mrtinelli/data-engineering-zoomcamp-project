import pandas as pd

if 'transformer' not in globals():
    from mage_ai.data_preparation.decorators import transformer
if 'test' not in globals():
    from mage_ai.data_preparation.decorators import test


@transformer
def transform(data, *args, **kwargs):
    data["location_start_date"] = pd.to_datetime(data["location_start_date"],format="%Y-%m-%d")
    data["location_end_date"] = pd.to_datetime(data["location_end_date"],format="%Y-%m-%d")

    return data


@test
def test_output(output, *args) -> None:
    """
    Template code for testing the output of the block.
    """
    assert output is not None, 'The output is undefined'

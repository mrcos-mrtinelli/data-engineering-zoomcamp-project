if 'transformer' not in globals():
    from mage_ai.data_preparation.decorators import transformer
if 'test' not in globals():
    from mage_ai.data_preparation.decorators import test


@transformer
def transform(data, *args, **kwargs):
    # rename
    data = data.rename(columns={'location_account': 'id'})

    #create active businesses table
    active_businesses_table = data.drop(["naics", "primary_naics_description", "location_1"], axis=1)

    return active_businesses_table


@test
def test_output(output, *args) -> None:
    """
    Template code for testing the output of the block.
    """
    assert output is not None, 'The output is undefined'

if 'transformer' not in globals():
    from mage_ai.data_preparation.decorators import transformer
if 'test' not in globals():
    from mage_ai.data_preparation.decorators import test


@transformer
def transform(data, *args, **kwargs):

    # drop unwanted columns
    data = data.drop(["location_1"], axis=1)

    return data


@test
def test_output(data, *args) -> None:

    assert len(data.columns) == 15, f'Found {df.columns} cols. Expecting 15 cols.'

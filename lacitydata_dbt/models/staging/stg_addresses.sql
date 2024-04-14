select 
    location_account as business_id,
    street_address,
    city,
    zip_code,
    mailing_address,
    mailing_city,
    mailing_zip_code

from `{{ var("project_name") }}.bq_default.lacity-active-businesses`
select 
    location_account as id,
    business_name,
    dba_name,
    location_start_date,
    location_end_date,
    naics as naics_code

from `{{ var("project_name") }}.bq_default.lacity-active-businesses`
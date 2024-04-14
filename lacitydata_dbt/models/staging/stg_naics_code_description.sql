select
    DISTINCT(naics) as naics_code,
    primary_naics_description as naics_description

from `{{ var("project_id") }}.bq_default.lacity-active-businesses`
order by naics_code
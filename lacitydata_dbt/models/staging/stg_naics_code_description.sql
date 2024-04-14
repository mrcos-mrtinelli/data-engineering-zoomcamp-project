select
    DISTINCT(naics) as naics_code,
    primary_naics_description as naics_description

from `{{ var("project_name") }}.bq_default.lacity-active-businesses`
order by naics_code
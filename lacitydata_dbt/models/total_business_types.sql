with businesses as (
    select * from {{ ref('stg_businesses') }}
),

naics as (
    select * from {{ ref('stg_naics_code_description') }}
),

final as (
    select 
        n.naics_description as type_description,
        count(b.id) as total_count
    from 
        businesses b
    left join naics n on b.naics_code = n.naics_code
    group by n.naics_description
    order by total_count DESC
)

select * from final
with businesses as (
    select * from {{ ref('stg_businesses') }}
),

city as (
    select 
        business_id,
        city
    from {{ ref('stg_addresses') }}
),

final as (
    select 
        c.city,
        count(b.id) as total_businesses
    from 
        businesses b
    left join city c on b.id = c.business_id 
    group by c.city
    order by total_businesses DESC
)

select * from final
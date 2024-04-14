with business_name as (
    select 
        id,
        coalesce(dba_name, business_name) as name
    from {{ ref('stg_businesses') }}
),

mailing_address as (
    select 
        business_id,
        coalesce(mailing_address, street_address) as address,
        coalesce(mailing_city, city) as city,
        coalesce(mailing_zip_code, zip_code) as zip_code

    from {{ ref('stg_addresses') }}
),

final as (
    select 
        bn.id as business_id,
        bn.name,
        ma.address,
        ma.city,
        ma.zip_code
    from business_name bn
    left join mailing_address ma on bn.id = ma.business_id
    where city is not null
)

select * from final

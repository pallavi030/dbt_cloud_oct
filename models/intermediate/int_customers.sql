with customers as (
    select
        customers_id,
        name                as customer_name,
        address             as customer_address,
        nation_id,
        phone_number,
        account_balance,
        market_segment,
        comment             as customer_comment
    from {{ ref('stg_customers') }}
),

nations as (
    select
        nation_id,
        nation_name,
        region_id,
        updated_at          as nation_updated_at
    from {{ ref('stg_nations') }}
),

regions as (
    select
        region_id,
        region_name,
        comment             as region_comment
    from {{ ref('stg_regions') }}
),

final as (
    select
        -- Customer columns
        c.customers_id,
        c.customer_name,
        c.customer_address,
        c.phone_number,
        c.account_balance,
        c.market_segment,
        c.customer_comment,
        c.nation_id,

        -- Nation columns
        n.nation_name,
        n.region_id,
        n.nation_updated_at,

        -- Region columns
        r.region_name,
        r.region_comment

    from customers c
    join nations n 
        on c.nation_id = n.nation_id
    join regions r
        on n.region_id = r.region_id
)

select * from final

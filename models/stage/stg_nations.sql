{{config(alias= this.name + var('v_id'))}}
with nation as (
    select 
        N_NATIONKEY as nation_id,
        N_NAME as nation_name,
        N_REGIONKEY as region_id,
        updated_at 
    from {{ source('src', 'nations') }}
)
select * from nation

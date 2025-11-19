{% snapshot scd_orders %}

{{
  config(
    target_database='Analytics',
    target_schema='scds',
    alias='scd3',
    unique_key='o_orderkey',
    strategy='check',
    check_cols=['o_orderpriority','o_orderdate','o_comment'],
    hard_deletes='new_record'
  )
}}

    select * from {{ source('src','orders')}}
{% endsnapshot %}
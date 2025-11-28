{% macro dbt_meta() -%}
    '{{ invocation_id }}' as  dbt_batch_id,
    '{{ run_started_at }}' as dbt_batch_ts
{%- endmacro %}

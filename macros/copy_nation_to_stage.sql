{% macro crt_stage() %}
   {% do run_query('create or replace stage int_stage') %}
{% endmacro %}

{% macro load_stage() %}
   {% do run_query('copy into @int_stage from stg_nations partition by (region_id) header=true  file_format =(compression=none)') %}
{% endmacro %}
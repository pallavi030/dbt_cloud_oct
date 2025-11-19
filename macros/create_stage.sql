{% macro unload() %}
    {% set sql %}
        CREATE OR REPLACE STAGE analytics.dbt_pallavi.nations_stage
        FILE_FORMAT = (TYPE = CSV, FIELD_DELIMITER = ',', FIELD_OPTIONALLY_ENCLOSED_BY = '"')
        COMMENT = 'Stage created by dbt for exporting nations';
    {% endset %}

    {% do run_query(sql) %}
    {{ log("Stage analytics.dbt_pallavi.nations_stage created.", info=True) }}
{% endmacro %}

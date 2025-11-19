{% macro pang(first_name, last_name, gender, fixedline, age) %}
    {{ first_name }} || ' ' || {{ last_name }} as employee_name,
    case upper({{ gender }})
        when 'F' then 'Female'
        when 'M' then 'Male'
        else 'Other'
    end as gender_label,
    '(' || left({{ fixedline }}, 3) || ') ' ||
    substring({{ fixedline }}, 4, 3) || '-' ||
    right({{ fixedline }}, 4) as formatted_phone,
    case
        when {{ age }} < 30 then 'Youngest'
        when {{ age }} between 30 and 60 then 'Middle'
        else 'Senior'
    end as age_group
{% endmacro %}

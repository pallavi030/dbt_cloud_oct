{{ config(materialized="table") }}

with source as (
    select *
    from {{ source('mkm', 'stg_employees') }}
),

pang_out as (
    select
        *,
        {{ pang(
            "EMPLOYEE_FIRST_NAME",
            "EMPLOYEE_LAST_NAME",
            "EMPLOYEE_GENDER",
            "EMPLOYEE_FIXEDLINE",
            "EMPLOYEE_AGE"
        ) }}
    from source
),

changed as (
    select
        EMPLOYEE_ID,
        employee_name as EMPLOYEE_NAME,

        EMPLOYEE_ADDRESS,
        EMPLOYEE_CITY,
        EMPLOYEE_STATE,
        EMPLOYEE_ZIP_CODE,
        EMPLOYEE_MOBILE,

        formatted_phone as EMPLOYEE_FIXED_LINE,
        EMPLOYEE_EMAIL,

        gender_label as EMPLOYEE_GENDER,
        EMPLOYEE_AGE,
        age_group as AGE_GROUP,

        POSITION_TYPE,
        DEALERSHIP_ID,
        DEALERSHIP_MANAGER,

        SALARY as EMPLOYEE_SALARY,
        REGION as EMPLOYEE_REGION

    from pang_out
)

select * from changed
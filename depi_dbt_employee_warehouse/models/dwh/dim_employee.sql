{{ config(materialized='table') }}

SELECT
    {{ generate_surrogate_key(["cast(employee_id as varchar(20))"]) }} AS employee_key,
    employee_id,
    first_name,
    last_name,
    department_id,
    country_id,
    gender_id,
    date_of_birth,
    hire_date,
    {{ calculate_age('date_of_birth') }} AS age_years,
    salary,
    employment_status
FROM {{ ref('stg_employees') }}

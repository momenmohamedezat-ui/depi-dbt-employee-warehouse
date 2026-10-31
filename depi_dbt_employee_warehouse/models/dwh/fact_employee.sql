{{ config(materialized='table') }}

SELECT
    e.employee_id,
    de.employee_key,
    dd.department_key,
    dc.country_key,
    dg.gender_key,
    dt.date_key AS birth_date_key,
    e.salary,
    e.employment_status,
    e.hire_date
FROM {{ ref('stg_employees') }} AS e
INNER JOIN {{ ref('dim_employee') }} AS de
    ON e.employee_id = de.employee_id
LEFT JOIN {{ ref('dim_department') }} AS dd
    ON e.department_id = dd.department_id
LEFT JOIN {{ ref('dim_country') }} AS dc
    ON e.country_id = dc.country_id
LEFT JOIN {{ ref('dim_gender') }} AS dg
    ON e.gender_id = dg.gender_id
LEFT JOIN {{ ref('dim_date') }} AS dt
    ON CAST(e.date_of_birth AS DATE) = dt.full_date

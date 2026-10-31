{{ config(materialized='view') }}

SELECT
    CAST(employee_id AS INT) AS employee_id,
    LTRIM(RTRIM(first_name)) AS first_name,
    LTRIM(RTRIM(last_name)) AS last_name,
    CAST(department_id AS INT) AS department_id,
    CAST(country_id AS INT) AS country_id,
    CAST(gender_id AS INT) AS gender_id,
    CAST(date_of_birth AS DATE) AS date_of_birth,
    CAST(hire_date AS DATE) AS hire_date,
    CAST(salary AS DECIMAL(12, 2)) AS salary,
    LTRIM(RTRIM(employment_status)) AS employment_status
FROM {{ source('hr', 'employees') }}

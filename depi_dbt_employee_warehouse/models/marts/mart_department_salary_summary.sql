{{ config(materialized='table') }}

SELECT
    d.department_id,
    d.department_name,
    COUNT(*) AS employee_count,
    AVG(CAST(f.salary AS DECIMAL(12, 2))) AS average_salary,
    MIN(f.salary) AS minimum_salary,
    MAX(f.salary) AS maximum_salary
FROM {{ ref('fact_employee') }} AS f
INNER JOIN {{ ref('dim_department') }} AS d
    ON f.department_key = d.department_key
GROUP BY
    d.department_id,
    d.department_name

-- Ad-hoc analysis; execute with `dbt compile` to inspect compiled SQL.
SELECT
    department_id,
    COUNT(*) AS employee_count,
    AVG(CAST(salary AS DECIMAL(12, 2))) AS average_salary
FROM {{ ref('stg_employees') }}
GROUP BY department_id
ORDER BY department_id

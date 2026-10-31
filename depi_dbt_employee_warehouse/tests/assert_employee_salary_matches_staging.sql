-- Singular test: the fact salary should match the staging source for each employee.
SELECT
    f.employee_id,
    f.salary AS fact_salary,
    s.salary AS staging_salary
FROM {{ ref('fact_employee') }} AS f
INNER JOIN {{ ref('stg_employees') }} AS s
    ON f.employee_id = s.employee_id
WHERE f.salary <> s.salary
   OR f.salary IS NULL
   OR s.salary IS NULL

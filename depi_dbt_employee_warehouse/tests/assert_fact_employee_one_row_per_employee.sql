-- Singular test: returns rows if fact grain is violated.
SELECT
    employee_id,
    COUNT(*) AS row_count
FROM {{ ref('fact_employee') }}
GROUP BY employee_id
HAVING COUNT(*) <> 1

{{ config(materialized='view') }}

SELECT
    CAST(department_id AS INT) AS department_id,
    LTRIM(RTRIM(department_name)) AS department_name,
    LTRIM(RTRIM(location)) AS location
FROM {{ source('hr', 'departments') }}

{{ config(materialized='table') }}

SELECT
    {{ generate_surrogate_key(["cast(department_id as varchar(20))"]) }} AS department_key,
    department_id,
    department_name,
    location
FROM {{ ref('stg_departments') }}

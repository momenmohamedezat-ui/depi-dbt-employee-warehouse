{{ config(materialized='table') }}

SELECT DISTINCT
    {{ generate_surrogate_key(["convert(varchar(10), date_of_birth, 23)"]) }} AS date_key,
    CAST(date_of_birth AS DATE) AS full_date,
    YEAR(date_of_birth) AS year_number,
    MONTH(date_of_birth) AS month_number,
    DAY(date_of_birth) AS day_number
FROM {{ ref('stg_employees') }}
WHERE date_of_birth IS NOT NULL

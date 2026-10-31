{{ config(materialized='view') }}

SELECT
    CAST(country_id AS INT) AS country_id,
    LTRIM(RTRIM(country_name)) AS country_name,
    UPPER(LTRIM(RTRIM(country_code))) AS country_code
FROM {{ source('hr', 'countries') }}

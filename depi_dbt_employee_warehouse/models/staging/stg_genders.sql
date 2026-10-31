{{ config(materialized='view') }}

SELECT
    CAST(gender_id AS INT) AS gender_id,
    LTRIM(RTRIM(gender_name)) AS gender_name
FROM {{ source('hr', 'genders') }}

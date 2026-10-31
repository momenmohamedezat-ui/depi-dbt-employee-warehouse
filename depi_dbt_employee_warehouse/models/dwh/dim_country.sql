{{ config(materialized='table') }}

SELECT
    {{ generate_surrogate_key(["cast(country_id as varchar(20))"]) }} AS country_key,
    country_id,
    country_name,
    country_code
FROM {{ ref('stg_countries') }}

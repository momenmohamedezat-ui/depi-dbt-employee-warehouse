{{ config(materialized='table') }}

SELECT
    {{ generate_surrogate_key(["cast(gender_id as varchar(20))"]) }} AS gender_key,
    gender_id,
    gender_name
FROM {{ ref('stg_genders') }}

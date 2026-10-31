{% macro calculate_age(birth_date) -%}
    DATEDIFF(YEAR, {{ birth_date }}, CAST(GETDATE() AS DATE))
    - CASE
        WHEN DATEADD(
            YEAR,
            DATEDIFF(YEAR, {{ birth_date }}, CAST(GETDATE() AS DATE)),
            {{ birth_date }}
        ) > CAST(GETDATE() AS DATE)
        THEN 1
        ELSE 0
      END
{%- endmacro %}

{% macro generate_surrogate_key(fields) -%}
    CONVERT(
        VARCHAR(64),
        HASHBYTES(
            'SHA2_256',
            CONCAT(
                {%- for field in fields -%}
                    COALESCE(CAST({{ field }} AS VARCHAR(4000)), '<NULL>')
                    {%- if not loop.last %}, '||', {% endif -%}
                {%- endfor -%}
            )
        ),
        2
    )
{%- endmacro %}

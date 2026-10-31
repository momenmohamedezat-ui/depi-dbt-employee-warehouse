{% test positive_salary(model, column_name) %}
SELECT *
FROM {{ model }}
WHERE {{ column_name }} IS NULL
   OR {{ column_name }} <= 0
{% endtest %}

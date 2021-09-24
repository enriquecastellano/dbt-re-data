
{% macro re_data_metric_max(column_name) %}
    max({{column_name}})
{% endmacro %}

{% macro re_data_metric_min(column_name) %}
    min({{column_name}})
{% endmacro %}

{% macro re_data_metric_avg(column_name) %}
    avg(cast ({{column_name}} as {{ numeric_type() }}))
{% endmacro %}

{% macro re_data_metric_stddev(column_name) %}
    stddev(cast ( {{column_name}} as {{ numeric_type() }}))
{% endmacro %}

{% macro re_data_metric_variance(column_name) %}
    variance(cast ( {{column_name}} as {{ numeric_type() }}))
{% endmacro %}

{% macro re_data_metric_max_length(column_name) %}
    max(length({{column_name}}))
{% endmacro %}

{% macro re_data_metric_min_length(column_name) %}
    min(length({{column_name}}))
{% endmacro %}

{% macro re_data_metric_avg_length(column_name) %}
    avg(cast (length( {{column_name}} ) as {{ numeric_type() }}))
{% endmacro %}

{% macro re_data_metric_nulls_count(column_name) %}
    coalesce(
        sum(
            case when {{column_name}} is null
                then 1
            else 0
            end
        ), 0
    )
{% endmacro %}

{% macro re_data_metric_missing_count(column_name) %}
    coalesce(
        sum(
            case 
            when {{column_name}} is null
                then 1
            when {{column_name}} = ''
                then 1
            else 0
            end
        ), 0
    )
{% endmacro %}

{% macro re_data_metric_nulls_percent(column_name) %}
    {{ re_data_metric_nulls_count(column_name) }} / nullif({{ re_data_metric_row_count() }}, 0) * 100
{% endmacro %}

{% macro re_data_metric_missing_percent(column_name) %}
    {{ re_data_metric_missing_count(column_name) }} / nullif({{ re_data_metric_row_count() }}, 0) * 100
{% endmacro %}

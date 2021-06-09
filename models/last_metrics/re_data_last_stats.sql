{% set metrics_tables = ['re_data_base_metrics', 're_data_freshness'] %}

{%- for table_name in metrics_tables %}
    select
        table_name,
        column_name,
        metric,
        avg(value) as last_avg,
        stddev(value) as last_stddev,
        max(time_window_end) as last_metric_time,
        max(computed_on) as computed_on
    from
        {{ ref(table_name) }}
    where
        time_window_end > {{- anamaly_detection_time_window_start() -}} and
        time_window_end <= {{- time_window_end() -}}
    group by
        table_name, column_name, metric

    {%- if not loop.last %} union all {%- endif %}    

{% endfor %}
-- CTE; functioning as a staging layer
WITH pre_aggregated_data AS (
    SELECT
        timestamp::date AS download_date,
        details.system.name AS system_name,
        details.system.release AS system_release,
        file.version AS version,
        project,
        country_code,
        details.cpu AS cpu,
        CASE
            WHEN details.python IS NULL THEN NULL
            ELSE CONCAT(
                SPLIT_PART(details.python, '.', 1),
                '.',
                SPLIT_PART(details.python, '.', 2)
            )
        END AS python_version
    -- FROM {{ source('external_source', 'pypi_file_downloads') }}
    FROM 's3://us-prd-motherduck-open-datasets/pypi/sample_tutorial/pypi_file_downloads/*/*/*.parquet'
    -- filtering
    WHERE
        download_date >= '{{ var("start_date") }}'
        AND download_date < '{{ var("end_date") }}'
)

SELECT 
    -- creates a unique hash (load_id) of the relevant fields which acts as a surrogate key for the fact table
    MD5(CONCAT_WS('|', download_date, system_name, system_release, version, project, country_code, cpu, python_version  )) AS load_id,
    download_date,
    system_name,
    system_release,
    version,
    project,
    country_code,
    cpu,
    python_version,
    COUNT(*) AS daily_download_sum
FROM
    pre_aggregated_data
GROUP BY
    ALL
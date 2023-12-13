{{
  config(
    materialized='view'
  )
}}

WITH src_promos AS (
    SELECT
        cast(lower(promo_id) as varchar) AS promo_id,
        lower(promo_id) AS promo_name,
        cast(discount AS number) AS discount,
        cast(status AS varchar) AS status,
        _fivetran_synced AS date_load
    FROM {{ source('sql_server_dbo', 'promos') }}
    UNION ALL
    SELECT
        '9999',
        'sin promo',
        0,
        'active',
        current_timestamp
),

stg_promos AS (
    SELECT 
        cast({{ dbt_utils.generate_surrogate_key(['promo_id']) }}as varchar) AS promo_id,
        promo_name,
        discount,
        status,
        date_load
    FROM src_promos

)

SELECT * FROM stg_promos

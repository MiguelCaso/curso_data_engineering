
{{
  config(
    materialized='view'
  )
}}

WITH src_promos AS (
    SELECT 
        CAST({{ dbt_utils.generate_surrogate_key(['promo_id']) }}as varchar) as promokey_id
        , promo_id as promo_name
        , discount
        , status
        , _fivetran_synced AS date_load 
    FROM {{ source('sql_server_dbo', 'promos') }}
    ),

stg_promos AS (
    SELECT *
    FROM src_promos
    UNION ALL
    SELECT '9999','sin promo',0,'active',CURRENT_TIMESTAMP
    )

SELECT * FROM stg_promos
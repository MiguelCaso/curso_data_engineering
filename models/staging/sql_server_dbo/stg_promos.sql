
{{
  config(
    materialized='view'
  )
}}

WITH src_promos AS (
    SELECT * 
    FROM {{ source('sql_server_dbo', 'promos') }}
    ),

stg_promos AS (
    SELECT
        {{ dbt_utils.generate_surrogate_key(['promo_id']) }} as promokey_id
        , promo_id
        , discount
        , status
        , _fivetran_synced AS date_load
    FROM src_promos
    )

SELECT * FROM stg_promos
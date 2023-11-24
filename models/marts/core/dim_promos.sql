{{
  config(
    materialized='table',
  )
}}

WITH int_promos AS (
    SELECT 
        promokey_id
        , promo_name
        , discount
        , status
    FROM {{ ref('stg_promos') }}
)

SELECT * FROM int_promos

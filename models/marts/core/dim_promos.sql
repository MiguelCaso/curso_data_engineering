{{
  config(
    materialized='table',
  )
}}

WITH stg_promos AS (
    SELECT 
        promokey_id
        , promo_name
        , discount
        , status
    FROM {{ ref('stg_promos') }}
)

SELECT * FROM stg_addresses

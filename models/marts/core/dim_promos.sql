{{
  config(
    materialized='table',
  )
}}

WITH dim_promos AS (
    SELECT
        promo_id,
        promo_name,
        discount,
        status
    FROM {{ ref('stg_promos') }}
)

SELECT * FROM dim_promos

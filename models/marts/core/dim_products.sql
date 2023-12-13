{{
  config(
    materialized='table'
  )
}}

WITH dim_products AS (
    SELECT
        product_id,
        name,
        price,
        inventory
    FROM {{ ref('stg_products') }}
)

SELECT * FROM dim_products

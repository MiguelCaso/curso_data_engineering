{{
  config(
    materialized='table'
  )
}}

WITH stg_products AS (
    SELECT *
    FROM {{ ref('stg_products') }}
)

SELECT * FROM stg_products

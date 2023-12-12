{{
  config(
    materialized='table'
  )
}}

WITH int_orders AS (
    SELECT
        order_id,
        order_cost_dollars,
        shipping_cost_dollars,
        order_total_dollars
    FROM {{ ref('stg_orders') }}
)

SELECT * FROM int_orders

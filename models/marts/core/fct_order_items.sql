{{
  config(
    materialized='table',
  )
}}

WITH int_order_items AS (
    SELECT *
    FROM {{ ref('int_order_items') }}
),

fct_order_items AS (
    SELECT
        order_id,
        product_id,
        user_id,
        shipping_address_id,
        promo_id,
        cast (created_at_utc as date) as created_at_date_utc,
        cast (created_at_utc as time) as created_at_time_utc,
        quantity as product_quantity,
        order_line_cost_usd,
        order_line_discount_usd
    FROM int_order_items
    ORDER BY order_id
)

SELECT * FROM fct_order_items

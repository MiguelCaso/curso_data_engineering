{{
  config(
    materialized='table',
  )
}}

WITH prev_order_items AS (
    SELECT
        stg_order_items.order_id,
        stg_order_items.product_id,
        stg_order_items.quantity,
        stg_orders.user_id,
        stg_orders.address_id,
        stg_orders.promokey_id,
        stg_orders.created_at_utc,
        stg_products.price,
        stg_order_items.date_load
    FROM {{ ref('stg_order_items') }}
    INNER JOIN
        {{ ref('stg_orders') }}
        ON stg_order_items.order_id = stg_orders.order_id
    INNER JOIN
        {{ ref('stg_products') }}
        ON stg_order_items.product_id = stg_products.product_id
),

post_order_items AS (
    SELECT
        order_id,
        product_id,
        user_id,
        address_id AS shipping_address,
        promokey_id AS promo_id,
        created_at_utc,
        quantity,
        price * quantity AS order_line_cost,
        date_load
    FROM prev_order_items
    ORDER BY order_id
)

SELECT * FROM post_order_items

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
        stg_orders.promo_id,
        stg_orders.created_at_utc,
        stg_products.price,
        stg_promos.discount,
        stg_order_items.date_load
    FROM {{ ref('stg_order_items') }}
    INNER JOIN
        {{ ref('stg_orders') }}
        ON stg_order_items.order_id = stg_orders.order_id
    INNER JOIN
        {{ ref('stg_products') }}
        ON stg_order_items.product_id = stg_products.product_id
    INNER JOIN
        {{ ref('stg_promos') }}
        ON stg_orders.promo_id = stg_promos.promo_id
),

int_order_items AS (
    SELECT
        order_id,
        product_id,
        user_id,
        address_id as shipping_address_id,
        promo_id,
        created_at_utc,
        quantity,
        price * quantity as order_line_cost_usd,
        truncate(order_line_cost_usd * (discount/100),2) as order_line_discount_usd,
        date_load
    FROM prev_order_items
    ORDER BY order_id
)

SELECT * FROM int_order_items

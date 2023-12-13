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
        SUM (stg_order_items.quantity) OVER (PARTITION BY stg_order_items.order_id) as total_quantity,
        stg_orders.user_id,
        stg_orders.address_id,
        stg_orders.promo_id,
        stg_orders.created_at_utc,
        stg_orders.shipping_cost_dollars,
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
        total_quantity,
        price * quantity as order_line_cost_usd,
        truncate(order_line_cost_usd * (discount/100),3) as order_line_discount_usd,
        truncate(shipping_cost_dollars / total_quantity * quantity, 3) as sliced_shipping_cost_usd,
        truncate(sliced_shipping_cost_usd * (discount/100), 3) as sliced_shipping_discount_usd,
        SUM (order_line_cost_usd) OVER (PARTITION BY order_id) as test_order_total_cost,
        SUM (sliced_shipping_cost_usd) OVER (PARTITION BY order_id) as test_shipping_cost,
        SUM (order_line_discount_usd) OVER (PARTITION BY order_id) as test_order_discount,
        SUM (sliced_shipping_discount_usd) OVER (PARTITION BY order_id) as test_shipping_discount,
        test_order_total_cost + test_shipping_cost - test_order_discount - test_shipping_discount as test_total_cost,
        test_order_total_cost + test_shipping_cost as real_cost,
        date_load
    FROM prev_order_items
    ORDER BY order_id
)

SELECT * FROM int_order_items

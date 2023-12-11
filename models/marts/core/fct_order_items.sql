{{
  config(
    materialized='table',
  )
}}

-- Pendiente

WITH stg_order_items AS (
    SELECT *
    FROM {{ ref('stg_order_items') }}
),

int_order_items AS (
    SELECT
        order_id,
        product_id,
        -- user_id,
        -- address_id as shipping_address,
        -- promokey_id as promo_id
        -- 


    FROM stg_order_items
    -- INNER JOIN {{ ref('stg_orders') }} ON stg_order_items.address_id = stg_orders.address_id
    -- INNER JOIN {{ ref('stg_xxx') }} ON stg_order_items.address_id = stg_xxx.address_id
)

SELECT * FROM int_order_items

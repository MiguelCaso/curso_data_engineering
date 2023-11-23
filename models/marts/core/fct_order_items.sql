{{
  config(
    materialized='table',
  )
}}

WITH stg_order_items AS (
    SELECT
    *
    FROM {{ ref('stg_order_items') }}
),

int_order_items AS (
    SELECT
    *
    FROM src_orders
)

SELECT * FROM int_order_items

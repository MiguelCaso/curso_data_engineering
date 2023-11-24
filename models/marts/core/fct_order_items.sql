{{
  config(
    materialized='table',
  )
}}

-- Pendiente

WITH stg_order_items AS (
    SELECT
    *
    FROM {{ ref('stg_order_items') }}
),

int_order_items AS (
    SELECT
    *
    FROM stg_order_items
)

SELECT * FROM int_order_items

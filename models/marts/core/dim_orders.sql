
{{
  config(
    materialized='table'
  )
}}

WITH stg_orders AS (
    SELECT 
          order_id
        , created_at_utc
        , promokey_id
        , user_id
        , order_cost_dollars
        , shipping_cost_dollars
        , order_total_dollars
    FROM {{ ref('stg_orders') }}
    ),

int_orders AS (
    SELECT *
    FROM stg_orders
    )

SELECT * FROM int_orders
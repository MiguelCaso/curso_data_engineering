
{{
  config(
    materialized='view'
  )
}}

WITH src_orders AS (
    SELECT * 
    FROM {{ source('sql_server_dbo', 'orders') }}
    ),

stg_orders AS (
    SELECT
          order_id
        , created_at
        , promo_id
        , order_cost
        , order_total
        , user_id
        , address_id
        , tracking_id
        , status
        , shipping_service
        , shipping_cost
        , estimated_delivery_at
        , delivered_at
        , _fivetran_synced AS date_load
    FROM src_orders
    )

SELECT * FROM stg_orders
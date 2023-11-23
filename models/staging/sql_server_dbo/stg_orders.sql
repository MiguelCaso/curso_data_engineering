
{{
  config(
    materialized='view'
  )
}}

WITH src_orders AS (
    SELECT 
        order_id
        , created_at as created_at_utc
        , decode (promo_id,'','9999',promo_id) as promo_id
        , order_cost as order_cost_dollars
        , order_total as order_total_dollars
        , user_id
        , address_id
        , tracking_id
        , status
        , shipping_service
        , shipping_cost as shipping_cost_dollars
        , estimated_delivery_at as estimated_delivery_at_utc
        , delivered_at as delivered_at_utc
        , _fivetran_synced AS date_load
    FROM {{ source('sql_server_dbo', 'orders') }}
    ),

stg_orders AS (
    SELECT
          order_id
        , created_at_utc
        , {{ dbt_utils.generate_surrogate_key(['promo_id']) }} as promokey_id
        , order_cost_dollars
        , order_total_dollars
        , user_id
        , address_id
        , tracking_id
        , status
        , shipping_service
        , shipping_cost_dollars
        , estimated_delivery_at_utc
        , delivered_at_utc
        , date_load
    FROM src_orders
    )

SELECT * FROM stg_orders
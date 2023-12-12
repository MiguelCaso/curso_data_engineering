{{
  config(
    materialized='view'
  )
}}

WITH src_orders AS (
    SELECT
        order_id,
        created_at AS created_at_utc,
        order_cost AS order_cost_dollars,
        order_total AS order_total_dollars,
        user_id,
        address_id,
        tracking_id,
        status,
        shipping_service,
        shipping_cost AS shipping_cost_dollars,
        estimated_delivery_at AS estimated_delivery_at_utc,
        delivered_at AS delivered_at_utc,
        _fivetran_synced AS date_load,
        decode(promo_id, '', '9999', promo_id) AS promo_id
    FROM {{ source('sql_server_dbo', 'orders') }}
),

stg_orders AS (
    SELECT
        order_id,
        created_at_utc,
        {{ dbt_utils.generate_surrogate_key(['promo_id']) }} as promokey_id,
        order_cost_dollars,
        order_total_dollars,
        user_id,
        address_id,
        tracking_id,
        status,
        shipping_service,
        shipping_cost_dollars,
        estimated_delivery_at_utc,
        delivered_at_utc,
        date_load
    FROM src_orders
)

SELECT * FROM stg_orders

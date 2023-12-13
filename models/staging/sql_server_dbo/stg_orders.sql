{{
  config(
    materialized='view'
  )
}}

WITH src_orders AS (
    SELECT
        cast (order_id as varchar) as order_id,
        cast (created_at as datetime) as created_at_utc,
        cast (order_cost as float) as order_cost_dollars,
        cast (order_total as float) as order_total_dollars,
        cast (user_id as varchar) as user_id,
        cast (address_id as varchar) as address_id,
        cast (tracking_id as varchar) as tracking_id,
        cast (status as varchar) as status,
        cast ((decode(shipping_service, '', 'unassigned', shipping_service)) as varchar) as shipping_service,
        cast (shipping_cost as float) as shipping_cost_dollars,
        cast (estimated_delivery_at as datetime) as estimated_delivery_at_utc,
        cast (delivered_at as datetime) as delivered_at_utc,
        _fivetran_synced AS date_load,
        cast(lower(decode(promo_id, '', '9999', promo_id)) as varchar) as promo_id
    FROM {{ source('sql_server_dbo', 'orders') }}
),

stg_orders AS (
    SELECT
        order_id,
        created_at_utc,
        {{ dbt_utils.generate_surrogate_key(['promo_id']) }} as promo_id,
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

{{
  config(
    materialized='table',
  )
}}

WITH
stg_shipping AS (
    SELECT
        order_id,
        address_id,
        status,
        shipping_service,
        estimated_delivery_at_utc,
        tracking_id,
        delivered_at_utc
    FROM {{ ref ('stg_orders') }}
)

SELECT * FROM stg_shipping

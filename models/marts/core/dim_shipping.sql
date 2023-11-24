{{
  config(
    materialized='table',
  )
}}
-- Intentar eliminar los duplicados de la tabla.
--WITH distinct_orders AS (
--    SELECT DISTINCT
--    order_id as sin_duplicar
--    FROM {{ ref('stg_orders') }}
--),
WITH
stg_shipping AS (
    SELECT
    order_id,
    shipping_service,
    address_id,
    estimated_delivery_at_utc,
    tracking_id,
    delivered_at_utc,
    status,
    date_load
    FROM {{ ref ('stg_orders')}}
--    JOIN distinct_orders ON distinct_orders.sin_duplicar = stg_shipping.order_id
)
-- ERROR
SELECT * FROM stg_shipping

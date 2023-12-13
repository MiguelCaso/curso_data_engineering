{{
  config(
    materialized='view'
  )
}}

WITH src_order_items AS (
    SELECT *
    FROM {{ source('sql_server_dbo', 'order_items') }}
),

stg_order_items AS (
    SELECT
        cast (order_id as varchar) as order_id,
        cast (product_id as varchar) as product_id,
        cast (quantity as number) as quantity,
        _fivetran_synced AS date_load
    FROM src_order_items
)

SELECT * FROM stg_order_items

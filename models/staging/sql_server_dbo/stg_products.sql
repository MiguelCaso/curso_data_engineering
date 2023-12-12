{{
  config(
    materialized='view'
  )
}}

WITH src_products AS (
    SELECT *
    FROM {{ source('sql_server_dbo', 'products') }}
),

stg_products AS (
    SELECT
        cast (product_id as varchar) as product_id,
        cast (name as varchar) as name,
        cast (price as number) as price,
        cast (inventory as number) as inventory,
        _fivetran_synced as date_load
    FROM src_products
)

SELECT * FROM stg_products

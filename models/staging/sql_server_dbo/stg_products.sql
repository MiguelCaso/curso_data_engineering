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
        cast(product_id AS varchar) AS product_id,
        cast(name AS varchar) AS name,
        cast(price AS float) AS price,
        cast(inventory AS number) AS inventory,
        _fivetran_synced AS date_load
    FROM src_products
)

SELECT * FROM stg_products

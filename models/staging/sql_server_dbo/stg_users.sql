{{
  config(
    materialized='view'
  )
}}

WITH src_users AS (
    SELECT *
    FROM {{ source('sql_server_dbo', 'users') }}
),

src_orders AS (
    SELECT
        count(order_id) as num_pedidos,
        user_id as orders_user_id
    FROM {{ source ('sql_server_dbo', 'orders') }}
    GROUP BY orders_user_id
),

stg_users AS (
    SELECT
        cast (user_id as varchar) as user_id,
        cast (address_id as varchar) as address_id,
        cast (first_name as varchar) as first_name,
        cast (last_name as varchar) as last_name,
        cast (REPLACE (phone_number, '-') as number) as phone_number,
        cast (email as varchar) as email,
        cast (created_at as datetime) as created_at_utc,
        cast (updated_at as datetime) as updated_at_utc,
        cast (num_pedidos as number) as total_orders,
        _fivetran_synced AS date_load
    FROM src_users
    INNER JOIN src_orders ON src_users.user_id = src_orders.orders_user_id
)

SELECT * FROM stg_users

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
        count(order_id) AS num_pedidos,
        user_id AS orders_user_id
    FROM {{ source ('sql_server_dbo', 'orders') }}
    GROUP BY orders_user_id
),

stg_users AS (
    SELECT
        user_id,
        address_id,
        first_name,
        last_name,
        phone_number,
        email,
        created_at,
        updated_at,
        num_pedidos AS total_orders,
        _fivetran_synced AS date_load
    FROM src_users
    INNER JOIN src_orders ON src_users.user_id = src_orders.orders_user_id
)

SELECT * FROM stg_users

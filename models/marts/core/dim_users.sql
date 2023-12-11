{{
  config(
    materialized='table',
  )
}}

WITH dim_users AS (
    SELECT 
        user_id,
        address_id,
        first_name,
        last_name,
        email,
        created_at,
        updated_at,
        total_orders,
        date_load
    FROM {{ ref('stg_users') }}
)

SELECT * FROM dim_users

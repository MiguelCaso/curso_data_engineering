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
        phone_number,
        email,
        created_at_utc,
        updated_at_utc,
        total_orders,
        date_load
    FROM {{ ref('stg_users') }}
)

SELECT * FROM dim_users

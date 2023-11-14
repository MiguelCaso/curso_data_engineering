
{{
  config(
    materialized='view'
  )
}}

WITH src_users AS (
    SELECT * 
    FROM {{ source('sql_server_dbo', 'users') }}
    ),

stg_users AS (
    SELECT
          user_id
        , address_id
        , first_name
        , last_name
        , phone_number
        , email
        , created_at
        , updated_at
        , total_orders
        , _fivetran_synced AS date_load
    FROM src_users
    )

SELECT * FROM stg_users
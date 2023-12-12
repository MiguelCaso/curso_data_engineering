{{
  config(
    materialized='view'
  )
}}

WITH src_events AS (
    SELECT *
    FROM {{ source('sql_server_dbo', 'events') }}
),

stg_events AS (
    SELECT
        cast (event_id as varchar) as event_id,
        cast (page_url as varchar) as page_url,
        cast (event_type as varchar) as event_type,
        cast (user_id as varchar) as user_id,
        cast (product_id as varchar) as product_id,
        cast (session_id as varchar) as session_id,
        cast (created_at as date) as created_at_date,
        cast (created_at as time) as created_at_time_utc,
        cast (order_id as varchar) as order_id,
        _fivetran_synced AS date_load
    FROM src_events
)

SELECT * FROM stg_events

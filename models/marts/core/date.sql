
{{
  config(
    materialized='table'
  )
}}

WITH orders_created_at AS (
    SELECT
        created_at 
    FROM {{ ref('sql_server_dbo', 'orders') }}
    ),

events_created_at AS (
    SELECT
          created_at
    FROM src_events
    ),



SELECT * FROM stg_events
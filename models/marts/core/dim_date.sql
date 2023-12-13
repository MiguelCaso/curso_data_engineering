{{
  config(
    materialized='table',
  )
}}

WITH dim_fechas AS (
    SELECT *
    FROM {{ ref('stg_dates') }}
)

SELECT * FROM dim_fechas

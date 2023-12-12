{{
  config(
    materialized='table',
  )
}}

WITH int_fechas AS (
    SELECT *
    FROM {{ ref('stg_dates') }}
)

SELECT * FROM int_fechas

{{
  config(
    materialized='table',
  )
}}

WITH int_fechas AS (
    SELECT
        fecha_forecast,
        id_date,
        anio,
        mes,
        desc_mes,
        id_anio_mes,
        desc_dia,
        dia_previo,
        anio_semana_dia,
        semana
    FROM {{ ref('stg_fechas') }}
)

SELECT * FROM int_fechas

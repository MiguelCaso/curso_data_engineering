{{
  config(
    materialized='table',
  )
}}

WITH stg_addresses AS (
    SELECT 
      fecha_forecast
    , id_date
    , anio
    , mes
    , desc_mes
    , id_anio_mes
    , as desc_dia
    , dia_previo
    , as anio_semana_dia
    , as semana
    FROM {{ ref('stg_fechas') }}
)

SELECT * FROM stg_fechas

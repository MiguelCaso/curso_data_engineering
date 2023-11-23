{{
  config(
    materialized='table',
  )
}}

WITH stg_addresses AS (
    SELECT 
        address_id,
        zipcode,
        country,
        address as street, -- Separar la calle
        address as number, -- Separar el numero
        state,
        date_load
    FROM {{ ref('stg_addresses') }}
)

SELECT * FROM stg_addresses

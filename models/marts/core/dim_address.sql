{{
  config(
    materialized='table',
  )
}}

WITH int_addresses AS (
    SELECT
        address_id,
        zipcode,
        country,
        address,
        state,
        date_load
    FROM {{ ref('stg_addresses') }}
)

SELECT * FROM int_addresses

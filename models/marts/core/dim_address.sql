{{
  config(
    materialized='table',
  )
}}

WITH dim_addresses AS (
    SELECT
        address_id,
        zipcode,
        country,
        address,
        state
    FROM {{ ref('stg_addresses') }}
)

SELECT * FROM dim_addresses

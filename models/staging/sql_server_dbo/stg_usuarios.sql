{{
  config(
    materialized='incremental',
    unique_key = 'user_id'
  )
}}

WITH src_users AS (
    SELECT
        user_id,
        first_name,
        last_name,
        address_id,
        _fivetran_synced AS f_carga,
        REPLACE(phone_number, '-') AS phone_number
    FROM {{ source('sql_server_dbo', 'users') }}
    {% if is_incremental() %}
        WHERE _fivetran_synced > (SELECT MAX(f_carga) FROM {{ this }})
    {% endif %}
),

stg_users AS (
    SELECT
        user_id,
        first_name,
        last_name,
        address_id,
        f_carga,
        CAST(phone_number AS number) AS phone_number
    FROM src_users
)

SELECT * FROM stg_users

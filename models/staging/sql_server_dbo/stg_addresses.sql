{{ config(materialized="view") }}

with
src_addresses as (
    select *
    from {{ source("sql_server_dbo", "addresses") }}
),

stg_addresses as (
    select
        cast(address_id as varchar) as address_id,
        cast(zipcode as number) as zipcode,
        cast(country as varchar) as country,
        cast(address as varchar) as address,
        cast(state as varchar) as state,
        _fivetran_synced as date_load
    from src_addresses
)

select *
from stg_addresses

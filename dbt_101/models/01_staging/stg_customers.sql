{{ config(materialized='view') }}

with source as (
    select * from {{ source('grocery_store', 'customers') }}
),

renamed as (
    select
        id as customer_id,
        first_name,
        last_name,
        email,
        gender,
        date_of_birth::date as date_of_birth
    from source
)

select * from renamed

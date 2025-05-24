{{ config(materialized='view') }}

with source as (
    select * from {{ source('grocery_store', 'orders') }}
),

renamed as (
    select
        id as order_id,
        date::date as order_date,
        customer_id,
        status
    from source
)

select * from renamed

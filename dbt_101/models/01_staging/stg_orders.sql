{{ config(materialized='view') }}

with source as (
    select * from {{ source('grocery_store', 'orders') }}
),

renamed as (
    select
        "ID" as order_id,
        "DATE"::date as order_date,
        "CUSTOMER_ID" as customer_id,
        "STATUS" as status
    from source
)

select * from renamed

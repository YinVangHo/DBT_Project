{{ config(materialized='view') }}

with source as (
    select * from {{ source('grocery_store', 'order_items') }}
),

renamed as (
    select
        order_id,
        order_item_id,
        product_id,
        quantity
    from source
)

select * from renamed

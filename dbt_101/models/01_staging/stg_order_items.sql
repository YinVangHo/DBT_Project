{{ config(materialized='view') }}

with source as (
    select * from {{ source('grocery_store', 'order_items') }}
),

renamed as (
    select
        "ORDER_ID" as order_id,
        "ORDER_ITEM_ID" as order_item_id,
        "PRODUCT_ID" as product_id,
        "QUANTITY" as quantity
    from source
)

select * from renamed

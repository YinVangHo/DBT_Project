{{ config(materialized='view') }}

with source as (
    select * from {{ source('grocery_store', 'products') }}
),

renamed as (
    select
        "ID" as product_id,
        "NAME" as product_name,
        "PRICE"::float as price,
        "CATEGORY" as category
    from source
)

select * from renamed

{{ config(materialized='view') }}

with source as (
    select * from {{ source('grocery_store', 'products') }}
),

renamed as (
    select
        id as product_id,
        name as product_name,
        price::float as price,
        category
    from source
)

select * from renamed

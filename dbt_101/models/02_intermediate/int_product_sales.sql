{{ config(materialized='table') }}

with order_items as (
    select
        order_id,
        product_id,
        quantity
    from {{ ref('stg_order_items') }}
),

products as (
    select
        product_id,
        product_name,
        price,
        category
    from {{ ref('stg_products') }}
),

joined as (
    select
        oi.product_id,
        p.product_name,
        p.category,
        sum(oi.quantity) as total_quantity_sold,
        sum(oi.quantity * p.price) as total_sales_usd
    from order_items as oi
    inner join products as p on oi.product_id = p.product_id
    group by 1, 2, 3
)

select * from joined

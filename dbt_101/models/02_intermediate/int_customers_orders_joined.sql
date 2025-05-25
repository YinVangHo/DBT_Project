{{ config(materialized='table') }}

with customers as (
    select
        customer_id,
        first_name || ' ' || last_name as full_name
    from {{ ref('stg_customers') }}
),

orders as (
    select
        order_id,
        customer_id,
        order_date
    from {{ ref('stg_orders') }}
    where status != 'cancelled'
),

order_items as (
    select
        order_id,
        product_id,
        quantity
    from {{ ref('stg_order_items') }}
),

products as (
    select
        product_id,
        price
    from {{ ref('stg_products') }}
),

order_details as (
    select
        oi.order_id,
        o.customer_id,
        o.order_date,
        oi.quantity * p.price as amount_spent
    from order_items as oi
    inner join orders as o on oi.order_id = o.order_id
    inner join products as p on oi.product_id = p.product_id
),

customer_summary as (
    select
        c.customer_id,
        c.full_name,
        count(distinct od.order_id) as number_of_orders,
        sum(od.amount_spent) as total_amount_spent_usd,
        min(od.order_date) as first_order_date,
        max(od.order_date) as last_order_date
    from customers as c
    inner join order_details as od on c.customer_id = od.customer_id
    group by 1, 2
)

select * from customer_summary

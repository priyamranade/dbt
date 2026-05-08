with sales as 
(
    select
    sales_id,
    product_sk,
    customer_sk,
    gross_amount,
    payment_method
    from 
    {{ ref('bronze_sales') }}
),

products as 
(
    select 
    product_sk,
    category
    from 
    {{ ref('bronze_product') }}

),

customer as (
    select 
    gender,
    customer_sk
    from 
    {{ ref('bronze_customer') }}
)

, joined_query as (
select 
    sales.sales_id,
    sales.gross_amount,
    sales.payment_method,
    products.category,
    customer.gender
from 
    sales   
join 
    products on sales.product_sk = products.product_sk
join 
    customer on sales.customer_sk = customer.customer_sk
)


select 
category,
gender,
sum(gross_amount) as sales_total 
from joined_query
group by 1,2
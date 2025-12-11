create database ecommerce;
use ecommerce;
select * from olist_geolocation_dataset;
select * from olist_order_reviews_dataset;

-- KPI 1---------------------------------------------
select 
case
when  dayofweek(a.order_purchase_timestamp) in (1,7) then 'Weekend'
else 'Weekday' end as Week_Type, sum(b.payment_value) AS Payment_Value
 from olist_orders_dataset a
 inner join olist_order_payments_dataset b on
 a.order_id = b.order_id
 group by Week_Type;
 
 -- KPI 2 --------------------------------------------------------------------------------------------
 select a.review_score, count(c.order_id) as Total_Orders
from olist_order_reviews_dataset a
join olist_order_payments_dataset b on
a.order_id = b.order_id
join olist_orders_dataset c on a.order_id = c.order_id
where payment_type = 'credit_card' and review_score = 5
group by review_score;

-- KPI 3---------------------------------------------------------------------------------------------------------------
select c.product_category_name, avg(datediff(a.order_delivered_customer_date,a.order_purchase_timestamp)) as Average_Days_Taken
from olist_orders_dataset a
join olist_order_items_dataset b on a.order_id = b.order_id
join olist_products_dataset c on b.product_id = c.product_id
where c.product_category_name = 'pet_shop';
 
 
 -- KPI 4 ------------------------------------------------------------------------------------------------------
 select d.customer_city, avg(b.payment_value) as Average_Payment_Value,
avg(a.price) as Average_Price_Value
from olist_order_items_dataset a
join olist_order_payments_dataset b on a.order_id = b.order_id
join olist_orders_dataset c on a.order_id = c.order_id
join olist_customers_dataset d on c.customer_id = d.customer_id
where d.customer_city = 'sao paulo';

-- KPI 5 -----------------------------------------------------------------------------------------------------------------
select a.review_score, avg(datediff(b.order_delivered_customer_date,b.order_purchase_timestamp)) as Shipping_Days
from olist_order_reviews_dataset a
join olist_orders_dataset b on a.order_id = b.order_id
group by a.review_score
order by a.review_score asc;
 

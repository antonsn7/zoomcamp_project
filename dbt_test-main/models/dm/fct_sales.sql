{{ config(materialized='table') }}

WITH order_items_data AS (
  SELECT order_id,
         product_id,
         price,
         freight_value
  FROM {{ ref('stg_order_items') }}
),
products AS (
    SELECT product_id,
           product_category_name
    FROM {{ ref('stg_products') }}
),
products_translation AS (
    SELECT product_category_name,
           product_category_name_english
    FROM {{ ref('stg_product_category_name_translation') }}
),
orders AS (
    SELECT order_id,
           customer_id,
           order_delivered_customer_date
      FROM {{ ref('stg_orders') }}
),
customers AS (
    SELECT customer_id, 
           customer_city,
           customer_state
      FROM {{ ref('stg_customers') }}
), fct_sales AS (
    SELECT ordit.order_id AS order_id,
            ordit.price AS price,
            ordit.freight_value AS "freight value",
            TRUNC(ord.order_delivered_customer_date) AS "order date",
            cust.customer_city AS "customer city",
            prodtransl.product_category_name_english AS "product category"
      FROM order_items_data ordit
INNER JOIN products prod
        ON prod.product_id = ordit.product_id
INNER JOIN products_translation prodtransl
        ON prodtransl.product_category_name = prod.product_category_name
INNER JOIN orders ord
        ON ord.order_id = ordit.order_id
INNER JOIN customers cust
        ON cust.customer_id = ord.customer_id      
)
SELECT *
  FROM fct_sales
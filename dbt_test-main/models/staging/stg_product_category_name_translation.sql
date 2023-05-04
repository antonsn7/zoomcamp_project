{{ config(materialized='table') }}

SELECT product_category_name,
       REPLACE(product_category_name_english, '_', ' ') AS product_category_name_english
FROM {{ source('ext_schema', 'product_category_name_translation') }}
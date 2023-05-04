{{ config(materialized='table') }}

SELECT customer_id,
       customer_unique_id,
       customer_zip_code_prefix,
       INITCAP(customer_city) AS customer_city,
       customer_state
  FROM {{ source('ext_schema', 'customers') }}
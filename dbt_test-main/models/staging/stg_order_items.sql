{{ config(materialized='table') }}

SELECT *
FROM {{ source('ext_schema', 'order_items') }}
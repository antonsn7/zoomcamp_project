{{ config(materialized='table') }}

SELECT *
  FROM {{ source('ext_schema', 'geolocation') }}
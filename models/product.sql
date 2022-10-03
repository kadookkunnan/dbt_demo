{{ config(materialized='table') }}

with transform_product as (
SELECT
  CAST(P.product_id AS INT64) AS product_id 
  ,P.product_name  
  ,P.product_category  
  ,P.product_sub_category    
  ,P.brand        
  ,CAST(P.sale_price AS FLOAT64) AS sale_price
  ,CAST(P.market_price AS FLOAT64) AS market_price   
  ,P.product_type
  ,CAST(P.product_rating AS FLOAT64) AS product_rating
  ,P.product_description
  ,(10.0) as tax_percentage
  ,I.image_url AS product_image
  ,current_datetime as created_datetime
  ,current_datetime as updated_datetime
  ,TRUE as is_active
FROM `thriftshop_staging.product-staging-prep` P
INNER JOIN `thriftshop_staging.product-images-by-subcategory` I
  ON P.product_sub_category = I.product_sub_category
)

select *
from transform_product

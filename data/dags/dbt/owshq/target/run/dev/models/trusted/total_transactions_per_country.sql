
  
    

    create table "iceberg"."landing"."total_transactions_per_country__dbt_tmp"
      
      
    as (
      

WITH transactions AS (

    SELECT
        *
    FROM
        "iceberg"."landing"."ride_transactions"
)
SELECT
    trx.payment_country AS country,
    SUM(
        trx.payment_price
    ) AS total_price,
    COUNT(
        trx.payment_price
    ) AS total_rides
FROM
    transactions AS trx
WHERE
    trx.payment_country IS NOT NULL
GROUP BY
    trx.payment_country
    );

  
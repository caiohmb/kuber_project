
  create or replace view
    "iceberg"."landing"."users"
  security definer
  as
    

WITH mssql_users AS (

    SELECT
        *,
        ROW_NUMBER() over (
            ORDER BY
                last_updated
        ) AS rwn_id
    FROM
        "iceberg"."landing"."mssql_users"
),
mongodb_users AS (
    SELECT
        *,
        ROW_NUMBER() over (
            ORDER BY
                last_updated
        ) AS rwn_id
    FROM
        "iceberg"."landing"."mongodb_users"
)
SELECT
    DISTINCT mssql.rwn_id AS user_id,
    mssql.cpf AS cpf,
    mssql.full_name AS full_name,
    mssql.date_of_birth AS date_of_birth,
    mssql.city AS city,
    mssql.country AS country
FROM
    mssql_users AS mssql
    INNER JOIN mongodb_users AS mongodb
    ON mssql.user_id = mongodb.user_id
  ;

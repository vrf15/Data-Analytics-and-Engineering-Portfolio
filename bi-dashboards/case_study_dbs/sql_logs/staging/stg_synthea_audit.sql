-- 1) Row count check
SELECT COUNT(*) AS raw_row_count
FROM raw_portfolio.raw_synthea_<table>;

SELECT COUNT(*) AS stg_row_count
FROM stg_portfolio.stg_synthea_<table>;

-- 2) Sample rows
SELECT *
FROM stg_portfolio.stg_synthea_<table>
LIMIT 10;

-- 3) Null check on main key
SELECT COUNT(*) AS null_key_rows
FROM stg_portfolio.stg_synthea_<table>
WHERE <main_id_column> IS NULL;

-- 4) Duplicate check on main key
SELECT
    <main_id_column>,
    COUNT(*) AS row_count
FROM stg_portfolio.stg_synthea_<table>
GROUP BY <main_id_column>
HAVING COUNT(*) > 1
ORDER BY row_count DESC;

-- 5) Nulls in important columns
SELECT COUNT(*) AS null_important_rows
FROM stg_portfolio.stg_synthea_<table>
WHERE <important_column_1> IS NULL
   OR <important_column_2> IS NULL;

-- 6) Date logic check
SELECT *
FROM stg_portfolio.stg_synthea_<table>
WHERE <end_date_column> < <start_date_column>;

-- 7) Distinct value skim
SELECT
    <category_column>,
    COUNT(*) AS row_count
FROM stg_portfolio.stg_synthea_<table>
GROUP BY <category_column>
ORDER BY row_count DESC;
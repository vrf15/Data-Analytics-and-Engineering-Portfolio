-- 1) Row count
SELECT COUNT(*) AS raw_row_count
FROM raw_portfolio.raw_synthea_<table>;

-- 2) Sample rows
SELECT *
FROM raw_portfolio.raw_synthea_<table>
LIMIT 10;

-- 3) Column types
SELECT
    column_name,
    data_type
FROM information_schema.columns
WHERE table_schema = 'raw_portfolio'
  AND table_name = 'raw_synthea_<table>'
ORDER BY ordinal_position;

-- 4) Null check on likely key
SELECT COUNT(*) AS null_key_rows
FROM raw_portfolio.raw_synthea_<table>
WHERE <raw_key_column> IS NULL;

-- 5) Blank-string check for text columns
SELECT COUNT(*) AS blank_rows
FROM raw_portfolio.raw_synthea_<table>
WHERE TRIM(<raw_text_column>) = '';

-- 6) Duplicate skim
SELECT
    <raw_key_column>,
    COUNT(*) AS row_count
FROM raw_portfolio.raw_synthea_<table>
GROUP BY <raw_key_column>
HAVING COUNT(*) > 1
ORDER BY row_count DESC;

-- 7) Quick distinct skim
SELECT
    <raw_category_column>,
    COUNT(*) AS row_count
FROM raw_portfolio.raw_synthea_<table>
GROUP BY <raw_category_column>
ORDER BY row_count DESC;
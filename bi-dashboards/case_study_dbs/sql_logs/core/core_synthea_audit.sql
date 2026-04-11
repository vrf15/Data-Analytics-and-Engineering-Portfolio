-- GENERAL AUDITS I USE

-- 1) Row count check
SELECT COUNT(*) AS intermediate_row_count
FROM core_portfolio.int_synthea_<table>_validated;

-- 2) Sample rows
SELECT *
FROM core_portfolio.int_synthea_<table>_validated
LIMIT 10;

-- 3) Null check on main key
SELECT COUNT(*) AS null_key_rows
FROM core_portfolio.int_synthea_<table>_validated
WHERE <main_id_column> IS NULL;

-- 4) Invalid vs valid row count
SELECT
    is_valid_record,
    COUNT(*) AS row_count
FROM core_portfolio.int_synthea_<table>_validated
GROUP BY is_valid_record
ORDER BY is_valid_record;

-- 5) Duplicate check on main key
SELECT
    <main_id_column>,
    COUNT(*) AS row_count
FROM core_portfolio.int_synthea_<table>_validated
GROUP BY <main_id_column>
HAVING COUNT(*) > 1
ORDER BY row_count DESC;

-- 6) Flag volume check
SELECT COUNT(*) AS flagged_row_count
FROM core_portfolio.int_synthea_<table>_validated
WHERE is_valid_record = false;

-- 7) Specific flag check
SELECT COUNT(*) AS flagged_row_count
FROM core_portfolio.int_synthea_<table>_validated
WHERE <flag_column> = true;

-- 8) Multi-flag concentration check
SELECT COUNT(*) AS multi_flag_rows
FROM core_portfolio.int_synthea_<table>_validated
WHERE
    COALESCE(<flag_column_1>::int, 0)
  + COALESCE(<flag_column_2>::int, 0)
  + COALESCE(<flag_column_3>::int, 0) > 1;

-- 9) Review invalid rows
SELECT *
FROM core_portfolio.int_synthea_<table>_validated
WHERE is_valid_record = false
LIMIT 50;

--NICHE AUDIT BELOW

-- 10) Review rows for one specific issue
SELECT *
FROM core_portfolio.int_synthea_<table>_validated
WHERE <flag_column> = true
LIMIT 50;

-- 11) Distinct skim on business category
SELECT
    <category_column>,
    COUNT(*) AS row_count
FROM core_portfolio.int_synthea_<table>_validated
GROUP BY <category_column>
ORDER BY row_count DESC;

-- 12) Date logic check
SELECT *
FROM core_portfolio.int_synthea_<table>_validated
WHERE <end_date_column> < <start_date_column>;

-- 13) Parent join failure skim
SELECT *
FROM core_portfolio.int_synthea_<table>_validated
WHERE <missing_parent_flag_column> = true
LIMIT 50;

-- 14) Validation rate
SELECT
    COUNT(*) AS total_rows,
    SUM(CASE WHEN is_valid_record = true THEN 1 ELSE 0 END) AS valid_rows,
    SUM(CASE WHEN is_valid_record = false THEN 1 ELSE 0 END) AS invalid_rows,
    ROUND(
        100.0 * SUM(CASE WHEN is_valid_record = true THEN 1 ELSE 0 END) / NULLIF(COUNT(*), 0),
        2
    ) AS valid_row_pct
FROM core_portfolio.int_synthea_<table>_validated;

-- 15) Compare staging to intermediate row count
SELECT COUNT(*) AS stg_row_count
FROM stg_portfolio.stg_synthea_<table>;

SELECT COUNT(*) AS intermediate_row_count
FROM core_portfolio.int_synthea_<table>_validated;
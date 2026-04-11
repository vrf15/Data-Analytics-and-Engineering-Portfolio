--
CREATE TABLE core_portfolio.core_synthea_dim_organizations AS
SELECT
    organization_id,
    organization_name,
    address,
    city,
    state,
    zip,
    latitude,
    longitude,
    phone,
    revenue,
    utilization
FROM core_portfolio.int_synthea_organizations_validated
WHERE is_valid_record = true;

--
CREATE TABLE core_portfolio.core_synthea_dim_providers AS
SELECT
    provider_id,
    organization_id,
    provider_name,
    provider_gender,
    provider_speciality,
    address,
    city,
    state,
    zip,
    latitude,
    longitude,
    utilization
FROM core_portfolio.int_synthea_providers_validated
WHERE is_valid_record = true;

--
CREATE TABLE core_portfolio.core_synthea_dim_payers AS
SELECT DISTINCT
    payer_id,
    payer_name,
    address,
    city,
    state_headquartered,
    zip,
    phone,
    amount_covered,
    amount_uncovered,
    revenue,
    covered_encounters,
    uncovered_encounters,
    covered_medications,
    uncovered_medications,
    covered_procedures,
    uncovered_procedures,
    covered_immunizations,
    uncovered_immunizations,
    unique_customers,
    qols_avg,
    member_months
FROM core_portfolio.int_synthea_payers_validated
WHERE is_valid_record = true;

--
CREATE TABLE core_portfolio.core_synthea_dim_patients AS
SELECT
    patient_id,
    birth_date,
    death_date,
    prefix,
    first_name,
    last_name,
    suffix,
    maiden_name,
    marital_status,
    race,
    ethnicity,
    gender,
    birthplace,
    address,
    city,
    state,
    county,
    zip,
    latitude,
    longitude
FROM core_portfolio.int_synthea_patients_validated
WHERE is_valid_record = true;

--
CREATE TABLE core_portfolio.core_synthea_dim_date AS
WITH date_bounds AS (
    SELECT
        MIN(dt) AS min_date,
        MAX(dt) AS max_date
    FROM (
        SELECT encounter_start_date AS dt
        FROM core_portfolio.core_synthea_fact_encounters
        WHERE encounter_start_date IS NOT NULL

        UNION ALL

        SELECT encounter_end_date AS dt
        FROM core_portfolio.core_synthea_fact_encounters
        WHERE encounter_end_date IS NOT NULL

        UNION ALL

        SELECT condition_start_date AS dt
        FROM core_portfolio.core_synthea_fact_conditions
        WHERE condition_start_date IS NOT NULL

        UNION ALL

        SELECT condition_end_date AS dt
        FROM core_portfolio.core_synthea_fact_conditions
        WHERE condition_end_date IS NOT NULL

        UNION ALL

        SELECT medication_start_date AS dt
        FROM core_portfolio.core_synthea_fact_medications
        WHERE medication_start_date IS NOT NULL

        UNION ALL

        SELECT medication_end_date AS dt
        FROM core_portfolio.core_synthea_fact_medications
        WHERE medication_end_date IS NOT NULL

        UNION ALL

        SELECT observation_date AS dt
        FROM core_portfolio.core_synthea_fact_observations
        WHERE observation_date IS NOT NULL

        UNION ALL

        SELECT procedure_date AS dt
        FROM core_portfolio.core_synthea_fact_procedures
        WHERE procedure_date IS NOT NULL
    ) all_dates
)
SELECT
    d::date AS date_key,
    EXTRACT(YEAR FROM d)::integer AS year,
    EXTRACT(QUARTER FROM d)::integer AS quarter,
    'Q' || EXTRACT(QUARTER FROM d)::integer AS quarter_label,
    EXTRACT(MONTH FROM d)::integer AS month_number,
    TRIM(TO_CHAR(d, 'Month')) AS month_name,
    TO_CHAR(d, 'Mon') AS month_short,
    EXTRACT(DAY FROM d)::integer AS day_of_month,
    EXTRACT(ISODOW FROM d)::integer AS day_of_week_number,
    TRIM(TO_CHAR(d, 'Day')) AS day_of_week_name,
    EXTRACT(WEEK FROM d)::integer AS week_of_year,
    CASE
        WHEN EXTRACT(ISODOW FROM d) IN (6, 7) THEN true
        ELSE false
    END AS is_weekend
FROM date_bounds,
generate_series(
    min_date,
    max_date,
    '1 day'::interval
) d;
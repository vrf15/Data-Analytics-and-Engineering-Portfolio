-- Move to FACT
CREATE TABLE core_portfolio.int_synthea_patients_validated AS
SELECT
    p.patient_id,
    p.birth_date,
    p.death_date,
    p.ssn,
    p.drivers_license,
    p.passport,
    p.prefix,
    p.first_name,
    p.last_name,
    p.suffix,
    p.maiden_name,
    p.marital_status,
    p.race,
    p.ethnicity,
    p.gender,
    p.birthplace,
    p.address,
    p.city,
    p.state,
    p.county,
    p.zip,
    p.latitude,
    p.longitude,
    p.healthcare_expenses,
    p.healthcare_coverage,

    CASE WHEN p.patient_id IS NULL THEN true ELSE false END AS has_null_patient_id,
    CASE
        WHEN p.death_date IS NOT NULL
         AND p.birth_date IS NOT NULL
         AND p.death_date < p.birth_date
        THEN true ELSE false
    END AS has_bad_date_logic,

    CASE
        WHEN p.patient_id IS NULL
          OR (
                p.death_date IS NOT NULL
            AND p.birth_date IS NOT NULL
            AND p.death_date < p.birth_date
          )
        THEN false
        ELSE true
    END AS is_valid_record
FROM stg_portfolio.stg_synthea_patients p;

--
CREATE TABLE core_portfolio.int_synthea_organizations_validated AS
SELECT
    o.organization_id,
    o.organization_name,
    o.address,
    o.city,
    o.state,
    o.zip,
    o.latitude,
    o.longitude,
    o.phone,
    o.revenue,
    o.utilization,

    CASE WHEN o.organization_id IS NULL THEN true ELSE false END AS has_null_organization_id,

    CASE
        WHEN o.organization_id IS NULL
        THEN false
        ELSE true
    END AS is_valid_record
FROM stg_portfolio.stg_synthea_organizations o;

--
CREATE TABLE core_portfolio.int_synthea_providers_validated AS
SELECT
    pr.provider_id,
    pr.organization_id,
    pr.provider_name,
    pr.provider_gender,
    pr.provider_speciality,
    pr.address,
    pr.city,
    pr.state,
    pr.zip,
    pr.latitude,
    pr.longitude,
    pr.utilization,

    CASE WHEN pr.provider_id IS NULL THEN true ELSE false END AS has_null_provider_id,
    CASE WHEN pr.organization_id IS NULL THEN true ELSE false END AS has_null_organization_id,
    CASE
        WHEN pr.organization_id IS NOT NULL
         AND o.organization_id IS NULL
        THEN true ELSE false
    END AS has_missing_organization,

    CASE
        WHEN pr.provider_id IS NULL
          OR pr.organization_id IS NULL
          OR (
                pr.organization_id IS NOT NULL
            AND o.organization_id IS NULL
          )
        THEN false
        ELSE true
    END AS is_valid_record
FROM stg_portfolio.stg_synthea_providers pr
LEFT JOIN stg_portfolio.stg_synthea_organizations o
    ON pr.organization_id = o.organization_id;

--
CREATE TABLE core_portfolio.int_synthea_payers_validated AS
SELECT
    py.payer_id,
    py.payer_name,
    py.address,
    py.city,
    py.state_headquartered,
    py.zip,
    py.phone,
    py.amount_covered,
    py.amount_uncovered,
    py.revenue,
    py.covered_encounters,
    py.uncovered_encounters,
    py.covered_medications,
    py.uncovered_medications,
    py.covered_procedures,
    py.uncovered_procedures,
    py.covered_immunizations,
    py.uncovered_immunizations,
    py.unique_customers,
    py.qols_avg,
    py.member_months,

    CASE WHEN py.payer_id IS NULL THEN true ELSE false END AS has_null_payer_id,

    CASE
        WHEN py.payer_id IS NULL
        THEN false
        ELSE true
    END AS is_valid_record
FROM stg_portfolio.stg_synthea_payers py;

--
CREATE TABLE core_portfolio.int_synthea_payer_transitions_validated AS
SELECT
    pt.patient_id,
    pt.start_year,
    pt.end_year,
    pt.payer_id,
    pt.ownership,

    CASE WHEN pt.patient_id IS NULL THEN true ELSE false END AS has_null_patient_id,
    CASE WHEN pt.payer_id IS NULL THEN true ELSE false END AS has_null_payer_id,
    CASE
        WHEN pt.end_year IS NOT NULL
         AND pt.start_year IS NOT NULL
         AND pt.end_year < pt.start_year
        THEN true ELSE false
    END AS has_bad_year_logic,
    CASE
        WHEN pt.patient_id IS NOT NULL
         AND p.patient_id IS NULL
        THEN true ELSE false
    END AS has_missing_patient,
    CASE
        WHEN pt.payer_id IS NOT NULL
         AND py.payer_id IS NULL
        THEN true ELSE false
    END AS has_missing_payer,

    CASE
        WHEN pt.patient_id IS NULL
          OR pt.payer_id IS NULL
          OR (
                pt.end_year IS NOT NULL
            AND pt.start_year IS NOT NULL
            AND pt.end_year < pt.start_year
          )
          OR (
                pt.patient_id IS NOT NULL
            AND p.patient_id IS NULL
          )
          OR (
                pt.payer_id IS NOT NULL
            AND py.payer_id IS NULL
          )
        THEN false
        ELSE true
    END AS is_valid_record
FROM stg_portfolio.stg_synthea_payer_transitions pt
LEFT JOIN stg_portfolio.stg_synthea_patients p
    ON pt.patient_id = p.patient_id
LEFT JOIN stg_portfolio.stg_synthea_payers py
    ON pt.payer_id = py.payer_id;
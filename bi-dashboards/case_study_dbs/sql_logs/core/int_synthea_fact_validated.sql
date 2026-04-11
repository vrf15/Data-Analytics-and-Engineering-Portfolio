--
CREATE TABLE core_portfolio.int_synthea_encounters_validated AS
SELECT
    e.encounter_id,
    e.encounter_start_date,
    e.encounter_end_date,
    e.patient_id,
    e.organization_id,
    e.provider_id,
    e.payer_id,
    e.encounter_class,
    e.encounter_code,
    e.encounter_description,
    e.base_encounter_cost,
    e.total_claim_cost,
    e.payer_coverage,
    e.reason_code,
    e.reason_description,

    CASE WHEN e.encounter_id IS NULL THEN true ELSE false END AS has_null_encounter_id,
    CASE WHEN e.patient_id IS NULL THEN true ELSE false END AS has_null_patient_id,
    CASE WHEN e.encounter_end_date IS NOT NULL AND e.encounter_start_date IS NOT NULL AND e.encounter_end_date < e.encounter_start_date THEN true ELSE false END AS has_bad_date_logic,
    CASE WHEN e.patient_id IS NOT NULL AND p.patient_id IS NULL THEN true ELSE false END AS has_missing_patient,
    CASE WHEN e.organization_id IS NOT NULL AND o.organization_id IS NULL THEN true ELSE false END AS has_missing_organization,
    CASE WHEN e.provider_id IS NOT NULL AND pr.provider_id IS NULL THEN true ELSE false END AS has_missing_provider,
    CASE WHEN e.payer_id IS NOT NULL AND py.payer_id IS NULL THEN true ELSE false END AS has_missing_payer,

    CASE
        WHEN e.encounter_id IS NULL
          OR e.patient_id IS NULL
          OR (e.encounter_end_date IS NOT NULL AND e.encounter_start_date IS NOT NULL AND e.encounter_end_date < e.encounter_start_date)
          OR (e.patient_id IS NOT NULL AND p.patient_id IS NULL)
          OR (e.organization_id IS NOT NULL AND o.organization_id IS NULL)
          OR (e.provider_id IS NOT NULL AND pr.provider_id IS NULL)
          OR (e.payer_id IS NOT NULL AND py.payer_id IS NULL)
        THEN false
        ELSE true
    END AS is_valid_record
FROM stg_portfolio.stg_synthea_encounters e
LEFT JOIN stg_portfolio.stg_synthea_patients p
    ON e.patient_id = p.patient_id
LEFT JOIN stg_portfolio.stg_synthea_organizations o
    ON e.organization_id = o.organization_id
LEFT JOIN stg_portfolio.stg_synthea_providers pr
    ON e.provider_id = pr.provider_id
LEFT JOIN stg_portfolio.stg_synthea_payers py
    ON e.payer_id = py.payer_id;

--
CREATE TABLE core_portfolio.int_synthea_conditions_validated AS
SELECT
    c.condition_start_date,
    c.condition_end_date,
    c.patient_id,
    c.encounter_id,
    c.condition_code,
    c.condition_description,

    CASE WHEN c.patient_id IS NULL THEN true ELSE false END AS has_null_patient_id,
    CASE WHEN c.encounter_id IS NULL THEN true ELSE false END AS has_null_encounter_id,
    CASE WHEN c.condition_end_date IS NOT NULL AND c.condition_start_date IS NOT NULL AND c.condition_end_date < c.condition_start_date THEN true ELSE false END AS has_bad_date_logic,
    CASE WHEN c.patient_id IS NOT NULL AND p.patient_id IS NULL THEN true ELSE false END AS has_missing_patient,
    CASE WHEN c.encounter_id IS NOT NULL AND e.encounter_id IS NULL THEN true ELSE false END AS has_missing_encounter,

    CASE
        WHEN c.patient_id IS NULL
          OR c.encounter_id IS NULL
          OR (c.condition_end_date IS NOT NULL AND c.condition_start_date IS NOT NULL AND c.condition_end_date < c.condition_start_date)
          OR (c.patient_id IS NOT NULL AND p.patient_id IS NULL)
          OR (c.encounter_id IS NOT NULL AND e.encounter_id IS NULL)
        THEN false
        ELSE true
    END AS is_valid_record
FROM stg_portfolio.stg_synthea_conditions c
LEFT JOIN stg_portfolio.stg_synthea_patients p
    ON c.patient_id = p.patient_id
LEFT JOIN stg_portfolio.stg_synthea_encounters e
    ON c.encounter_id = e.encounter_id;

--
CREATE TABLE core_portfolio.int_synthea_procedures_validated AS
SELECT
    pr.procedure_date,
    pr.patient_id,
    pr.encounter_id,
    pr.procedure_code,
    pr.procedure_description,
    pr.base_cost,
    pr.reason_code,
    pr.reason_description,

    CASE WHEN pr.patient_id IS NULL THEN true ELSE false END AS has_null_patient_id,
    CASE WHEN pr.encounter_id IS NULL THEN true ELSE false END AS has_null_encounter_id,
    CASE WHEN pr.patient_id IS NOT NULL AND p.patient_id IS NULL THEN true ELSE false END AS has_missing_patient,
    CASE WHEN pr.encounter_id IS NOT NULL AND e.encounter_id IS NULL THEN true ELSE false END AS has_missing_encounter,

    CASE
        WHEN pr.patient_id IS NULL
          OR pr.encounter_id IS NULL
          OR (pr.patient_id IS NOT NULL AND p.patient_id IS NULL)
          OR (pr.encounter_id IS NOT NULL AND e.encounter_id IS NULL)
        THEN false
        ELSE true
    END AS is_valid_record
FROM stg_portfolio.stg_synthea_procedures pr
LEFT JOIN stg_portfolio.stg_synthea_patients p
    ON pr.patient_id = p.patient_id
LEFT JOIN stg_portfolio.stg_synthea_encounters e
    ON pr.encounter_id = e.encounter_id;

--
CREATE TABLE core_portfolio.int_synthea_medications_validated AS
SELECT
    m.medication_start_date,
    m.medication_end_date,
    m.patient_id,
    m.payer_id,
    m.encounter_id,
    m.medication_code,
    m.medication_description,
    m.base_cost,
    m.payer_coverage,
    m.dispenses,
    m.total_cost,
    m.reason_code,
    m.reason_description,

    CASE WHEN m.patient_id IS NULL THEN true ELSE false END AS has_null_patient_id,
    CASE WHEN m.encounter_id IS NULL THEN true ELSE false END AS has_null_encounter_id,
    CASE WHEN m.medication_end_date IS NOT NULL AND m.medication_start_date IS NOT NULL AND m.medication_end_date < m.medication_start_date THEN true ELSE false END AS has_bad_date_logic,
    CASE WHEN m.patient_id IS NOT NULL AND p.patient_id IS NULL THEN true ELSE false END AS has_missing_patient,
    CASE WHEN m.encounter_id IS NOT NULL AND e.encounter_id IS NULL THEN true ELSE false END AS has_missing_encounter,
    CASE WHEN m.payer_id IS NOT NULL AND py.payer_id IS NULL THEN true ELSE false END AS has_missing_payer,

    CASE
        WHEN m.patient_id IS NULL
          OR m.encounter_id IS NULL
          OR (m.medication_end_date IS NOT NULL AND m.medication_start_date IS NOT NULL AND m.medication_end_date < m.medication_start_date)
          OR (m.patient_id IS NOT NULL AND p.patient_id IS NULL)
          OR (m.encounter_id IS NOT NULL AND e.encounter_id IS NULL)
          OR (m.payer_id IS NOT NULL AND py.payer_id IS NULL)
        THEN false
        ELSE true
    END AS is_valid_record
FROM stg_portfolio.stg_synthea_medications m
LEFT JOIN stg_portfolio.stg_synthea_patients p
    ON m.patient_id = p.patient_id
LEFT JOIN stg_portfolio.stg_synthea_encounters e
    ON m.encounter_id = e.encounter_id
LEFT JOIN stg_portfolio.stg_synthea_payers py
    ON m.payer_id = py.payer_id;

--
CREATE TABLE core_portfolio.int_synthea_observations_validated AS
SELECT
    o.observation_date,
    o.patient_id,
    o.encounter_id,
    o.observation_code,
    o.observation_description,
    o.observation_value,
    o.observation_units,
    o.observation_type,

    CASE WHEN o.patient_id IS NULL THEN true ELSE false END AS has_null_patient_id,
    CASE WHEN o.encounter_id IS NULL THEN true ELSE false END AS has_null_encounter_id,
    CASE WHEN o.patient_id IS NOT NULL AND p.patient_id IS NULL THEN true ELSE false END AS has_missing_patient,
    CASE WHEN o.encounter_id IS NOT NULL AND e.encounter_id IS NULL THEN true ELSE false END AS has_missing_encounter,

    CASE
        WHEN o.patient_id IS NULL
          OR o.encounter_id IS NULL
          OR (o.patient_id IS NOT NULL AND p.patient_id IS NULL)
          OR (o.encounter_id IS NOT NULL AND e.encounter_id IS NULL)
        THEN false
        ELSE true
    END AS is_valid_record
FROM stg_portfolio.stg_synthea_observations o
LEFT JOIN stg_portfolio.stg_synthea_patients p
    ON o.patient_id = p.patient_id
LEFT JOIN stg_portfolio.stg_synthea_encounters e
    ON o.encounter_id = e.encounter_id;
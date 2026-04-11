--
CREATE TABLE core_portfolio.core_synthea_fact_encounters AS
SELECT
    encounter_id,
    encounter_start_date,
    encounter_end_date,
    patient_id,
    organization_id,
    provider_id,
    payer_id,
    encounter_class,
    encounter_code,
    encounter_description,
    base_encounter_cost,
    total_claim_cost,
    payer_coverage,
    reason_code,
    reason_description
FROM core_portfolio.int_synthea_encounters_validated
WHERE is_valid_record = true;

--
CREATE TABLE core_portfolio.core_synthea_fact_conditions AS
SELECT
    condition_start_date,
    condition_end_date,
    patient_id,
    encounter_id,
    condition_code,
    condition_description
FROM core_portfolio.int_synthea_conditions_validated
WHERE is_valid_record = true;

--
CREATE TABLE core_portfolio.core_synthea_fact_procedures AS
SELECT
    procedure_date,
    patient_id,
    encounter_id,
    procedure_code,
    procedure_description,
    base_cost,
    reason_code,
    reason_description
FROM core_portfolio.int_synthea_procedures_validated
WHERE is_valid_record = true;

--
CREATE TABLE core_portfolio.core_synthea_fact_medications AS
SELECT
    medication_start_date,
    medication_end_date,
    patient_id,
    payer_id,
    encounter_id,
    medication_code,
    medication_description,
    base_cost,
    payer_coverage,
    dispenses,
    total_cost,
    reason_code,
    reason_description
FROM core_portfolio.int_synthea_medications_validated
WHERE is_valid_record = true;

--
CREATE TABLE core_portfolio.core_synthea_fact_observations AS
SELECT
    observation_date,
    patient_id,
    encounter_id,
    observation_code,
    observation_description,
    observation_value,
    observation_units,
    observation_type
FROM core_portfolio.int_synthea_observations_validated
WHERE is_valid_record = true;
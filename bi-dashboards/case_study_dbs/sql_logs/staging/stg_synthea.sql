--
CREATE TABLE stg_portfolio.stg_synthea_conditions AS
SELECT
    CAST(NULLIF(TRIM(start), '') AS date) AS condition_start_date,
    CAST(NULLIF(TRIM(stop), '')AS date) AS condition_end_date,
    NULLIF(TRIM(patient), '') AS patient_id,
    NULLIF(TRIM(encounter), '') AS encounter_id,
    NULLIF(TRIM(code), '') AS condition_code,
    NULLIF(TRIM(description), '') AS condition_description
FROM raw_portfolio.raw_synthea_conditions;

--
CREATE TABLE stg_portfolio.stg_synthea_encounters AS
SELECT
    NULLIF(TRIM(id), '') AS encounter_id,
    CAST(NULLIF(TRIM(start), '') AS date) AS encounter_start_date,
    CAST(NULLIF(TRIM(stop), '') AS date) AS encounter_end_date,
    NULLIF(TRIM(patient), '') AS patient_id,
    NULLIF(TRIM(organization), '') AS organization_id,
    NULLIF(TRIM(provider), '') AS provider_id,
    NULLIF(TRIM(payer), '') AS payer_id,
    NULLIF(TRIM(encounterclass), '') AS encounter_class,
    NULLIF(TRIM(code), '') AS encounter_code,
    NULLIF(TRIM(description), '') AS encounter_description,
    base_encounter_cost::numeric AS base_encounter_cost,
    total_claim_cost::numeric AS total_claim_cost,
    payer_coverage::numeric AS payer_coverage,
    NULLIF(TRIM(reasoncode), '') AS reason_code,
    NULLIF(TRIM(reasondescription), '') AS reason_description
FROM raw_portfolio.raw_synthea_encounters;

--
CREATE TABLE stg_portfolio.stg_synthea_medications AS
SELECT
    CAST(NULLIF(TRIM(start), '') AS date) AS medication_start_date,
    CAST(NULLIF(TRIM(stop), '') AS date) AS medication_end_date,
    NULLIF(TRIM(patient), '') AS patient_id,
    NULLIF(TRIM(payer), '') AS payer_id,
    NULLIF(TRIM(encounter), '') AS encounter_id,
    NULLIF(TRIM(code), '') AS medication_code,
    NULLIF(TRIM(description), '') AS medication_description,
    base_cost::numeric AS base_cost,
    payer_coverage::numeric AS payer_coverage,
    dispenses::numeric AS dispenses,
    totalcost::numeric AS total_cost,
    NULLIF(TRIM(reasoncode), '') AS reason_code,
    NULLIF(TRIM(reasondescription), '') AS reason_description
FROM raw_portfolio.raw_synthea_medications;

--
CREATE TABLE stg_portfolio.stg_synthea_observations AS
SELECT
    CAST(NULLIF(TRIM(date), '') AS date) AS observation_date,
    NULLIF(TRIM(patient), '') AS patient_id,
    NULLIF(TRIM(encounter), '') AS encounter_id,
    NULLIF(TRIM(code), '') AS observation_code,
    NULLIF(TRIM(description), '') AS observation_description,
    NULLIF(TRIM(value), '') AS observation_value,
    NULLIF(TRIM(units), '') AS observation_units,
    NULLIF(TRIM(type), '') AS observation_type
FROM raw_portfolio.raw_synthea_observations;

--
CREATE TABLE stg_portfolio.stg_synthea_organizations AS
SELECT
    NULLIF(TRIM(id), '') AS organization_id,
    NULLIF(TRIM(name), '') AS organization_name,
    NULLIF(TRIM(address), '') AS address,
    NULLIF(TRIM(city), '') AS city,
    NULLIF(TRIM(state), '') AS state,
    NULLIF(TRIM(zip), '') AS zip,
    CAST(NULLIF(TRIM(lat), '') AS numeric) AS latitude,
    CAST(NULLIF(TRIM(lon), '') AS numeric) AS longitude,
    NULLIF(TRIM(phone), '') AS phone,
    revenue::numeric AS revenue,
    utilization::numeric AS utilization
FROM raw_portfolio.raw_synthea_organizations;

--
CREATE TABLE stg_portfolio.stg_synthea_patients AS
SELECT
    NULLIF(TRIM(id), '') AS patient_id,
    CAST(NULLIF(TRIM(birthdate), '') AS date) AS birth_date,
    CAST(NULLIF(TRIM(deathdate), '') AS date) AS death_date,
    NULLIF(TRIM(ssn), '') AS ssn,
    NULLIF(TRIM(drivers), '') AS drivers_license,
    NULLIF(TRIM(passport), '') AS passport,
    NULLIF(TRIM(prefix), '') AS prefix,
    NULLIF(TRIM(first), '') AS first_name,
    NULLIF(TRIM(last), '') AS last_name,
    NULLIF(TRIM(suffix), '') AS suffix,
    NULLIF(TRIM(maiden), '') AS maiden_name,
    NULLIF(TRIM(marital), '') AS marital_status,
    NULLIF(TRIM(race), '') AS race,
    NULLIF(TRIM(ethnicity), '') AS ethnicity,
    NULLIF(TRIM(gender), '') AS gender,
    NULLIF(TRIM(birthplace), '') AS birthplace,
    NULLIF(TRIM(address), '') AS address,
    NULLIF(TRIM(city), '') AS city,
    NULLIF(TRIM(state), '') AS state,
    NULLIF(TRIM(county), '') AS county,
    NULLIF(TRIM(zip), '') AS zip,
    CAST(NULLIF(TRIM(lat), '') AS numeric) AS latitude,
    CAST(NULLIF(TRIM(lon), '') AS numeric) AS longitude,
    healthcare_expenses::numeric AS healthcare_expenses,
    healthcare_coverage::numeric AS healthcare_coverage
FROM raw_portfolio.raw_synthea_patients;

--
CREATE TABLE stg_portfolio.stg_synthea_payer_transitions AS
SELECT
    NULLIF(TRIM(patient), '') AS patient_id,
    CAST(NULLIF(TRIM(start_year), '') AS integer) AS start_year,
    CAST(NULLIF(TRIM(end_year), '') AS integer) AS end_year,
    NULLIF(TRIM(payer), '') AS payer_id,
    NULLIF(TRIM(ownership), '') AS ownership
FROM raw_portfolio.raw_synthea_payer_transitions;

--
CREATE TABLE stg_portfolio.stg_synthea_payers AS
SELECT
    NULLIF(TRIM(id), '') AS payer_id,
    NULLIF(TRIM(name), '') AS payer_name,
    NULLIF(TRIM(address), '') AS address,
    NULLIF(TRIM(city), '') AS city,
    NULLIF(TRIM(state_headquartered), '') AS state_headquartered,
    NULLIF(TRIM(zip), '') AS zip,
    NULLIF(TRIM(phone), '') AS phone,
    amount_covered::numeric AS amount_covered,
    amount_uncovered::numeric AS amount_uncovered,
    revenue::numeric AS revenue,
    covered_encounters::numeric AS covered_encounters,
    uncovered_encounters::numeric AS uncovered_encounters,
    covered_medications::numeric AS covered_medications,
    uncovered_medications::numeric AS uncovered_medications,
    covered_procedures::numeric AS covered_procedures,
    uncovered_procedures::numeric AS uncovered_procedures,
    covered_immunizations::numeric AS covered_immunizations,
    uncovered_immunizations::numeric AS uncovered_immunizations,
    unique_customers::numeric AS unique_customers,
    qols_avg::numeric AS qols_avg,
    member_months::numeric AS member_months
FROM raw_portfolio.raw_synthea_payers;

--
CREATE TABLE stg_portfolio.stg_synthea_procedures AS
SELECT
    CAST(NULLIF(TRIM(date), '') AS date) AS procedure_date,
    NULLIF(TRIM(patient), '') AS patient_id,
    NULLIF(TRIM(encounter), '') AS encounter_id,
    NULLIF(TRIM(code), '') AS procedure_code,
    NULLIF(TRIM(description), '') AS procedure_description,
    base_cost::numeric AS base_cost,
    NULLIF(TRIM(reasoncode), '') AS reason_code,
    NULLIF(TRIM(reasondescription), '') AS reason_description
FROM raw_portfolio.raw_synthea_procedures;

--
CREATE TABLE stg_portfolio.stg_synthea_providers AS
SELECT
    NULLIF(TRIM(id), '') AS provider_id,
    NULLIF(TRIM(organization), '') AS organization_id,
    NULLIF(TRIM(name), '') AS provider_name,
    NULLIF(TRIM(gender), '') AS provider_gender,
    NULLIF(TRIM(speciality), '') AS provider_speciality,
    NULLIF(TRIM(address), '') AS address,
    NULLIF(TRIM(city), '') AS city,
    NULLIF(TRIM(state), '') AS state,
    NULLIF(TRIM(zip), '') AS zip,
    CAST(NULLIF(TRIM(lat), '') AS numeric) AS latitude,
    CAST(NULLIF(TRIM(lon), '') AS numeric) AS longitude,
    utilization::numeric AS utilization
FROM raw_portfolio.raw_synthea_providers;
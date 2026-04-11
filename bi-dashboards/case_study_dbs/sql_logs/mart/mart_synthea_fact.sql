--
DROP TABLE IF EXISTS mart_portfolio.mart_synthea_fact_encounters;

CREATE TABLE mart_portfolio.mart_synthea_fact_encounters AS
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
    reason_description,
    (encounter_end_date - encounter_start_date) AS length_of_stay_days,
    (total_claim_cost - payer_coverage) AS patient_out_of_pocket,
    EXTRACT(YEAR FROM encounter_start_date)::integer AS encounter_year,
    EXTRACT(MONTH FROM encounter_start_date)::integer AS encounter_month
FROM core_portfolio.core_synthea_fact_encounters;

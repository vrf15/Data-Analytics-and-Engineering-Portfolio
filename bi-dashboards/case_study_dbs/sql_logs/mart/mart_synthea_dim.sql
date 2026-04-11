-- Added DROP TABLE commands in case I have to rebuild the table for adding new enrichment data
--
DROP TABLE IF EXISTS mart_portfolio.mart_synthea_dim_patients;

CREATE TABLE mart_portfolio.mart_synthea_dim_patients AS
SELECT
    p.patient_id,
    p.birth_date,
    p.death_date,
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
    ip.healthcare_expenses,
    ip.healthcare_coverage,
    DATE_PART('year', AGE(COALESCE(p.death_date, CURRENT_DATE), p.birth_date))::integer AS current_age,
    CASE
        WHEN DATE_PART('year', AGE(COALESCE(p.death_date, CURRENT_DATE), p.birth_date)) < 18 THEN 'Pediatric (0-17)'
        WHEN DATE_PART('year', AGE(COALESCE(p.death_date, CURRENT_DATE), p.birth_date)) BETWEEN 18 AND 34 THEN 'Young Adult (18-34)'
        WHEN DATE_PART('year', AGE(COALESCE(p.death_date, CURRENT_DATE), p.birth_date)) BETWEEN 35 AND 49 THEN 'Adult (35-49)'
        WHEN DATE_PART('year', AGE(COALESCE(p.death_date, CURRENT_DATE), p.birth_date)) BETWEEN 50 AND 64 THEN 'Older Adult (50-64)'
        WHEN DATE_PART('year', AGE(COALESCE(p.death_date, CURRENT_DATE), p.birth_date)) >= 65 THEN 'Senior (65+)'
        ELSE NULL
    END AS age_group,
    CASE
        WHEN p.death_date IS NOT NULL THEN true
        ELSE false
    END AS is_deceased
FROM core_portfolio.core_synthea_dim_patients p
LEFT JOIN core_portfolio.int_synthea_patients_validated ip
    ON p.patient_id = ip.patient_id;

--
DROP TABLE IF EXISTS mart_portfolio.mart_synthea_dim_payers;

CREATE TABLE mart_portfolio.mart_synthea_dim_payers AS
SELECT
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
    member_months,
    CASE
        WHEN payer_name = 'Dual Eligible' THEN 'Dual Eligible'
        WHEN payer_name = 'Medicare' THEN 'Medicare'
        WHEN payer_name = 'Medicaid' THEN 'Medicaid'
        WHEN payer_name = 'NO_INSURANCE' THEN 'Uninsured'
        ELSE 'Commercial'
    END AS payer_type
FROM core_portfolio.core_synthea_dim_payers;

--
DROP TABLE IF EXISTS mart_portfolio.mart_synthea_dim_providers;

CREATE TABLE mart_portfolio.mart_synthea_dim_providers AS
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
    utilization,
    CASE
        WHEN provider_speciality IN (
            'FAMILY PRACTICE',
            'GENERAL PRACTICE',
            'INTERNAL MEDICINE',
            'GERIATRIC MEDICINE',
            'HOSPITALIST',
            'NURSE PRACTITIONER',
            'PHYSICIAN ASSISTANT',
            'PREVENTATIVE MEDICINE'
        ) THEN 'Primary Care'

        WHEN provider_speciality IN (
            'EMERGENCY MEDICINE',
            'CRITICAL CARE (INTENSIVISTS)'
        ) THEN 'Emergency / Acute Care'

        WHEN provider_speciality IN (
            'PSYCHIATRY',
            'GERIATRIC PSYCHIATRY',
            'NEUROPSYCHIATRY',
            'CLINICAL PSYCHOLOGIST',
            'CLINICAL SOCIAL WORKER',
            'ADDICTION MEDICINE'
        ) THEN 'Mental Health'

        WHEN provider_speciality IN (
            'CARDIOVASCULAR DISEASE (CARDIOLOGY)',
            'ADVANCED HEART FAILURE AND TRANSPLANT CARDIOLOGY',
            'CARDIAC ELECTROPHYSIOLOGY',
            'INTERVENTIONAL CARDIOLOGY',
            'PERIPHERAL VASCULAR DISEASE'
        ) THEN 'Cardiology / Vascular'

        WHEN provider_speciality IN (
            'HEMATOLOGY',
            'HEMATOLOGY/ONCOLOGY',
            'MEDICAL ONCOLOGY',
            'RADIATION ONCOLOGY',
            'SURGICAL ONCOLOGY',
            'GYNECOLOGICAL ONCOLOGY',
            'HEMATOPOIETIC CELL TRANSPLANTATION AND CELLULAR TH'
        ) THEN 'Oncology / Hematology'

        WHEN provider_speciality IN (
            'GENERAL SURGERY',
            'CARDIAC SURGERY',
            'COLORECTAL SURGERY (PROCTOLOGY)',
            'HAND SURGERY',
            'MAXILLOFACIAL SURGERY',
            'NEUROSURGERY',
            'ORAL SURGERY',
            'ORTHOPEDIC SURGERY',
            'PLASTIC AND RECONSTRUCTIVE SURGERY',
            'THORACIC SURGERY',
            'UROLOGY',
            'VASCULAR SURGERY'
        ) THEN 'Surgery'

        WHEN provider_speciality IN (
            'OBSTETRICS/GYNECOLOGY',
            'CERTIFIED NURSE MIDWIFE'
        ) THEN 'OB/GYN'

        WHEN provider_speciality IN (
            'PEDIATRIC MEDICINE'
        ) THEN 'Pediatrics'

        WHEN provider_speciality IN (
            'DIAGNOSTIC RADIOLOGY',
            'INTERVENTIONAL RADIOLOGY',
            'NUCLEAR MEDICINE',
            'PATHOLOGY'
        ) THEN 'Imaging / Diagnostics'

        WHEN provider_speciality IN (
            'ALLERGY/IMMUNOLOGY',
            'ENDOCRINOLOGY',
            'GASTROENTEROLOGY',
            'INFECTIOUS DISEASE',
            'NEPHROLOGY',
            'NEUROLOGY',
            'OPHTHALMOLOGY',
            'OTOLARYNGOLOGY',
            'PULMONARY DISEASE',
            'RHEUMATOLOGY',
            'SLEEP MEDICINE',
            'SPORTS MEDICINE',
            'DERMATOLOGY'
        ) THEN 'Medical Specialty'

        WHEN provider_speciality IN (
            'ANESTHESIOLOGY',
            'ANESTHESIOLOGY ASSISTANT',
            'CERTIFIED REGISTERED NURSE ANESTHETIST',
            'INTERVENTIONAL PAIN MANAGEMENT',
            'PAIN MANAGEMENT',
            'HOSPICE/PALLIATIVE CARE',
            'PHYSICAL MEDICINE AND REHABILITATION',
            'OCCUPATIONAL THERAPY',
            'PHYSICAL THERAPY',
            'SPEECH LANGUAGE PATHOLOGIST',
            'REGISTERED DIETITIAN OR NUTRITION PROFESSIONAL'
        ) THEN 'Supportive / Rehab Care'

        WHEN provider_speciality IN (
            'DENTIST',
            'CHIROPRACTIC',
            'AUDIOLOGIST',
            'OPTOMETRY',
            'OSTEOPATHIC MANIPULATIVE MEDICINE',
            'PODIATRY',
            'UNDEFINED PHYSICIAN TYPE (SPECIFY)'
        ) THEN 'Other Specialty'

        ELSE 'Other Specialty'
    END AS specialty_category
FROM core_portfolio.core_synthea_dim_providers;
--
CREATE TABLE IF NOT EXISTS raw_portfolio.raw_synthea_encounters (
    id text,
    start text,
    stop text,
    patient text,
    organization text,
    provider text,
    payer text,
    encounterclass text,
    code text,
    description text,
    base_encounter_cost numeric,
    total_claim_cost numeric,
    payer_coverage numeric,
    reasoncode text,
    reasondescription text
);

--
CREATE TABLE IF NOT EXISTS raw_portfolio.raw_synthea_patients (
    id text,
    birthdate text,
    deathdate text,
    ssn text,
    drivers text,
    passport text,
    prefix text,
    first text,
    last text,
    suffix text,
    maiden text,
    marital text,
    race text,
    ethnicity text,
    gender text,
    birthplace text,
    address text,
    city text,
    state text,
    county text,
    zip text,
    lat text,
    lon text,
    healthcare_expenses numeric,
    healthcare_coverage numeric
);

--
CREATE TABLE IF NOT EXISTS raw_portfolio.raw_synthea_conditions (
    start text,
    stop text,
    patient text,
    encounter text,
    code text,
    description text
);

--
CREATE TABLE IF NOT EXISTS raw_portfolio.raw_synthea_procedures (
    date text,
    patient text,
    encounter text,
    code text,
    description text,
    base_cost numeric,
    reasoncode text,
    reasondescription text
);

--
CREATE TABLE IF NOT EXISTS raw_portfolio.raw_synthea_medications (
    start text,
    stop text,
    patient text,
    payer text,
    encounter text,
    code text,
    description text,
    base_cost numeric,
    payer_coverage numeric,
    dispenses numeric,
    totalcost numeric,
    reasoncode text,
    reasondescription text
);

--
CREATE TABLE IF NOT EXISTS raw_portfolio.raw_synthea_organizations (
    id text,
    name text,
    address text,
    city text,
    state text,
    zip text,
    lat text,
    lon text,
    phone text,
    revenue numeric,
    utilization numeric
);

--
CREATE TABLE IF NOT EXISTS raw_portfolio.raw_synthea_providers (
    id text,
    organization text,
    name text,
    gender text,
    speciality text,
    address text,
    city text,
    state text,
    zip text,
    lat text,
    lon text,
    utilization numeric
);

--
CREATE TABLE IF NOT EXISTS raw_portfolio.raw_synthea_observations (
    date text,
    patient text,
    encounter text,
    code text,
    description text,
    value text,
    units text,
    type text
);

--
CREATE TABLE IF NOT EXISTS raw_portfolio.raw_synthea_payers (
    id text,
    name text,
    address text,
    city text,
    state_headquartered text,
    zip text,
    phone text,
    amount_covered numeric,
    amount_uncovered numeric,
    revenue numeric,
    covered_encounters numeric,
    uncovered_encounters numeric,
    covered_medications numeric,
    uncovered_medications numeric,
    covered_procedures numeric,
    uncovered_procedures numeric,
    covered_immunizations numeric,
    uncovered_immunizations numeric,
    unique_customers numeric,
    qols_avg numeric,
    member_months numeric
);

--
CREATE TABLE IF NOT EXISTS raw_portfolio.raw_synthea_payer_transitions (
    patient text,
    start_year text,
    end_year text,
    payer text,
    ownership text
);
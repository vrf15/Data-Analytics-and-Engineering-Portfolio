# AI Practice Queries — February 7, 2026

## Focus: Window Functions (CTEs → Sequencing → Analytic Logic)

Today’s practice session shifts into **window function mastery**, building on my existing foundation of filtering and CTE pipelines. The emphasis is on understanding how analytic functions like `ROW_NUMBER()`, `RANK()`, and `LAG()` operate across partitions, enabling patient‑level sequencing, timeline construction, and Revenue Integrity analytics.

Window functions allow me to analyze patterns **within groups** (such as per‑)

**NOTE: I always read the feedback and then make corrections on my notepad. This ensures muscle memory between reps**

---

### Problem — 2026-02-07 — Window Functions #1
**Description:**  
Use a CTE to filter charges, then apply `ROW_NUMBER()` to create a chronological sequence of charges per patient.

**Tables:**  
- Charges  

**CTE Requirements:**  
- charge_date BETWEEN '2024-01-01' AND '2024-12-31'  
- status = 'Posted'  
- charge_amount > 0  
- cpt_code IN ('71045', '80053', '99213')  
- charge_date IS NOT NULL  

**Window Function Requirements:**  
- ROW_NUMBER() OVER (PARTITION BY patient_id ORDER BY charge_date ASC) AS row_num
  
---

## Final SQL Solution: My Response
```sql
WITH posted2024 AS (
    SELECT *
    FROM Charges
    WHERE 
        charge_date BETWEEN '2024-01-01' AND '2024-12-31'
        AND status = 'POSTED'
        AND charge_amount > 0
        AND cpt_code IN ('71045','80053','99213')
    ROW_NUMBER() over patient_id
    ORDER BY charge_date ASC
)

SELECT
    patient_id,
    charge_id,
    cpt_code,
    charge_date,
    row_num
FROM posted2024;
```

---

## Final SQL Solution: Correct Answer
```sql
WITH posted2024 AS (
    SELECT *
    FROM Charges
    WHERE 
        charge_date BETWEEN '2024-01-01' AND '2024-12-31'
        AND status = 'Posted'
        AND charge_amount > 0
        AND cpt_code IN ('71045','80053','99213')
        AND charge_date IS NOT NULL
)

SELECT
    patient_id,
    charge_id,
    cpt_code,
    charge_date,
    ROW_NUMBER() OVER (
        PARTITION BY patient_id
        ORDER BY charge_date ASC
    ) AS row_num
FROM posted2024;
```

---

## Feedback
- Window functions must be in the SELECT list, not inside the CTE filter.  
- Must use full syntax: `ROW_NUMBER() OVER (PARTITION BY … ORDER BY …)`  
- Added missing `charge_date IS NOT NULL` filter.  
- Corrected status to `'Posted'` for consistency.  

---

### Problem — 2026-02-07 — Window Functions #2 (ROW_NUMBER Only)
**Description:**  
Filter charges using a CTE, then apply ROW_NUMBER() to create a chronological sequence of charges per patient.

**Tables:**  
- Charges  

**CTE Requirements:**  
- charge_date BETWEEN '2024-01-01' AND '2024-12-31'  
- status = 'Posted'  
- charge_amount > 0  
- charge_date IS NOT NULL  

**Window Function Requirements:**  
- ROW_NUMBER() OVER (PARTITION BY patient_id ORDER BY charge_date ASC) AS row_num  

---

## Final SQL Solution: My Response
```sql
WITH posted2024 AS (
    SELECT *
    FROM Charges
    WHERE
        charge_date BETWEEN '2024-01-01' AND '2024-12-31'
        AND status = 'Posted'
        AND charge_amount > 0
        AND charge_date IS NOT NULL
)

SELECT
    patient_id
    charge_id,
    cpt_code,
    charge_date,
    ROW_NUMBER() OVER (
        PATITION BY patient_id
        ORDER BY charge_date ASC
    ) AS row_num
FROM posted2024;
```

---

## Final SQL Solution: Correct Answer
```sql
WITH posted2024 AS (
    SELECT *
    FROM Charges
    WHERE
        charge_date BETWEEN '2024-01-01' AND '2024-12-31'
        AND status = 'Posted'
        AND charge_amount > 0
        AND charge_date IS NOT NULL
)

SELECT
    patient_id,
    charge_id,
    cpt_code,
    charge_date,
    ROW_NUMBER() OVER (
        PARTITION BY patient_id
        ORDER BY charge_date ASC
    ) AS row_num
FROM posted2024;
```

---

## Feedback
- Missing comma after `patient_id` in the SELECT list.  
- `PATITION BY` is misspelled — correct spelling is `PARTITION BY`.  
- Window function syntax must be: `ROW_NUMBER() OVER (PARTITION BY … ORDER BY …)`.  
- Everything else (CTE structure, filters, placement of window function) was correct.

---

### Problem — 2026-02-07 — Window Functions #4 (ROW_NUMBER Only, Medication Administration Context)
**Description:**  
Filter medication administration records using a CTE, then apply ROW_NUMBER() to sequence administrations chronologically per patient.

**Tables:**  
- MedicationAdministrations  

**CTE Requirements:**  
- status = 'Completed'  
- admin_time IS NOT NULL  
- medication_class IN ('Antibiotic', 'Analgesic', 'Anticoagulant')  
- route IN ('IV', 'PO')  
- service_line NOT IN ('Psych', 'Rehab')  

**Window Function Requirements:**  
- ROW_NUMBER() OVER (PARTITION BY patient_id ORDER BY admin_time ASC) AS row_num  

---

## Final SQL Solution: My Response
```sql
WITH filteredclassrouteservice AS (
    SELECT *
    FROM MedicationAdministrations
    WHERE 
        status = 'Completed'
        AND admin_time IS NOT NULL
        AND medication_class IN ('Antibiotic','Analgesic','Anticoagulant')
        AND route IN ('IV','PO')
        AND service_line NOT IN ('Psych','Rehab')
)

SELECT
    patient_id,
    admin_id,
    medication_id,
    admin_time,
    dose,
    ROW_NUMBER () OVER (
        PARTITION BY patient_id
        ORDER BY admin_time ASC
    ) AS row_num
FROM filteredclassrouteservice;
```

---

## Final SQL Solution: Correct Answer
```sql
WITH filteredclassrouteservice AS (
    SELECT *
    FROM MedicationAdministrations
    WHERE 
        status = 'Completed'
        AND admin_time IS NOT NULL
        AND medication_class IN ('Antibiotic','Analgesic','Anticoagulant')
        AND route IN ('IV','PO')
        AND service_line NOT IN ('Psych','Rehab')
)

SELECT
    patient_id,
    admin_id,
    medication_name,
    admin_time,
    dose,
    ROW_NUMBER() OVER (
        PARTITION BY patient_id
        ORDER BY admin_time ASC
    ) AS row_num
FROM filteredclassrouteservice;
```

---

## Feedback
- `medication_id` does not exist — correct column is `medication_name`.  
- CTE name mismatch (`filtedservice2024` vs `filteredclassrouteservice`).  
- Everything else (filters, structure, window function) was correct and well‑formed.

---

### Problem — 2026-02-07 — Window Functions #5 (ROW_NUMBER Only, Radiology Orders Context)
**Description:**  
Filter radiology orders using a CTE, then apply ROW_NUMBER() to sequence orders chronologically within each encounter.

**Tables:**  
- RadiologyOrders  

**CTE Requirements:**  
- status = 'Completed'  
- order_time IS NOT NULL  
- modality IN ('CT', 'MRI', 'XR', 'US')  
- exam_category NOT IN ('Screening', 'Research')  
- service_line IN ('Emergency', 'Inpatient', 'Outpatient')  

**Window Function Requirements:**  
- ROW_NUMBER() OVER (PARTITION BY encounter_id ORDER BY order_time ASC) AS row_num  

---

## Final SQL Solution: My Response
```sql
WITH CTEfilter AS (
    SELECT *
    FROM RadiologyOrders
    WHERE
        status = 'Completed'
        AND order_time IS NOT NULL
        AND modality IN ('CT','MRI','XR','US')
        AND exam_category NOT IN ('Screening','Research')
        AND service_line IN ('Emergency','Inpatient','Outpatient')
)

SELECT
    encounter_id,
    order_id,
    exam_name,
    order_time,
    order_priority
    ROW_NUMBER () OVER (
        PARTITION BY encounter_id
        ORDER BY order_time
    ) AS row_num
FROM CTEfilter;
```

---

## Final SQL Solution: Correct Answer
```sql
WITH CTEfilter AS (
    SELECT *
    FROM RadiologyOrders
    WHERE
        status = 'Completed'
        AND order_time IS NOT NULL
        AND modality IN ('CT','MRI','XR','US')
        AND exam_category NOT IN ('Screening','Research')
        AND service_line IN ('Emergency','Inpatient','Outpatient')
)

SELECT
    encounter_id,
    order_id,
    exam_name,
    order_time,
    order_priority,
    ROW_NUMBER() OVER (
        PARTITION BY encounter_id
        ORDER BY order_time ASC
    ) AS row_num
FROM CTEfilter;
```

---

## Feedback
- Missing comma after `order_priority` in SELECT list.  
- Window function syntax correct, but must follow a comma-separated column list.  
- Everything else (CTE structure, filters, window logic) was correct and well‑formed.
---

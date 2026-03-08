# AI Practice Queries — February 3, 2026

## Focus: Advanced Filtering (with Gradual CTEs & Aggregations)

Today’s practice session builds on **filtering mastery**, continuing to emphasize correct handling of exclusions and missing values using `NOT`, `IS NOT`, and `NULL`, while **slowly introducing CTEs, aggregations, and layered query logic**.

Filtering remains the primary focus, with added complexity introduced incrementally to mirror real-world analytical queries.

### Practice Method
- Copilot provides SQL prompts  
- I write the appropriate query using proper formatting and best practices  
- Immediate feedback is reviewed and incorporated  

### Goals
- Deepen mastery of `NOT`, `IS NOT`, and `NULL` handling in complex queries  
- Practice filtering within and across CTEs without losing readability  
- Avoid logical errors when combining filters with joins and aggregations  
- Gradually increase query complexity while maintaining clarity and intent

------------------------------------------------------------------------------------------------------------------------------------------------------

### Problem — 2026-02-03 — Filtering #1

**Final SQL Solution: My Response**
```sql
SELECT,
    patient_id,
    first_name,
    last_name
FROM Patients
WHERE
    gender = 'F'
    AND status IN ('Active','Pending')
    AND birth_date < '2000-01-01'
    AND created_date BETWEEN '2024-01-01' AND '2024-12-31'
    AND last_name NOT LIKE 'Test%'
    AND LOWER(first_name) NOT LIKE '%demo%';
```

---

### Final SQL Solution: Correct Answer
```sql
SELECT
    patient_id,
    first_name,
    last_name
FROM Patients
WHERE
    gender = 'F'
    AND status IN ('Active', 'Pending')
    AND birth_date < '2000-01-01'
    AND created_date BETWEEN '2024-01-01' AND '2024-12-31'
    AND last_name NOT LIKE 'Test%'
    AND LOWER(first_name) NOT LIKE '%demo%';
```

---

### **Feedback (concise)**
- Remove the comma after `SELECT` — invalid syntax.  
- Everything else is correct.  
- Clean, accurate, production‑ready filtering.

------------------------------------------------------------------------------------------------------------------------------------------------------

### Problem — 2026-02-03 — Filtering #2

**Final SQL Solution: My Response**
```sql
SELECT
    encounter_id,
    patient_id,
    encounter_type
FROM Encounters
WHERE
    encounter_type IN ('Inpatient', 'Emergency')
    AND encounter_date BETWEEN '2024-01-01' AND '2024-12-31'
    AND status = 'Closed'
    AND location NOT LIKE 'Test%'
    AND UPPER(provider) NOT LIKE '%DEMO%'
    AND encounter_type <> 'Emergency'
    AND status <> 'Closed'
    AND encounter_date IS NOT NULL;
```

---

### Final SQL Solution: Correct Answer
```sql
SELECT
    encounter_id,
    patient_id,
    encounter_type
FROM Encounters
WHERE
    encounter_type IN ('Inpatient', 'Emergency')
    AND encounter_date BETWEEN '2024-01-01' AND '2024-12-31'
    AND status = 'Closed'
    AND location NOT LIKE 'Test%'
    AND LOWER(provider) NOT LIKE '%demo%'
    AND NOT (encounter_type = 'Emergency' AND status <> 'Closed')
    AND encounter_date IS NOT NULL;
```

---

### **Feedback (concise)**
- You added **two contradictory filters**:  
  `encounter_type <> 'Emergency'` AND `status <> 'Closed'` — these wipe out valid rows and violate the requirement.  
- Requirement was a **single exclusion condition**, not two separate filters.  
- Provider filter should use `LOWER()` for consistency.  
- Everything else (IN, date range, pattern exclusion, NULL check) was correct.

------------------------------------------------------------------------------------------------------------------------------------------------------

### Problem — 2026-02-03 — Filtering #3

**Final SQL Solution: My Response**
```sql
SELECT
    order_id,
    patient_id,
    order_type
FROM Orders
WHERE
    order_type IN ('Lab','Imaging')
    AND order_date BETWEEN '2024-01-01' AND '2024-12-31'
    AND (status = 'Final' OR status = 'Completed')
    AND priority NOT IN ('Low','Routine')
    AND LOWER(ordering_provider) NOT LIKE '%test%'
    AND NOT (order_type = 'Lab' AND order_type = 'Imaging')
    AND order_date IS NOT NULL;
```

---

### Final SQL Solution: Correct Answer
```sql
SELECT
    order_id,
    patient_id,
    order_type
FROM Orders
WHERE
    order_type IN ('Lab', 'Imaging')
    AND order_date BETWEEN '2024-01-01' AND '2024-12-31'
    AND (status = 'Final' OR status = 'Completed')
    AND priority NOT IN ('Low', 'Routine')
    AND LOWER(ordering_provider) NOT LIKE '%test%'
    AND NOT (order_type <> 'Lab' AND order_type <> 'Imaging')
    AND order_date IS NOT NULL;
```

---

### **Feedback (concise)**
- Your NOT logic is incorrect.  
  - You wrote: `NOT (order_type = 'Lab' AND order_type = 'Imaging')`  
  - This condition is **always true** because a value can’t be both Lab *and* Imaging.  
- Required trap:  
  ```
  NOT (order_type <> 'Lab' AND order_type <> 'Imaging')
  ```
  which resolves to “keep Lab or Imaging.”  
- Everything else is correct.

------------------------------------------------------------------------------------------------------------------------------------------------------

### Problem — 2026-02-03 — Filtering #4

**Final SQL Solution: My Response**
```sql
SELECT
    med_id,
    patient_id,
    med_name
FROM Medications
WHERE
    med_class IN ('Antibiotic','Steroid')
    AND start_date BETWEEN '2024-01-01' AND '2024-12-31'
    AND status = 'Active'
    AND LOWER(ordering_provider) NOT LIKE '%test%'
    AND LOWER(ordering_provider) NOT LIKE '%demo%'
    AND med_name NOT LIKE '%Sample%'
    AND LOWER(med_name) NOT LIKE '%trial%'
    AND NOT (med_class <> 'Antibiotic' AND med_class <> 'Steroid')
    AND start_date IS NOT NULL;
```

---

### Final SQL Solution: Correct Answer
```sql
SELECT
    med_id,
    patient_id,
    med_name
FROM Medications
WHERE
    med_class IN ('Antibiotic', 'Steroid')
    AND start_date BETWEEN '2024-01-01' AND '2024-12-31'
    AND status = 'Active'
    AND LOWER(ordering_provider) NOT LIKE '%test%'
    AND LOWER(ordering_provider) NOT LIKE '%demo%'
    AND med_name NOT LIKE 'Sample%'
    AND LOWER(med_name) NOT LIKE '%trial%'
    AND NOT (med_class <> 'Antibiotic' AND med_class <> 'Steroid')
    AND start_date IS NOT NULL;
```

---

### **Feedback (concise)**
- `med_name NOT LIKE '%Sample%'` is incorrect — requirement is **starts with**, so use `'Sample%'`.  
- Everything else is correct: IN logic, NOT logic, date range, substring exclusions, NULL check.

------------------------------------------------------------------------------------------------------------------------------------------------------

### Problem — 2026-02-03 — Filtering #5 (CTE Version)

**Final SQL Solution: My Response**
```sql
WITH filtered_2024 AS (
    SELECT *
    FROM Charges
    WHERE
        cpt_code IN ('71045','80053','99213')
        AND charge_date BETWEEN '2024-01-01' AND '2024-12-31'
        AND status = 'Posted'
        AND modifier NOT IN ('TC','26')
        AND department NOT LIKE 'Test%'
        AND LOWER(ordering_provider) NOT LIKE '%demo%'
        AND LOWER(ordering_provider) NOT LIKE '%training%'
        AND NOT (cpt_code <> '71045' AND cpt_code <> '80053')
        AND charge_date IS NOT NULL
)

SELECT
    charge_id,
    patient_id,
    cpt_code,
FROM filtered_2024;
```

---

### Final SQL Solution: Correct Answer
```sql
WITH filtered_2024 AS (
    SELECT *
    FROM Charges
    WHERE
        cpt_code IN ('71045', '80053', '99213')
        AND charge_date BETWEEN '2024-01-01' AND '2024-12-31'
        AND status = 'Posted'
        AND modifier NOT IN ('TC', '26')
        AND department NOT LIKE 'Test%'
        AND LOWER(ordering_provider) NOT LIKE '%demo%'
        AND LOWER(ordering_provider) NOT LIKE '%training%'
        AND NOT (cpt_code <> '71045' AND cpt_code <> '80053')
        AND charge_date IS NOT NULL
)

SELECT
    charge_id,
    patient_id,
    cpt_code
FROM filtered_2024;
```

---

### **Feedback (concise)**
- Trailing comma after `cpt_code` in the final SELECT — remove it.  
- All filtering logic inside the CTE is correct.  
- NOT logic is correct.  
- Pattern exclusions are correct.  
- Date logic is correct.  

------------------------------------------------------------------------------------------------------------------------------------------------------

### Problem — 2026-02-03 — Filtering + Aggregates + GROUP BY #6

**Final SQL Solution: My Response**
```sql
WITH posted_2024 AS (
    SELECT *
    FROM Charges
    WHERE
        charge_date BETWEEN '2024-01-01' AND '2024-12-31'
        AND status = 'Posted'
        AND NOT IN ('TC','26')
        AND department NOT LIKE 'Test%'
        AND LOWER(ordering_provider) NOT LIKE '%demo%'
        AND charge_amount > 0
        AND NOT (cpt_code <> '71045' AND cpt_code <> '80053')
        AND charge_date IS NOT NULL
)

SELECT
    department,
    COUNT(*) AS total_charges,
    SUM(charge_amount) AS total_amount
FROM posted_2024
GROUP BY department
ORDER BY total_amount DESC;
```

---

### Final SQL Solution: Correct Answer
```sql
WITH posted_2024 AS (
    SELECT *
    FROM Charges
    WHERE
        charge_date BETWEEN '2024-01-01' AND '2024-12-31'
        AND status = 'Posted'
        AND modifier NOT IN ('TC', '26')
        AND department NOT LIKE 'Test%'
        AND LOWER(ordering_provider) NOT LIKE '%demo%'
        AND charge_amount > 0
        AND NOT (cpt_code <> '71045' AND cpt_code <> '80053')
        AND charge_date IS NOT NULL
)

SELECT
    department,
    COUNT(*) AS total_charges,
    SUM(charge_amount) AS total_amount
FROM posted_2024
GROUP BY department
ORDER BY total_amount DESC;
```

---

### **Feedback (concise)**
- `AND NOT IN ('TC','26')` is invalid — missing the column name. Should be `modifier NOT IN ('TC','26')`.  
- Everything else in the CTE is correct: date logic, NOT logic, pattern exclusion, amount filter.  
- Final SELECT, GROUP BY, and ORDER BY are all correct.  

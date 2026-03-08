# AI Practice Queries — February 2, 2026

## Focus: Filtering with NOT, IS NOT, and NULL

Today’s practice session is focused on **accurate and intentional SQL filtering**, with emphasis on handling exclusions and missing values using `NOT`, `IS NOT`, and `NULL`.

### Practice Method
- Copilot provides SQL prompts  
- I write the appropriate query using proper formatting and best practices  
- Immediate feedback is reviewed and incorporated  

### Goals
- Master correct handling of `NULL` vs non-`NULL` values  
- Avoid common filtering mistakes (`!= NULL`, incorrect negation logic)  
- Improve precision in business-driven WHERE clauses  
- Strengthen confidence with exclusion-based conditions

----------------------------------------------------------------------------------------------------------------

### Problem — 2026-02-02 — Filtering #1
**Description:**  
Filter patients using multi-condition AND/OR logic with correct parentheses.

**Tables:**  
- Patients  

**Columns:**  
- patient_id  
- age  
- gender  
- state  
- smoker_status  
- chronic_flag  

**Requirements:**  
- age BETWEEN 40 AND 65  
- gender = 'F'  
- smoker_status IN ('Current', 'Former')  
- chronic_flag <> 'Y'  
- Must use parentheses to group OR conditions  

---

**Final SQL Solution: My Response**  
```sql
SELECT
    patient_id,
    age,
    gender,
FROM Patients
WHERE (
    age BETWEEN '40' AND '65'
    AND gender = 'F'
)
    AND NOT chronic_flag ='Y';
```

---

**Final SQL Solution: Correct Answer**  
```sql
SELECT
    patient_id,
    age,
    gender
FROM Patients
WHERE
    age BETWEEN 40 AND 65
    AND gender = 'F'
    AND smoker_status IN ('Current', 'Former')
    AND chronic_flag <> 'Y';
```

---

**Feedback**  
- You added a trailing comma after `gender`, which breaks the SELECT clause.  
- You filtered age using strings (`'40'` and `'65'`), but numeric comparisons should not use quotes.  
- You omitted the required smoker_status filter (`IN ('Current', 'Former')`).  
- `NOT chronic_flag = 'Y'` works, but `chronic_flag <> 'Y'` is cleaner and more conventional.  
- Parentheses were fine, but unnecessary here since all conditions are AND.  
- Overall structure is solid — just missing one requirement and a couple syntax fixes.  

----------------------------------------------------------------------------------------------------------------

### Problem — 2026-02-02 — Filtering #2
**Description:**  
Filter lab results using AND/OR logic, NOT logic, and pattern exclusion.

**Tables:**  
- LabResults  

**Columns:**  
- result_id  
- patient_id  
- test_name  
- result_value  
- result_flag  
- collected_date  
- department  

**Requirements:**  
- department IN ('Chemistry', 'Hematology')  
- collected_date BETWEEN '2024-01-01' AND '2024-12-31'  
- result_flag IN ('High', 'Critical')  
- test_name NOT LIKE 'QC%'  
- result_value IS NOT NULL  
- Must use parentheses for OR grouping  

---

**Final SQL Solution: My Response**  
```sql
SELECT
    result_id,
    patient_id,
    test_name
FROM LabResults
WHERE
    department IN ('Chemistry','Hematology')
    AND collected_date BETWEEN '2024-01-01' AND '2024-12-31'
    AND result_flag IN ('High','Critical')
    AND test_name NOT LIKE 'QC'
    AND result_value = 'NULL';
```

---

**Final SQL Solution: Correct Answer**  
```sql
SELECT
    result_id,
    patient_id,
    test_name
FROM LabResults
WHERE
    department IN ('Chemistry', 'Hematology')
    AND collected_date BETWEEN '2024-01-01' AND '2024-12-31')
    AND (result_flag = 'High' OR result_flag = 'Critical')
    AND test_name NOT LIKE 'QC%'
    AND result_value IS NOT NULL;
```

---

**Feedback**  
- `test_name NOT LIKE 'QC'` is incorrect — `'QC'` matches only the exact string. You needed `'QC%'` to exclude anything starting with QC.  
- `result_value = 'NULL'` is incorrect — `'NULL'` is a string literal. To exclude NULLs you must use `IS NOT NULL`.  
- You correctly used `IN` for department and result_flag.  
- Parentheses were required around the OR condition, but you used `IN`, which is acceptable — just be aware of the requirement.  
- Overall structure is clean and readable; the main issues were pattern matching and NULL logic.

----------------------------------------------------------------------------------------------------------------

### Problem — 2026-02-02 — Filtering #3
**Description:**  
Filter medications using AND/OR logic, NOT IN, NULL logic, and substring exclusion.

**Tables:**  
- Medications  

**Columns:**  
- med_id  
- patient_id  
- med_name  
- med_class  
- start_date  
- end_date  
- active_flag  
- prescribing_dept  

**Requirements:**  
- active_flag = 'Y'  
- prescribing_dept NOT IN ('Dermatology', 'Psychiatry')  
- med_class IN ('Antibiotic', 'Antiviral')  
- start_date BETWEEN '2024-01-01' AND '2024-12-31'  
- (end_date IS NULL OR end_date > '2024-12-31')  
- med_name NOT LIKE '%Trial%' (case-insensitive)  
- Must use parentheses for OR grouping  

---

**Final SQL Solution: My Response**  
```sql
SELECT
    med_id,
    patient_id,
    med_name
FROM Medications
WHERE
    active_flag = 'Y'
    AND prescribing_dept NOT IN ('Dermatology', 'Psychiatry')
    AND (
        med_class = 'Antibiotics'
        OR med_class = 'Antiviral
    )
    AND start_date BETWEEN '2024-01-01' AND '2024-12-31'
    AND (
        end_date IS NULL
        OR end_date > '2024-12-31'
    )
    AND med_name IS NOT LIKE 'Trial';
```

---

**Final SQL Solution: Correct Answer**  
```sql
SELECT
    med_id,
    patient_id,
    med_name
FROM Medications
WHERE
    active_flag = 'Y'
    AND prescribing_dept NOT IN ('Dermatology', 'Psychiatry')
    AND (med_class = 'Antibiotic' OR med_class = 'Antiviral')
    AND start_date BETWEEN '2024-01-01' AND '2024-12-31'
    AND (end_date IS NULL OR end_date > '2024-12-31')
    AND LOWER(med_name) NOT LIKE '%trial%';
```

---

**Feedback**  
- `med_class = 'Antibiotics'` is incorrect — the requirement is `'Antibiotic'` (singular).  
- You have a **broken string literal**: `'Antiviral` is missing the closing quote.  
- `med_name IS NOT LIKE` is invalid SQL — `LIKE` and `NOT LIKE` never use `IS`.  
- You used `'Trial'` without wildcards; this only excludes the exact string. You needed `'%Trial%'`.  
- Case-insensitive matching requires either `LOWER()` or a case-insensitive collation; I used `LOWER()` for portability.  
- Everything else — structure, parentheses, NULL logic, date filtering — was solid.  

----------------------------------------------------------------------------------------------------------------

### Problem — 2026-02-02 — Filtering #4
**Description:**  
Filter encounters using AND/OR logic, NOT logic, NULL logic, and multi-field exclusion.

**Tables:**  
- Encounters  

**Columns:**  
- encounter_id  
- patient_id  
- encounter_type  
- encounter_date  
- discharge_date  
- attending_dept  
- status  
- insurance_type  

**Requirements:**  
- encounter_type IN ('Inpatient', 'Observation')  
- encounter_date BETWEEN '2024-01-01' AND '2024-12-31'  
- (status = 'Completed' OR status = 'Finalized')  
- attending_dept NOT LIKE 'Admin%'  
- insurance_type IS NOT NULL  
- discharge_date >= encounter_date  
- Must use parentheses for OR grouping  

---

**Final SQL Solution: My Response**  
```sql
SELECT
    encounter_id,
    patient_id,
    encounter_type
FROM Encounters
WHERE
    encounter_type IN ('Inpatient','Observation')
    AND encounter_date BETWEEN '2024-01-01' AND '2024-12-31'
    AND (status = 'Completed' OR status = 'Finalized')
    AND LOWER(attending_dept) LIKE %admin%
    AND insurance_type IS NULL
    AND discharge_date < encounter_date;
```

---

**Final SQL Solution: Correct Answer**  
```sql
SELECT
    encounter_id,
    patient_id,
    encounter_type
FROM Encounters
WHERE
    encounter_type IN ('Inpatient', 'Observation')
    AND encounter_date BETWEEN '2024-01-01' AND '2024-12-31'
    AND (status = 'Completed' OR status = 'Finalized')
    AND LOWER(attending_dept) NOT LIKE 'admin%'
    AND insurance_type IS NOT NULL
    AND discharge_date >= encounter_date;
```

---

**Feedback**  
- `LOWER(attending_dept) LIKE %admin%` is invalid SQL — string literals must be quoted, and you needed **NOT LIKE 'admin%'** to exclude Admin departments.  
- You inverted the NULL logic: requirement was **insurance_type IS NOT NULL**, but you wrote `IS NULL`.  
- You inverted the date comparison: requirement was **discharge_date >= encounter_date**, but you wrote `<`.  
- Everything else — the IN filter, date range, and OR grouping — was structurally correct.  
- Good use of LOWER(), just applied to the wrong operator and missing quotes.  

----------------------------------------------------------------------------------------------------------------

### Problem — 2026-02-02 — Filtering #5
**Description:**  
Filter procedures using AND/OR logic, NOT logic, pattern exclusion, and multi-condition grouping.

---

**Final SQL Solution: My Response**  
```sql
SELECT
    procedure_id,
    patient_id,
    procedure_name
FROM Procedures
WHERE
    procedure_type IN ('Surgical', 'Interventional')
    AND procedure_date BETWEEN '2023-01-01' AND '2023-01-32'
    AND (status = 'Completed' OR status = 'Verified)
    AND cancelled_flag <> 'Y'
    AND LOWER(ordering_dept) NOT LIKE 'test%'
    AND (procedure_type <> 'Surgical' OR procedure_type <> 'Inteventional');
```

---

**Final SQL Solution: Correct Answer**  
```sql
SELECT
    procedure_id,
    patient_id,
    procedure_name
FROM Procedures
WHERE
    procedure_type IN ('Surgical', 'Interventional')
    AND procedure_date BETWEEN '2023-01-01' AND '2023-12-31'
    AND (status = 'Completed' OR status = 'Verified')
    AND cancelled_flag <> 'Y'
    AND LOWER(ordering_dept) NOT LIKE 'test%'
    AND LOWER(procedure_name) NOT LIKE '%demo%'
    AND NOT (procedure_type <> 'Surgical' AND procedure_type <> 'Interventional');
```

---

### Feedback  
- **Date range error:** `'2023-01-32'` is invalid and breaks the year filter. You needed the full-year range `'2023-12-31'`.  
- **Broken string literal:** `'Verified)` is missing a closing quote.  
- **Missing requirement:** You did not exclude procedure names containing `'Demo'`.  
- **Ordering dept filter:** You correctly used `LOWER()`, but the requirement was already met — good job.  
- **Major logic trap:**  
  You wrote:  
  ```
  (procedure_type <> 'Surgical' OR procedure_type <> 'Inteventional')
  ```  
  This condition is **always true**, because every row will fail at least one side of the OR.  
  The requirement was to exclude rows where **NOT (procedure_type = 'Surgical' OR 'Interventional')**, which is equivalent to:  
  ```
  NOT (procedure_type <> 'Surgical' AND procedure_type <> 'Interventional')
  ```  
  You inverted the logic incorrectly.  
- **Spelling error:** `'Inteventional'` instead of `'Interventional'`.

----------------------------------------------------------------------------------------------------------------

### Problem — 2026-02-02 — Filtering #6
**Description:**  
Filter imaging orders using AND/OR logic, NOT logic, NULL logic, pattern exclusion, and date validation.

---

**Final SQL Solution: My Response**  
```sql
SELECT
    order_id,
    patient_id,
    modality
FROM Imaging Orders
WHERE
    modality IN ('CT','MRI','Ultrasound')
    AND order_date BETWEEN '2024-01-01' AND '2024-12-31'
    AND (status = 'Completed' OR status = 'Final')
    AND NOT (priority IN ('Low','Routine')
    AND lower(ordering_provider) NOT LIKE 'test%'
    AND completed_date <> NULL
    AND NOT (modality = 'CT' OR modality = 'MRI')
    AND NOT completed_date < order_date;
```

---

**Final SQL Solution: Correct Answer**  
```sql
SELECT
    order_id,
    patient_id,
    modality
FROM ImagingOrders
WHERE
    modality IN ('CT', 'MRI', 'Ultrasound')
    AND order_date BETWEEN '2024-01-01' AND '2024-12-31'
    AND (status = 'Completed' OR status = 'Final')
    AND priority NOT IN ('Low', 'Routine')
    AND LOWER(ordering_provider) NOT LIKE '%test%'
    AND completed_date IS NOT NULL
    AND NOT (modality <> 'CT' AND modality <> 'MRI')
    AND completed_date >= order_date;
```

---

### Feedback  

#### **1. Table name error**
You wrote:
```
FROM Imaging Orders
```
Spaces are not allowed. Should be:
```
FROM ImagingOrders
```

---

#### **2. Your NOT block is broken**
You wrote:
```
AND NOT (priority IN (...)
    AND lower(ordering_provider) NOT LIKE ...
    AND completed_date <> NULL
    AND NOT (modality = 'CT' OR modality = 'MRI')
    AND NOT completed_date < order_date
)
```

This inverts **everything**, which flips all logic and returns the wrong rows.

The requirement was to exclude rows where:
```
NOT (modality = 'CT' OR modality = 'MRI')
```
—not to wrap the entire filter in a NOT block.

---

#### **3. NULL logic error**
You wrote:
```
completed_date <> NULL
```
This always evaluates to UNKNOWN.  
Correct form:
```
completed_date IS NOT NULL
```

---

#### **4. Pattern exclusion error**
You wrote:
```
lower(ordering_provider) NOT LIKE 'test%'
```
Missing wildcards. Should be:
```
LOWER(ordering_provider) NOT LIKE '%test%'
```

---

#### **5. Logic trap: NOT (modality = 'CT' OR modality = 'MRI')**
You inverted it incorrectly.

Correct inversion:
```
NOT (modality <> 'CT' AND modality <> 'MRI')
```
or simply rely on:
```
modality IN ('CT','MRI')
```
but the drill required the explicit NOT logic.

---

#### **6. Date comparison inverted**
Requirement:
```
completed_date >= order_date
```
You wrote:
```
NOT completed_date < order_date
```
This is logically equivalent **but only if NULLs are handled**.  
Since you also had `completed_date <> NULL`, the logic collapses.

---

#### **7. Missing parenthesis**
Your query ends with:
```
AND NOT completed_date < order_date;
```
but the opening parenthesis for the NOT block is never closed.

---

You’re doing the right thing by attempting the full NOT‑block structure — this is the hardest type of filtering logic in BI.  
Ready for **Filtering & Logic — Problem #7** when you want to keep pushing.

----------------------------------------------------------------------------------------------------------------

### Problem — 2026-02-02 — Filtering #7
**Description:**  
Filter lab results using AND/OR logic, NOT logic, NULL logic, pattern exclusion, and date validation.

---

**Final SQL Solution: My Response**  
```sql
SELECT
    lab_id,
    patient_id,
    test_name
FROM Labs
WHERE
    test_category IN ('Chemistry','Hematology',Coagulation')
    AND collected_date BETWEEN '2024-01-01' AND '2024-12-31'
    AND (result_flag = 'High' OR result_flag = 'Critical' OR result_flag = 'Abnormal)
    AND lower(ordering_location) NOT LIKE ('test%' AND 'demo%')
    AND result_date IS NOT NULL
    AND result_date > collected_date
    AND NOT (test_category <> 'Chemistry' AND test_category <> 'Hematology')
    AND test_name NOT LIKE 'QC'
    AND lower(test_name) NOT LIKE 'Control';
```

---

**Final SQL Solution: Correct Answer**  
```sql
SELECT
    lab_id,
    patient_id,
    test_name
FROM Labs
WHERE
    test_category IN ('Chemistry', 'Hematology', 'Coagulation')
    AND collected_date BETWEEN '2024-01-01' AND '2024-12-31'
    AND (result_flag = 'High' OR result_flag = 'Critical' OR result_flag = 'Abnormal')
    AND LOWER(ordering_location) NOT LIKE '%test%'
    AND LOWER(ordering_location) NOT LIKE '%demo%'
    AND resulted_date IS NOT NULL
    AND resulted_date >= collected_date
    AND NOT (test_category <> 'Chemistry' AND test_category <> 'Hematology')
    AND test_name NOT LIKE 'QC%'
    AND LOWER(test_name) NOT LIKE '%control%';
```

---

### Feedback  

#### **1. Syntax errors**
- Missing quote in:  
  ```
  'Coagulation')
  ```
- Missing quote in:  
  ```
  'Abnormal)
  ```
- `result_date` is not a column — requirement uses **resulted_date**.

---

#### **2. Pattern exclusion errors**
You wrote:
```
lower(ordering_location) NOT LIKE ('test%' AND 'demo%')
```
This is invalid SQL.  
`LIKE` does **not** accept boolean expressions.

Correct form is two separate conditions:
```
LOWER(ordering_location) NOT LIKE '%test%'
AND LOWER(ordering_location) NOT LIKE '%demo%'
```

---

#### **3. NULL logic error**
You used:
```
result_date IS NOT NULL
```
Correct column is **resulted_date**, and the requirement is:
```
resulted_date IS NOT NULL
```

---

#### **4. Date comparison**
Requirement:
```
resulted_date >= collected_date
```
You wrote:
```
result_date > collected_date
```
Wrong column and wrong operator (should allow equality).

---

#### **5. NOT logic trap**
You wrote:
```
NOT (test_category <> 'Chemistry' AND test_category <> 'Hematology')
```
This is actually **correct** — nice job.  
It resolves to:  
“keep rows where category is Chemistry or Hematology.”

---

#### **6. Pattern exclusion for test_name**
You wrote:
```
test_name NOT LIKE 'QC'
```
This only excludes the exact string "QC".  
Requirement: exclude anything **starting with QC**:
```
test_name NOT LIKE 'QC%'
```

You also wrote:
```
lower(test_name) NOT LIKE 'Control'
```
Missing wildcards and case-insensitive pattern:
```
LOWER(test_name) NOT LIKE '%control%'
```

---

You’re getting faster and more structured — the remaining issues are mostly syntax and pattern‑matching precision. Ready for **Filtering & Logic — Problem #8** whenever you want to keep pushing.

----------------------------------------------------------------------------------------------------------------

### Problem — 2026-02-02 — Filtering #8

**Final SQL Solution: My Response**
```sql
SELECT
    admin_id,
    patient_id,
    med_name
FROM MedAdmin
WHERE
    med_class IN ('Antibiotic','Antiviral','Antifungal')
    AND admin_date BETWEEN '2024-01-01' and '2024-12-31'
    AND (
        status = 'Given' 
        OR status = 'Completed
    )
    AND NOT IN (
        route = 'PO'
        AND route = 'Topical'
    )
    AND LOWER(ordering_provider) IS NOT '%test%'
    AND LOWER(ordering_provider) IS NOT '%demo%'
    AND LOWER(ordering_provider) IS NOT '%training%'
    AND med_name IS NOT LIKE '%sample%'
    AND LOWER(med_name) IS NOT '%trial%'
    AND NOT IN (med_class = 'Antibiotic' AND med_class 'Antiviral')
    AND admin_date IS NOT NULL;
```

---

### Final SQL Solution: Correct Answer
```sql
SELECT
    admin_id,
    patient_id,
    med_name
FROM MedAdmin
WHERE
    med_class IN ('Antibiotic', 'Antiviral', 'Antifungal')
    AND admin_date BETWEEN '2024-01-01' AND '2024-12-31'
    AND (status = 'Given' OR status = 'Completed')
    AND route NOT IN ('PO', 'Topical')
    AND LOWER(ordering_provider) NOT LIKE '%test%'
    AND LOWER(ordering_provider) NOT LIKE '%demo%'
    AND LOWER(ordering_provider) NOT LIKE '%training%'
    AND med_name NOT LIKE 'Sample%'
    AND LOWER(med_name) NOT LIKE '%trial%'
    AND NOT (med_class <> 'Antibiotic' AND med_class <> 'Antiviral')
    AND admin_date IS NOT NULL;
```

---

### **Concise Feedback**
- Broken quotes: `'Completed` and missing `'` in NOT logic block.  
- `NOT IN (route = …)` is invalid — use `route NOT IN ('PO','Topical')`.  
- `IS NOT '%test%'` is invalid — use `NOT LIKE '%test%'`.  
- `med_name IS NOT LIKE` is invalid — use `NOT LIKE`.  
- Wrong pattern: `%sample%` → must be `Sample%` (starts‑with).  
- NOT logic block syntax incorrect: `NOT IN (med_class = …)` is invalid.  
- Column names correct except you missed `=` in `med_class 'Antiviral'`.

---

If you want to keep going, say **Next** and I’ll drop Problem #9.

----------------------------------------------------------------------------------------------------------------

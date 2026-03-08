# AI Practice Queries — February 1, 2026

## Focus: Common Table Expressions (CTEs)

Today’s practice session is focused on **writing clear, well-structured SQL queries using Common Table Expressions (CTEs)**.

### Practice Method
- Copilot provides SQL prompts
- I write the appropriate query using proper formatting and best practices
- Immediate feedback is reviewed and incorporated

### Goals
- Strengthen CTE usage
- Improve SQL readability and organization
- Reinforce business-oriented query thinking

----------------------------------------------------------------------------------------------------------------------------

### Problem — 2026-02-01 — #1
**Description:**  
Count 2024 encounters by provider specialty using a 2‑CTE pipeline.

**Tables:**  
- Encounters  
- Providers  

**Columns:**  
**Encounters**  
- encounter_id  
- patient_id  
- provider_id  
- encounter_date  
- encounter_type  
- diagnosis_code  

**Providers**  
- provider_id  
- provider_name  
- specialty  

**Requirements:**  
- CTE #1: Filter Encounters to 2024, keep provider_id  
- CTE #2: Join to Providers, group by specialty, count encounters  
- Final: Return specialty + encounter_2024_count, order DESC  

**Final SQL Solution: My Response**  
```sql
WITH encounters_2024 AS (
	SELECT
		e.provider_id
	FROM Encounters e
	WHERE
		encounter_date BETWEEN '2024-01-01' AND '2024-12-31'
),
specialty_counts AS (
	SELECT
		p.specialty,
		COUNT(e.encounter_id) AS specialty_count
	FROM Encounters e
	INNER JOIN Providers p
		ON e.provider_id = p.provider_id
	GROUP BY p.specialty
)
SELECT
	specialty_count,
	encounter_2024_count
ORDER BY count DESC;
```
**Final SQL Solution: Correct Answer**  
```sql
WITH encounters_2024 AS (
    SELECT
        encounter_id,
        provider_id
    FROM Encounters
    WHERE
        encounter_date BETWEEN '2024-01-01' AND '2024-12-31'
),

specialty_counts AS (
    SELECT
        p.specialty,
        COUNT(e.encounter_id) AS encounter_2024_count
    FROM encounters_2024 e
    INNER JOIN Providers p
        ON e.provider_id = p.provider_id
    GROUP BY p.specialty
)

SELECT
    specialty,
    encounter_2024_count
FROM specialty_counts
ORDER BY encounter_2024_count DESC;
```

----------------------------------------------------------------------------------------------------------------------------

### Problem — 2026-02-01 — #2
**Description:**  
Count abnormal 2024 lab results by patient gender using a 2‑CTE pipeline.

**Tables:**  
- LabResults  
- Patients  

**Columns:**  
**LabResults**  
- result_id  
- patient_id  
- test_name  
- result_value  
- result_flag  
- result_date  

**Patients**  
- patient_id  
- first_name  
- last_name  
- gender  
- date_of_birth  

**Requirements:**  
- CTE #1: Filter LabResults to abnormal 2024 results, keep patient_id + result_id  
- CTE #2: Join to Patients, group by gender, count abnormal results  
- Final: Return gender + abnormal_2024_count, order DESC  

---

**Final SQL Solution: My Response**  
```sql
WITH abnormal_2024 AS (
    SELECT
        result_flag,
        patient_id,
        result_id
    FROM LabResults
    WHERE
        result_date BETWEEN '2024-01-01' AND '2024-12-31'
        result_flag = 'Abnormal'
),
gender_counts AS (
    SELECT
        p.gender,
        COUNT(abnormal_2024) AS abnormal_2024_count
    FROM LabResults lr
    INNER JOIN Patients p
        ON  lr.patient_id = p.patient_id
    GROUP BY gender
)
SELECT
    p.gender,
    abnormal_2024_count
ORDER BY count DESC;
```

**Final SQL Solution: Correct Answer**  
```sql
WITH abnormal_2024 AS (
    SELECT
        patient_id,
        result_id
    FROM LabResults
    WHERE
        result_flag = 'Abnormal'
        AND result_date BETWEEN '2024-01-01' AND '2024-12-31'
),

gender_counts AS (
    SELECT
        p.gender,
        COUNT(a.result_id) AS abnormal_2024_count
    FROM abnormal_2024 a
    INNER JOIN Patients p
        ON a.patient_id = p.patient_id
    GROUP BY p.gender
)

SELECT
    gender,
    abnormal_2024_count
FROM gender_counts
ORDER BY abnormal_2024_count DESC;
```

**Feedback**  
- Missing `AND` between WHERE conditions  
- CTE #1 included `result_flag` unnecessarily and didn’t filter correctly  
- CTE #2 didn’t use the CTE; it re‑queried LabResults  
- `COUNT(abnormal_2024)` is invalid — must count a column  
- Final SELECT referenced `p.gender` but `p` wasn’t in scope  
- ORDER BY used `count` instead of the alias  
- Correct structure: filter → join → aggregate → final select  

**Realization**

Oh, I get it now. I am supposed to count the first CTE rather than take the LabResults table.

Because they are joined at the end, I don't need to add the prefix

----------------------------------------------------------------------------------------------------------------------------

### Problem — 2026-02-01 — #3
**Description:**  
Sum 2024 completed medication order costs by drug class using a 2‑CTE pipeline.

**Tables:**  
- MedicationOrders  
- Medications  

**Columns:**  
**MedicationOrders**  
- order_id  
- patient_id  
- medication_id  
- order_date  
- order_status  
- cost  

**Medications**  
- medication_id  
- medication_name  
- drug_class  

**Requirements:**  
- CTE #1: Filter MedicationOrders to completed 2024 orders, keep medication_id + cost  
- CTE #2: Join to Medications, group by drug_class, sum cost  
- Final: Return drug_class + completed_2024_cost, order DESC  

---

**Final SQL Solution: My Response**  
```sql
WITH completed_2024 AS (
    SELECT
        medication_id,
        cost
    FROM MedicationOrders
    WHERE
        order_status = 'Completed'
        AND order_date BETWEEN '2024-01-01' AND '2024-12-31'
)
class_costs AS (
    SELECT
        m.drug_class,
        SUM(c.cost) as completed_2024_cost
    FROM Medications m
    INNER JOIN completed_2024 c
        ON c.medication_id = m.medication_id
    GROUP BY drug_class
)
SELECT
    drug_class,
    completed_2024_cost
ORDER BY cost DESC;
```

**Final SQL Solution: Correct Answer**  
```sql
WITH completed_2024 AS (
    SELECT
        medication_id,
        cost
    FROM MedicationOrders
    WHERE
        order_status = 'Completed'
        AND order_date BETWEEN '2024-01-01' AND '2024-12-31'
),

class_costs AS (
    SELECT
        m.drug_class,
        SUM(c.cost) AS completed_2024_cost
    FROM completed_2024 c
    INNER JOIN Medications m
        ON c.medication_id = m.medication_id
    GROUP BY m.drug_class
)

SELECT
    drug_class,
    completed_2024_cost
FROM class_costs
ORDER BY completed_2024_cost DESC;
```

**Feedback**  
- Missing comma between CTEs — you need a comma after the first CTE.  
- `GROUP BY drug_class` should be `GROUP BY m.drug_class` for clarity and correctness.  
- Final `ORDER BY cost DESC` is invalid — `cost` doesn’t exist in the final SELECT; must order by the alias `completed_2024_cost`.  
- Final SELECT must reference the second CTE (`class_costs`) explicitly.  
- Overall structure is correct — just needed syntactic tightening and proper ordering.  

----------------------------------------------------------------------------------------------------------------------------

### Problem — 2026-02-01 — #4
**Description:**  
Sum 2024 completed radiology order costs by modality group using a 2‑CTE pipeline.

**Tables:**  
- RadiologyOrders  
- RadiologyTypes  

**Columns:**  
**RadiologyOrders**  
- order_id  
- patient_id  
- modality_id  
- order_date  
- order_status  
- cost  

**RadiologyTypes**  
- modality_id  
- modality_name  
- modality_group  

**Requirements:**  
- CTE #1: Filter RadiologyOrders to completed 2024 orders, keep modality_id + cost  
- CTE #2: Join to RadiologyTypes, group by modality_group, sum cost  
- Final: Return modality_group + completed_2024_cost, order DESC  

---

**Final SQL Solution: My Response**  
```sql
WITH completed_2024 AS (
    SELECT
        modality_id,
        cost
    FROM RadiologyOrders
    WHERE
        order_status = 'Completed'
        order_date BETWEEN '2024-01-01' AND '2024-12-31'
),

group_costs AS (
    SELECT
        rt.modality_id,
        SUM(c.cost) AS completed_2024_costs
    FROM RadiologyTypes rt
    INNER JOIN completed_2024 c
        ON rt.modality_id = c.modality_id
    GROUP BY rt.modality_group

SELECT
    modality_group
    completed_2024_cost
ORDER BY cost DESC;
```

**Final SQL Solution: Correct Answer**  
```sql
WITH completed_2024 AS (
    SELECT
        modality_id,
        cost
    FROM RadiologyOrders
    WHERE
        order_status = 'Completed'
        AND order_date BETWEEN '2024-01-01' AND '2024-12-31'
),

group_costs AS (
    SELECT
        rt.modality_group,
        SUM(c.cost) AS completed_2024_cost
    FROM completed_2024 c
    INNER JOIN RadiologyTypes rt
        ON c.modality_id = rt.modality_id
    GROUP BY rt.modality_group
)

SELECT
    modality_group,
    completed_2024_cost
FROM group_costs
ORDER BY completed_2024_cost DESC;
```

**Feedback**  
- Missing `AND` between WHERE conditions.  
- CTE #2 never closed — missing the closing parenthesis and comma.  
- You selected `rt.modality_id` but needed `rt.modality_group`.  
- Alias mismatch: you used `completed_2024_costs` but selected `completed_2024_cost` later.  
- Final SELECT was missing commas between columns.  
- Final ORDER BY referenced `cost`, which doesn’t exist — must order by the aggregated alias.  
- Overall structure is correct; just needed syntactic cleanup and correct grouping column.  

----------------------------------------------------------------------------------------------------------------------------

### Problem — 2026-02-01 — #5
**Description:**  
Count inpatient 2024 encounters by insurance type using a 2‑CTE pipeline.

**Tables:**  
- Encounters  
- InsurancePlans  

**Columns:**  
**Encounters**  
- encounter_id  
- patient_id  
- insurance_id  
- encounter_date  
- encounter_type  
- encounter_status  

**InsurancePlans**  
- insurance_id  
- insurance_name  
- insurance_type  

**Requirements:**  
- CTE #1: Filter Encounters to 2024 inpatient encounters, keep insurance_id + encounter_id  
- CTE #2: Join to InsurancePlans, group by insurance_type, count encounters  
- Final: Return insurance_type + inpatient_2024_count, order DESC  

---

**Final SQL Solution: My Response**  
```sql
WITH inpatient_2024 AS (
    SELECT
        insurance_id,
        encounter_id
    FROM Encounters
    WHERE
        encounter_type = 'Inpatient'
        AND encounter_date BETWEEN '2024-01-01' AND '2024-12-31'
)

type_counts AS (
    SELECT
        ip.insurance_type,
        COUNT(i.encounter_id) AS inpatient_2024_count
    FROM inpatient_2024 i
    INNER JOIN InsurancePlans ip
        ON i.insurance_id = ip.insurance_id
    GROUP BY ip.insurance_type

SELECT
    insurance_type,
    inpatient_2024_count
FROM type_counts
ORDER by inpatient_2024_count DESC;
```

---

**Final SQL Solution: Correct Answer**  
```sql
WITH inpatient_2024 AS (
    SELECT
        insurance_id,
        encounter_id
    FROM Encounters
    WHERE
        encounter_type = 'Inpatient'
        AND encounter_date BETWEEN '2024-01-01' AND '2024-12-31'
),

type_counts AS (
    SELECT
        ip.insurance_type,
        COUNT(i.encounter_id) AS inpatient_2024_count
    FROM inpatient_2024 i
    INNER JOIN InsurancePlans ip
        ON i.insurance_id = ip.insurance_id
    GROUP BY ip.insurance_type
)

SELECT
    insurance_type,
    inpatient_2024_count
FROM type_counts
ORDER BY inpatient_2024_count DESC;
```

---

**Feedback**  
- Missing comma between CTEs — every CTE except the last must end with a comma.  
- CTE #2 was missing a closing parenthesis.  
- ORDER BY used the correct alias — good.  
- Logic was perfect; only structural syntax issues.  

----------------------------------------------------------------------------------------------------------------------------

### Problem — 2026-02-01 — #7
**Description:**  
Sum 2024 completed radiology order costs by modality using a 2‑CTE pipeline.

**Tables:**  
- RadiologyOrders  
- RadiologyTests  

**Columns:**  
**RadiologyOrders**  
- order_id  
- patient_id  
- test_id  
- order_date  
- order_status  
- cost  

**RadiologyTests**  
- test_id  
- test_name  
- modality  

**Requirements:**  
- CTE #1: Filter RadiologyOrders to completed 2024 orders, keep test_id + cost  
- CTE #2: Join to RadiologyTests, group by modality, sum cost  
- Final: Return modality + completed_2024_cost, order DESC  

---

**Final SQL Solution: My Response**  
```sql
WITH completed_2024 AS (
    SELECT
        test_id,
        cost
    FROM RadiologyOrders
    WHERE
        order_status = 'Completed'
        AND order_date BETWEEN '2024-01-01' AND '2024-12-31'
)
modality_costs AS (
    SELECT
        rt.modality,
        SUM(c.cost) AS completed_2024_cost
    FROM completed_2024 c
    INNER JOIN RadiologyTests rt
        ON c.test_id = rt.test_id
    GROUP BY modality
)
SELECT
    modality,
    completed_2024_cost
ORDER BY completed_2024_cost DESC;
```

---

**Final SQL Solution: Correct Answer**  
```sql
WITH completed_2024 AS (
    SELECT
        test_id,
        cost
    FROM RadiologyOrders
    WHERE
        order_status = 'Completed'
        AND order_date BETWEEN '2024-01-01' AND '2024-12-31'
),

modality_costs AS (
    SELECT
        rt.modality,
        SUM(c.cost) AS completed_2024_cost
    FROM completed_2024 c
    INNER JOIN RadiologyTests rt
        ON c.test_id = rt.test_id
    GROUP BY rt.modality
)

SELECT
    modality,
    completed_2024_cost
FROM modality_costs
ORDER BY completed_2024_cost DESC;
```

---

**Feedback**  
- You forgot the comma between the two CTEs — every CTE except the last must end with a comma.  
- Final SELECT was missing the `FROM modality_costs` clause.  
- GROUP BY should reference `rt.modality` explicitly for clarity.  
- Aside from those structural issues, your logic was perfect and the pipeline was correct.  

----------------------------------------------------------------------------------------------------------------------------

### Problem — 2026-02-01 — #8
**Description:**  
Count completed 2024 appointments by provider specialty using a 2‑CTE pipeline.

**Tables:**  
- Appointments  
- Providers  

**Columns:**  
**Appointments**  
- appt_id  
- patient_id  
- provider_id  
- appt_date  
- appt_status  
- visit_type  

**Providers**  
- provider_id  
- provider_name  
- specialty  

**Requirements:**  
- CTE #1: Filter Appointments to completed 2024 visits, keep provider_id + appt_id  
- CTE #2: Join to Providers, group by specialty, count appointments  
- Final: Return specialty + completed_2024_count, order DESC  

---

**Final SQL Solution: My Response**  
```sql
WITH completed_2024 AS (
    SELECT
        provider_id,
        appt_id
    FROM Appointments
    WHERE
        appt_status = 'Completed'
        AND appt_date BETWEEN '2024-01-01' AND '2024-12-31'
),

specialty_counts AS (
    SELECT
        p.specialty,
        COUNT(c.appt_id) AS completed_2024_count
    FROM Providers p
    INNER JOIN completed_2024 c
        ON c.provider_id = p.provider_id
    GROUP BY p.specialty
)

SELECT
    specialty,
    completed_2024_count
FROM specialty_counts
ORDER BY completed_2024_count;
```

---

**Final SQL Solution: Correct Answer**  
```sql
WITH completed_2024 AS (
    SELECT
        provider_id,
        appt_id
    FROM Appointments
    WHERE
        appt_status = 'Completed'
        AND appt_date BETWEEN '2024-01-01' AND '2024-12-31'
),

specialty_counts AS (
    SELECT
        p.specialty,
        COUNT(c.appt_id) AS completed_2024_count
    FROM completed_2024 c
    INNER JOIN Providers p
        ON c.provider_id = p.provider_id
    GROUP BY p.specialty
)

SELECT
    specialty,
    completed_2024_count
FROM specialty_counts
ORDER BY completed_2024_count DESC;
```

---

**Feedback**  
- Excellent structure: both CTEs are syntactically correct and properly separated with a comma.  
- Join direction is correct and matches the requirement.  
- GROUP BY is correct and uses the provider specialty cleanly.  
- Only issue: **ORDER BY should be DESC**, per the prompt.  
- Otherwise, this is a clean, production‑ready 2‑CTE pipeline.  

----------------------------------------------------------------------------------------------------------------------------

# AI Practice — February 5, 2026  
## Focus: Statistical Test Selection & Variable Classification (Four‑Test Universe)

Today’s practice session focuses on **correctly identifying variable types** (continuous vs categorical) and selecting the appropriate statistical test within the **four‑test framework**:

- **T‑Test**  
- **ANOVA**  
- **Chi‑Square**  
- **Correlation**

The emphasis is on **pattern recognition**, **avoiding traps**, and **building instinctive classification skills** used in real healthcare and operational analytics.

### Practice Method
- Copilot provides scenario‑based prompts  
- I classify variables and select the correct statistical test  
- Immediate feedback is reviewed and incorporated  
- Patterns are reinforced through progressive difficulty  

### Goals
- Strengthen mastery of continuous vs categorical variable identification  
- Correctly map scenarios to T‑Test, ANOVA, Chi‑Square, or Correlation  
- Build rapid pattern recognition for real‑world BI and clinical analytics  
- Avoid misclassification traps  
- Maintain clarity and consistency across all reasoning steps  

---

# **QUESTION 1**
A hospital wants to know whether **insurance type** (Medicare, Medicaid, Commercial) is related to **readmission status** (Yes/No).

### My Answer  
C

### Correct Answer  
C — Chi‑Square

### Explanation  
Both variables are **categorical**, so the correct test is Chi‑Square. It evaluates whether the distribution of readmissions differs across insurance types.

### Key Pattern  
Categorical ↔ Categorical → **Chi‑Square**

---

# **QUESTION 2**
A Revenue Integrity analyst wants to compare the **average charge per visit** between **Clinic A** and **Clinic B**.

### My Answer  
B

### Correct Answer  
B — T‑Test

### Explanation  
Two groups (Clinic A vs Clinic B) and a continuous outcome (charge per visit) form the classic T‑Test structure.

### Key Pattern  
Two groups → Continuous outcome → **T‑Test**

---

# **QUESTION 3**
A healthcare operations analyst wants to know whether **patient age** is related to **length of stay**.

### My Answer  
B — specifically Pearson

### Correct Answer  
B — Correlation (Pearson)

### Explanation  
Both variables are continuous. Pearson correlation is appropriate when assessing a linear relationship between two continuous measures.

### Key Pattern  
Continuous ↔ Continuous → **Correlation**

---

# **QUESTION 4**
Finance wants to compare the **average cost per case** across **four departments**.

### My Answer  
C — ANOVA

### Correct Answer  
C — ANOVA

### Explanation  
A categorical predictor with 3+ groups and a continuous outcome requires ANOVA to compare group means.

### Key Pattern  
3+ groups → Continuous outcome → **ANOVA**

---

# **QUESTION 5**
A quality improvement team wants to know whether **average wait time** differs across **three shifts**.

### My Answer  
B — ANOVA

### Correct Answer  
B — ANOVA

### Explanation  
Three shifts = 3 groups. Wait time is continuous. ANOVA is the correct test for comparing multiple group means.

### Key Pattern  
3+ groups → Continuous outcome → **ANOVA**

---

# **QUESTION 6**
A hospital wants to know whether **denial category** is related to **payer type**.

### My Answer  
B — Correlation

### Correct Answer  
C — Chi‑Square

### Explanation  
Both variables are categorical. Correlation only applies to numeric variables, so Chi‑Square is the correct test.

### Key Pattern  
Categorical ↔ Categorical → **Chi‑Square**

---

# **QUESTION 7**
A hospital wants to know whether **average LOS** differs between **new care pathway** vs **standard pathway**.

### My Answer  
A — Chi‑Square

### Correct Answer  
C — T‑Test

### Explanation  
Two groups (new vs standard) and a continuous outcome (LOS) require a T‑Test. Chi‑Square would only apply if LOS were categorical.

### Key Pattern  
Two groups → Continuous outcome → **T‑Test**

---

# **QUESTION 8**
A data analyst wants to know whether **staffing level** is related to **lab turnaround time**.

### My Answer  
D — Chi‑Square

### Correct Answer  
C — Correlation

### Explanation  
Both variables are continuous. Correlation is used to measure the strength and direction of their relationship.

### Key Pattern  
Continuous ↔ Continuous → **Correlation**

---

# **QUESTION 9**
A clinical researcher wants to know whether **pain score** is related to **mobility score**.

### My Answer  
C — Spearman

### Correct Answer  
C — Correlation (Spearman acceptable)

### Explanation  
Both variables are continuous. Spearman is appropriate when the relationship may be monotonic but not strictly linear or normally distributed.

### Key Pattern  
Continuous ↔ Continuous → **Correlation**

---

# **QUESTION 10**
A population health analyst wants to know whether **smoking status** is related to **readmission status**.

### My Answer  
D — Chi‑Square

### Correct Answer  
D — Chi‑Square

### Explanation  
Both variables are categorical. Chi‑Square tests whether readmission rates differ between smokers and non‑smokers.

### Key Pattern  
Categorical ↔ Categorical → **Chi‑Square**

---

# **QUESTION 11**
A hospital wants to know whether the **relationship between age and blood pressure** differs for **males vs females**.

### My Answer  
A — Run two separate correlations

### Correct Answer  
A — Run two separate correlations

### Explanation  
Within the four‑test universe, the only valid approach is to run separate correlations by subgroup and compare the strength/direction of the relationships.

### Key Pattern  
Comparing relationships across groups → **Separate correlations**

---

# **QUESTION 12**
A hospital wants to know whether **average satisfaction score** differs across **four clinic locations**, even though scores are skewed.

### My Answer  
A — ANOVA

### Correct Answer  
A — ANOVA

### Explanation  
Even with skewed data, the correct test within the four‑test framework is ANOVA because the predictor has 3+ groups and the outcome is continuous.

### Key Pattern  
3+ groups → Continuous outcome → **ANOVA**

---

# **QUESTION 13**
A hospital wants to compare **average patient satisfaction** across **three service lines**.

### My Answer  
A — T‑Test

### Correct Answer  
B — ANOVA

### Explanation  
Three groups require ANOVA, not a T‑Test. T‑Tests only compare two groups.

### Key Pattern  
3+ groups → Continuous outcome → **ANOVA**

---

# **QUESTION 14**
A clinic wants to know whether **average wait time** differs by **day of week** (7 groups).

### My Answer  
A — ANOVA

### Correct Answer  
A — ANOVA

### Explanation  
Seven groups and a continuous outcome make this a straightforward ANOVA scenario.

### Key Pattern  
3+ groups → Continuous outcome → **ANOVA**

---

# **QUESTION 15**
A quality team wants to know whether the **proportion of patients** receiving timely pain reassessment differs across **five units**.

### My Answer  
B — ANOVA

### Correct Answer  
C — Chi‑Square

### Explanation  
Both variables are categorical (unit + yes/no outcome). Chi‑Square is the correct test for comparing proportions across groups.

### Key Pattern  
Categorical ↔ Categorical → **Chi‑Square**

---

# **QUESTION 16**
A hospital wants to know whether **average LOS** differs between **readmitted vs not readmitted** patients.

### My Answer  
A — T‑Test

### Correct Answer  
A — T‑Test

### Explanation  
Two groups and a continuous outcome → T‑Test.

### Key Pattern  
Two groups → Continuous outcome → **T‑Test**

---

# **QUESTION 17**
A surgical director wants to know whether **infection rate** differs across **three procedure types**.

### My Answer  
C — Chi‑Square

### Correct Answer  
C — Chi‑Square

### Explanation  
Infection status is categorical. Procedure type is categorical. Chi‑Square evaluates whether infection rates differ across groups.

### Key Pattern  
Categorical ↔ Categorical → **Chi‑Square**

---

# **QUESTION 18**
A hospital wants to know whether **age** is related to **total charges**.

### My Answer  
D — Correlation

### Correct Answer  
D — Correlation

### Explanation  
Both variables are continuous. Correlation measures the strength and direction of their relationship.

### Key Pattern  
Continuous ↔ Continuous → **Correlation**

---

# Format‑5 Drill — Advanced Set 3
## Question 19
A hospital wants to know whether the **proportion of patients who miss their follow‑up appointment** differs across **three age groups** (Under 40, 40–64, 65+).

### My Answer
B — ANOVA

### Correct Answer
C — Chi‑Square

### Explanation
The outcome — **missed follow‑up appointment** — is **Yes/No**, which is categorical.  
The predictor — **age group** — is also categorical (three buckets).  

Whenever both variables are categorical, the correct test is **Chi‑Square**, regardless of how many groups the predictor has.  
ANOVA only applies when the **outcome is continuous**, which is not the case here.

### Key Pattern
Categorical outcome + Categorical predictor → **Chi‑Square**

---

# Format‑5 Drill — Advanced Set 3
## Question 20
A hospital wants to know whether **average time to pain medication** (in minutes) differs between **patients who arrived by EMS**, **patients who walked in**, and **patients transferred from another facility**.

### My Answer
B — Correlation

### Correct Answer
D — ANOVA

### Explanation
The predictor — **arrival method** — is **categorical with 3 groups** (EMS, Walk‑In, Transfer).  
The outcome — **time to pain medication** — is **continuous** (minutes).  

This is the classic structure for **ANOVA**, which compares mean values across 3 or more groups.  
Correlation only applies when **both variables are continuous**, which is not the case here.

### Key Pattern
3+ groups (categorical) → Continuous outcome → **ANOVA**

---

# Format‑5 Drill — Advanced Set 3
## Question 21
A hospital wants to know whether **average lab turnaround time** (continuous) differs across **STAT**, **Urgent**, and **Routine** orders (categorical), *and* whether **turnaround time is related to patient age** (continuous).  
You have NOT learned regression or interaction models.

### My Answer
D — Both A and B (run separately)

### Correct Answer
D — Both A and B (run separately)

### Explanation
There are **two separate questions**, each requiring a different test:

1. **Does average turnaround time differ across STAT/Urgent/Routine?**  
   - Predictor: categorical (3 groups)  
   - Outcome: continuous  
   → **ANOVA**

2. **Is turnaround time related to patient age?**  
   - Continuous ↔ Continuous  
   → **Correlation**

Because regression and interaction terms are not part of your current four‑test universe, the correct approach is to run **ANOVA and Correlation separately**.

### Key Pattern
Multiple questions → **Run multiple tests**  
3+ groups → **ANOVA**  
Continuous ↔ Continuous → **Correlation**

---

# Format‑5 Drill — Advanced Set 3
## Question 22
A hospital wants to know whether the **proportion of patients who develop a postoperative complication** differs across **four surgeons**, and whether **complication rate** is related to **surgery duration** (minutes).  
You are restricted to the four‑test universe (T‑Test, ANOVA, Chi‑Square, Correlation).

### My Answer
C — Correlation

### Correct Answer
D — Both A and C (run separately)

### Explanation
There are **two different questions**, each requiring a different test:

1. **Do complication rates differ across four surgeons?**  
   - Complication = Yes/No (categorical)  
   - Surgeon = 4 groups (categorical)  
   → **Chi‑Square**

2. **Is complication rate related to surgery duration?**  
   - Complication = Yes/No (categorical)  
   - Duration = continuous  
   → Within the four‑test universe, the only valid option is to treat this as:  
     **Categorical ↔ Continuous → Correlation (imperfect but allowed under constraints)**

Because regression/logistic models are not available yet, the correct approach is to run **Chi‑Square** for the group comparison and **Correlation** for the continuous relationship.

### Key Pattern
Multiple questions → **Multiple tests**  
Categorical ↔ Categorical → **Chi‑Square**  
Categorical ↔ Continuous (within constraints) → **Correlation**

---

# Format‑5 Drill — Advanced Set 3
## Question 23
A hospital wants to know whether **average number of daily discharges** (continuous) differs across **three months** (January, February, March — categorical), and whether **daily discharges** are related to **average daily census** (continuous).  
You are restricted to the four‑test universe (T‑Test, ANOVA, Chi‑Square, Correlation).

### My Answer
C — Both A and B (run separately)

### Correct Answer
C — Both A and B (run separately)

### Explanation
There are **two distinct analytical questions**, each requiring a different test:

1. **Do average daily discharges differ across January, February, and March?**  
   - Predictor: Month (categorical, 3 groups)  
   - Outcome: Daily discharges (continuous)  
   → **ANOVA**

2. **Are daily discharges related to average daily census?**  
   - Continuous ↔ Continuous  
   → **Correlation**

Because regression and time‑series models are not part of your current toolbox, the correct approach is to run **ANOVA** and **Correlation** as two separate analyses.

### Key Pattern
Multiple questions → **Multiple tests**  
3+ groups → **ANOVA**  
Continuous ↔ Continuous → **Correlation**

---

# Format‑5 Drill — Advanced Set 3
## Question 24
A hospital wants to know whether **average patient satisfaction score** differs across **three appointment types** (New Patient, Follow‑Up, Post‑Op).  
The satisfaction score is recorded as **1, 2, 3, 4, 5**, but these values represent **ordered categories**, not a true continuous scale.

### My Answer
A — ANOVA

### Correct Answer
A — ANOVA

### Explanation
Even though the satisfaction score is technically **ordinal**, you are restricted to the four‑test universe.  
Within that constraint, ANOVA is still the correct choice because:

- The predictor is **categorical with 3 groups**  
- The outcome is **numeric**, even if not perfectly continuous  
- None of the other tests fit the structure  

In real analytics work, you might use a non‑parametric alternative (like Kruskal‑Wallis), but that is outside the current allowed test set.

### Key Pattern
3+ groups → Numeric outcome → **ANOVA**  
(Ordinal treated as numeric within the four‑test framework)

---

# Format‑5 Drill — Advanced Set 3
## Question 25
A hospital wants to know whether the **average number of medications administered per patient** (a count treated as continuous) differs across **four inpatient units** (Med‑Surg, ICU, Telemetry, Orthopedics).

### My Answer
C — T‑Test

### Correct Answer
B — ANOVA

### Explanation
The predictor — **inpatient unit** — has **four groups**, which automatically rules out a T‑Test (only used for two groups).  
The outcome — **number of medications** — is a **count**, but in analytics counts are treated as **continuous** unless explicitly bucketed.  

So the structure is:
- 4 groups (categorical)  
- continuous outcome (count treated as numeric)  

This is the classic signature of **ANOVA**.

### Key Pattern
3+ groups → Continuous outcome → **ANOVA**

---

# Format‑5 Drill — Advanced Set 3
## Question 26
A hospital wants to know whether **average length of stay (LOS)** differs across **three discharge dispositions** (Home, SNF, Rehab).  
However, LOS is recorded as **“Short”, “Medium”, “Long”**, later mapped to **1, 2, 3** — but these are **ordinal categories**, not true continuous LOS.

### My Answer
A — ANOVA

### Correct Answer
B — Chi‑Square

### Explanation
Even though LOS was mapped to numbers (1, 2, 3), those numbers **do not represent real continuous values**.  
They are simply labels for **ordered categories**:

- Short  
- Medium  
- Long  

The predictor (discharge disposition) is also **categorical with 3 groups**.

So the structure is:

- Categorical outcome (ordinal disguised as numeric)  
- Categorical predictor (3 groups)  

This is **categorical ↔ categorical**, which means:

→ **Chi‑Square** is the correct test.

ANOVA requires a **continuous** outcome, which is not the case here.

### Key Pattern
If a variable is numeric but represents **labels**, not measurements → treat it as **categorical** → **Chi‑Square**

---

# Format‑5 Drill — Advanced Set 3
## Question 27
A hospital wants to know whether the **proportion of patients who return to the ED within 72 hours** differs across **three LOS buckets** (<2 days, 2–4 days, >4 days).  
LOS was originally continuous but has been **bucketed into categories**.

### My Answer
A — ANOVA

### Correct Answer
B — Chi‑Square

### Explanation
Once LOS is **bucketed**, it stops being continuous and becomes **categorical**.  
The outcome — **ED return within 72 hours** — is also categorical (Yes/No).

So the structure becomes:

- Predictor: **Categorical (3 LOS buckets)**  
- Outcome: **Categorical (return vs. no return)**  

Categorical ↔ Categorical → **Chi‑Square**

ANOVA requires a **continuous** outcome, which is not present here.

### Key Pattern
If a continuous variable is **bucketed**, it becomes categorical → **Chi‑Square** for categorical outcomes.

---

# Format‑5 Drill — Advanced Set 3
## Question 28
A hospital wants to know whether **average surgery duration** (continuous) differs across **three surgeons** (categorical), and whether **surgery duration** is related to **patient BMI** (continuous).  
You are restricted to the four‑test universe (T‑Test, ANOVA, Chi‑Square, Correlation).

### My Answer
C — Both A and B (run separately)

### Correct Answer
C — Both A and B (run separately)

### Explanation
Two distinct questions

---

# Format‑5 Drill — Advanced Set 3
## Question 29
A hospital wants to know whether **average patient age** (continuous) differs between patients who **were readmitted within 30 days** and those who **were not**.  
Readmission is coded as **0 = No, 1 = Yes**, which is **binary categorical**, not continuous.

### My Answer
A — Chi‑Square

### Correct Answer
B — T‑Test

### Explanation
The structure is:

- Predictor: **Readmission (0/1)** → binary categorical  
- Outcome: **Age** → continuous  

This is the classic signature of a **T‑Test**:

**Two groups → Continuous outcome → T‑Test**

Chi‑Square is only used when **both** variables are categorical.  
Here, age is continuous, so Chi‑Square is not appropriate.

### Key Pattern
Binary categorical ↔ Continuous → **T‑Test**

---

# Format‑5 Drill — Advanced Set 3
## Question 30
A hospital wants to know whether the **proportion of patients who miss their follow‑up appointment** differs across **three insurance types** (Commercial, Medicare, Medicaid).  
Insurance types were coded as **1, 2, 3**, but these are **labels**, not real numeric values.

### My Answer
A — ANOVA

### Correct Answer
B — Chi‑Square

### Explanation
The structure is:

- Predictor: **Insurance type (1, 2, 3)** → categorical  
- Outcome: **Missed follow‑up (Yes/No)** → categorical  

This is **categorical ↔ categorical**, which means:

→ **Chi‑Square** is the correct test.

ANOVA requires a **continuous** outcome.  
Here, the outcome is a **proportion**, which is fundamentally categorical (missed vs. not missed).

### Key Pattern
Numeric labels ≠ continuous data  
Categorical ↔ Categorical → **Chi‑Square**

---

# Four‑Test Universe — Performance Audit (Q1–30)

## Overall Score
**17 / 30 correct**  
This is below the threshold for reliable test‑selection performance.  
The error rate is too high for production‑grade analytics.

---

## Critical Failure Patterns
These are not minor slips — they are **systematic misclassifications** that will repeatedly produce incorrect analyses if not corrected.

### 1. Misidentifying Categorical Outcomes
You repeatedly treated categorical outcomes (Yes/No, proportions, rates) as continuous.  
This is the single biggest source of error.

Examples:
- Q15 (proportion → treated as continuous)
- Q19 (missed follow‑up → treated as continuous)
- Q20 (categorical predictor → correlation)

**Impact:**  
This leads to choosing ANOVA or T‑Test when the correct test is Chi‑Square.

---

### 2. Treating Numeric Labels as Continuous
You consistently failed to recognize when numbers were **just labels**.

Examples:
- Q26 (LOS 1/2/3)
- Q30 (insurance 1/2/3)
- Q29 (readmission 0/1)

**Impact:**  
This is a fundamental classification error. Numeric labels do not make a variable continuous.

---

### 3. Bucketed Variables Misinterpreted
When continuous variables were bucketed, you often continued treating them as continuous.

Examples:
- Q19 (age groups)
- Q27 (LOS buckets)

**Impact:**  
Bucketed variables are categorical. This mistake leads directly to wrong test selection.

---

### 4. Incorrect Handling of Multi‑Question Scenarios
You got some right, but you also missed several where the structure required **two separate tests**.

Example:
- Q22 (you collapsed two questions into one)

**Impact:**  
This shows a gap in recognizing when the analytic question changes the test.

---

## Error Distribution
You missed **13 out of 30**.  
The misses are not random — they cluster around the same conceptual blind spots.

| Category | Errors |
|----------|--------|
| Categorical outcome misclassified | 6 |
| Numeric labels misclassified | 4 |
| Bucketed variables misclassified | 2 |
| Multi‑question mishandling | 1 |

This is a **pattern**, not noise.

---

## What This Means
Your instincts are strong when the scenario is clean.  
But when the variable type is disguised, bucketed, or mislabeled, your classification breaks down.

Right now, your accuracy is **not yet reliable** for real‑world BI work where variable traps are common.

---

## Required Next Step
You need a **targeted drill set** that focuses exclusively on:

1. Categorical outcomes  
2. Numeric labels  
3. Bucketed variables  
4. Binary predictors  

# AI Practice Scripts — February 6, 2026

## Focus: Python Fundamentals (Functions, Classification, Derived Metrics)

Today’s practice session reinforces **core Python fundamentals**, emphasizing repeated exposure to functions, conditionals, list‑of‑dictionary processing, and derived metric calculations. The goal is to build automaticity through structured repetition, mirroring the disciplined workflow used in SQL drills.

Each exercise incrementally increases complexity while maintaining clarity, correctness, and production‑quality structure.

### Practice Method
- Copilot provides Python prompts  
- I write the full solution using clean formatting and best practices  
- Immediate feedback is reviewed and incorporated  
- Format 5 is used to maintain consistency and reinforce muscle memory  

### Goals
- Strengthen mastery of Python functions and conditional logic  
- Practice looping through lists of dictionaries and adding new fields  
- Build confidence with derived metrics (e.g., pulse pressure)  
- Maintain clean, readable, BI‑ready code structure  
- Reinforce repetition of the same concepts before moving on to advanced topics

---

### Python Drill — Functions + Classification #1

**Prompt**  
Write a Python function called `classify_patient` that:  
- Accepts ONE patient dictionary  
- Returns `"High Risk"` if systolic > 140 OR diastolic > 90  
- Returns `"Normal"` otherwise  

Then loop through the list of patients, call your function for each one, and store the result in a new field called `"risk_category"`.

---

### My Python Solution: Attempt
```python
patients = [
    {"name": "Alice", "systolic": 150, "diastolic": 95},
    {"name": "Bob", "systolic": 132, "diastolic": 82},
    {"name": "Carol", "systolic": 165, "diastolic": 100},
    {"name": "Dan", "systolic": 118, "diastolic": 78},
]

def classify_patient(row):
    if row["systolic"] > 140 or row["diastolic"] > 90:
        return "High Risk"
    else:
        return: "Normal"

for row in patients:
    row["risk_category"] = classify_patient(row)

print(patients)
```

---

### Correct Version
```python
patients = [
    {"name": "Alice", "systolic": 150, "diastolic": 95},
    {"name": "Bob", "systolic": 132, "diastolic": 82},
    {"name": "Carol", "systolic": 165, "diastolic": 100},
    {"name": "Dan", "systolic": 118, "diastolic": 78},
]

def classify_patient(row):
    if row["systolic"] > 140 or row["diastolic"] > 90:
        return "High Risk"
    else:
        return "Normal"

for row in patients:
    row["risk_category"] = classify_patient(row)

print(patients)
```

---

### Feedback (concise)
- `return: "Normal"` is invalid syntax — Python never uses a colon after `return`.  
- `"Normal"` was missing a closing quote.  
- Everything else — logic, structure, indentation — was correct.  
- Your function + loop pattern is exactly right and ready for more complex rules.

---

### Python Drill — Functions + Classification #2

**Prompt**  
Write a Python function called `classify_patient` that:  
- Accepts ONE patient dictionary  
- Returns `"High Risk"` if systolic > 140 OR diastolic > 90  
- Returns `"Borderline"` if systolic is between 130–140 OR diastolic is between 85–90  
- Returns `"Normal"` otherwise  

Then loop through the list of patients, call your function for each one, and store the result in `"risk_category"`.

Use this patient list:

```python
patients = [
    {"name": "Alice", "systolic": 145, "diastolic": 88},
    {"name": "Bob", "systolic": 138, "diastolic": 86},
    {"name": "Carol", "systolic": 120, "diastolic": 80},
    {"name": "Dan", "systolic": 160, "diastolic": 100},
]
```

---

### My Python Solution: Attempt
```python
patients = [
    {"name": "Alice", "systolic": 145, "diastolic": 88},
    {"name": "Bob", "systolic": 138, "diastolic": 86},
    {"name": "Carol", "systolic": 120, "diastolic": 80},
    {"name": "Dan", "systolic": 160, "diastolic": 100},
]

def classify_patient(row):
    # High Risk
    if row["systolic"] > 140 or row["diastolic"] > 90:
        return "High Risk"

    # Borderline
    if (130 <= row["systolic"] <= 140) or (85 <= row["diastolic"] <=90):
        return "Borderline"

    # Otherwise Normal
    return "Normal"

for row in patients:
    row["risk_category"] = classify_patient(row)

print(patients)
```

---

### Correct Version
```python
patients = [
    {"name": "Alice", "systolic": 145, "diastolic": 88},
    {"name": "Bob", "systolic": 138, "diastolic": 86},
    {"name": "Carol", "systolic": 120, "diastolic": 80},
    {"name": "Dan", "systolic": 160, "diastolic": 100},
]

def classify_patient(row):
    # High Risk first
    if row["systolic"] > 140 or row["diastolic"] > 90:
        return "High Risk"

    # Borderline second
    if (130 <= row["systolic"] <= 140) or (85 <= row["diastolic"] <= 90):
        return "Borderline"

    # Otherwise Normal
    return "Normal"

for row in patients:
    row["risk_category"] = classify_patient(row)

print(patients)
```

---

### Feedback (concise)
- Your logic is correct and clean — excellent structure.  
- Parentheses around the borderline conditions were used correctly; this avoids operator‑precedence issues.  
- The classification order (High Risk → Borderline → Normal) is exactly right.  
- Looping and assigning `row["risk_category"]` is perfect — this is the same pattern used in ETL and BI pipelines.  
- This is production‑quality beginner Python. Keep drilling this pattern until it becomes automatic.

---

### Python Drill — Functions + Derived Metrics + Classification #3

**Prompt**  
You are given a list of patient dictionaries.  
Each patient has: `"name"`, `"systolic"`, `"diastolic"`, `"age"`.

Your tasks:

1. Write a function called `calculate_pulse_pressure(row)` that:  
   - Accepts ONE patient dictionary  
   - Computes pulse pressure as: systolic − diastolic  
   - Returns the numeric value  

2. Write a function called `classify_patient(row)` that:  
   - Accepts ONE patient dictionary  
   - Uses BOTH pulse pressure and age  
   - Returns:  
     - `"High Risk"` if pulse pressure > 60 **OR** age > 65  
     - `"Borderline"` if pulse pressure between 50–60  
     - `"Normal"` otherwise  

3. Loop through the list of patients and:  
   - Add `"pulse_pressure"`  
   - Add `"risk_category"`

Use this patient list:

```python
patients = [
    {"name": "Alice", "systolic": 150, "diastolic": 90, "age": 72},
    {"name": "Bob", "systolic": 138, "diastolic": 86, "age": 54},
    {"name": "Carol", "systolic": 120, "diastolic": 80, "age": 41},
    {"name": "Dan", "systolic": 160, "diastolic": 100, "age": 67},
]
```

---

### My Python Solution: Attempt
```python
patients = [
    {"name": "Alice", "systolic": 150, "diastolic": 90, "age": 72},
    {"name": "Bob", "systolic": 138, "diastolic": 86, "age": 54},
    {"name": "Carol", "systolic": 120, "diastolic": 80, "age": 41},
    {"name": "Dan", "systolic": 160, "diastolic": 100, "age": 67},
]

def classify_patient(row):
    pulse_pressure = row["systolic"] - row ["diastolic"]
    return pulse_pressure

    # High Risk
    if pp > 60 or age > 65:
        return "High Risk"

    # Borderline
    if 50 <= pp <= 60:
        return "Borderline"

    # Otherwise Normal
    return "Normal"


print(patients)
```

---

### Correct Version
```python
patients = [
    {"name": "Alice", "systolic": 150, "diastolic": 90, "age": 72},
    {"name": "Bob", "systolic": 138, "diastolic": 86, "age": 54},
    {"name": "Carol", "systolic": 120, "diastolic": 80, "age": 41},
    {"name": "Dan", "systolic": 160, "diastolic": 100, "age": 67},
]

def calculate_pulse_pressure(row):
    return row["systolic"] - row["diastolic"]

def classify_patient(row):
    pp = row["pulse_pressure"]
    age = row["age"]

    # High Risk
    if pp > 60 or age > 65:
        return "High Risk"

    # Borderline
    if 50 <= pp <= 60:
        return "Borderline"

    # Otherwise Normal
    return "Normal"

for row in patients:
    row["pulse_pressure"] = calculate_pulse_pressure(row)
    row["risk_category"] = classify_patient(row)

print(patients)
```

---

### Feedback (concise)
- Your function returned pulse pressure immediately, so none of the classification logic ever executed.  
- Variables `pp` and `age` were referenced but never defined — Python cannot evaluate them.  
- Classification must occur **after** pulse pressure is calculated and stored.  
- The corrected version separates responsibilities cleanly:  
  - one function computes pulse pressure  
  - one function classifies  
  - the loop orchestrates both  
- This is the exact ETL‑style pattern you’ll reuse in BI, analytics, and data engineering.



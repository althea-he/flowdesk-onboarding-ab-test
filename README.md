# FlowDesk Onboarding A/B Test Analysis

## 📌 Overview
This project analyzes an A/B test conducted at FlowDesk, a B2B SaaS company, to evaluate the impact of personalized onboarding emails on user behavior during the free trial period.

The experiment compares:
- **Control:** Generic onboarding email sequence  
- **Treatment:** Personalized onboarding email sequence based on user activity  

The goal is to determine whether personalization improves user engagement and conversion to paid subscriptions.

---

## 🎯 Objectives
- Measure the impact of onboarding email personalization
- Evaluate changes in engagement and conversion metrics
- Provide a data-driven business recommendation

---

## 📊 Key Results
- **Activation Rate:** +6.3 percentage points *(statistically significant)*
- **Conversion Rate:** +10.0 percentage points *(statistically significant)*
- **Engagement Depth:** Slight increase, not statistically significant
- **Churn Rate:** Increased slightly, not statistically significant after correction

👉 **Conclusion:** Personalized onboarding emails significantly improve conversion without introducing meaningful downside risk.

---

## 🧠 Methodology
- Unit of analysis: **Account-level randomization**
- Power analysis using pre-experiment data
- Two-sample **z-tests** for hypothesis testing
- **Bonferroni correction** for multiple comparisons
- **Delta method** for ratio metric variance estimation

---

## 🗂️ Project Structure

```
flowdesk-onboarding-ab-test/
├── README.md
├── 01_power_analysis.sql
├── 02_experiment_group_check.sql
├── 03_experiment_metrics.sql
├── ab_test_final_report.pdf
└── project_specification.pdf
```

---

## 🛠️ Tools & Skills
- SQL (BigQuery-style queries)
- A/B Testing & Experimental Design
- Statistical Inference (z-test, power analysis)
- Business Analytics & Decision Making

---

## 💼 Business Impact
The experiment demonstrates that personalized onboarding significantly increases conversion efficiency, a critical growth lever for SaaS businesses.

Rolling out the treatment is expected to:
- Increase revenue without additional acquisition cost
- Improve early user activation
- Enhance onboarding effectiveness

---

## 🚀 Recommendation
We recommend **rolling out the personalized onboarding email strategy**, while continuing to monitor long-term retention and churn behavior.

---

## 👩‍💻 Author
**Althea He**  
Columbia University 

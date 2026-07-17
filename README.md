# 🛒 Retail Customer & Revenue Analytics

## 📌 Project Overview
End-to-end retail analytics project analyzing
1M+ transactions from a UK-based online retailer
to uncover customer behavior, revenue patterns
and product performance insights.

## 🛠️ Tools & Technologies
- **Database**: MySQL
- **Language**: Python (Pandas, SQLAlchemy)
- **Visualization**: Power BI
- **Concepts**: RFM Analysis, Cohort Analysis,
  ABC Classification, 3NF Normalization

## 📊 Dashboard Preview

> 📄 Full interactive report available as PDF

[📥 View Full Dashboard Report](dashboard/pdf/Retail_Project_Report.pdf)

### Report Pages Included:
- 📈 Executive Summary
- 💰 Revenue Analytics
- 👥 Customer Analytics
- 🎯 RFM Segmentation
- 🔄 Cohort Retention
- 📦 Product Analytics

## 🗄️ Database Design
Raw Excel data normalized into 3NF MySQL schema:
- **customers** - Customer master data
- **products** - Product catalog
- **invoices** - Invoice headers
- **invoice_items** - Transaction line items

## 🔍 Key Findings
### Customer Analytics
- 70.51% repeat purchase rate
- 899 Champion customers driving £5.4M revenue
- 453 At-Risk customers with £897K revenue at stake
- 1,152 Lost customers (27% of base)

### Revenue Analytics
- £20.62M total revenue
- UK contributes 85%+ of revenue
- Q4 2023 strongest quarter at £2.58M
- AOV of £518 indicating B2B nature

### Product Analytics
- 21% of SKUs (1,007 products) generate 80% revenue
- 388 products never sold (dead catalog)
- JUMBO BAG RED RETROSPOT top revenue product

### Retention Analytics
- 25% Month 1 retention rate
- December cohort most loyal (39.27% avg retention)
- Seasonal spike in Oct-Nov (Christmas effect)

## 💡 Business Recommendations
1. **Win-back campaign** for 453 At-Risk customers
   to recover £897K revenue
2. **Improve Month 1 retention** from 25% through
   better customer onboarding
3. **Focus acquisition** in December season —
   most loyal customer cohort
4. **Discontinue 388 dead SKUs** to optimize catalog
5. **Protect Class A products** (1,007 SKUs driving
   80% revenue) with priority stock management

## 📁 Project Structure
```
retail-analytics/
├── README.md
├── sql/
│   ├── 01_create_tables.sql
│   ├── 02_data_cleaning.sql
│   ├── 03_rfm_analysis.sql
│   ├── 04_cohort_analysis.sql
│   └── 05_abc_analysis.sql
├── python/
│   └── upload.py
└── dashboard/
    └── pdf/
        └── Retail_Project_Report.pdf
```

## 🚀 How to Run
1. Clone repository
2. Run SQL scripts in order (01 to 05)
3. Run Python script to load data
4. Connect Power BI to MySQL
5. Open Power BI dashboard

## 📬 Contact
**Adeeb**
[https://www.linkedin.com/in/adeebt/]
[adeebt.mec@gmail.com]
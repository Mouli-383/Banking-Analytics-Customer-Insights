# Banking Analytics & Customer Insights

## Project Overview

Banking Analytics & Customer Insights is an end-to-end data analytics project developed using Python, SQL Server, and Tableau to analyze customer behavior, transaction activity, card portfolio performance, merchant trends, and financial risk indicators.

The project transforms raw banking data into actionable insights through data preprocessing, dimensional modeling, advanced SQL analytics, and interactive Tableau dashboards.

---

# Business Objective

Financial institutions generate large volumes of customer and transaction data. This project aims to answer key business questions such as:

* Who are the most valuable customers?
* What are the major spending patterns?
* Which merchant categories generate the highest transaction volume?
* What is the transaction failure rate?
* Which customers are high-risk?
* How do customer demographics influence spending behavior?
* How are card products performing across the customer base?

---

# Dataset Overview

The project uses four primary datasets.

## 1. Users Dataset

Contains customer demographic and financial information.

### Key Attributes

* client_id
* current_age
* retirement_age
* birth_year
* birth_month
* gender
* address
* latitude
* longitude
* per_capita_income
* yearly_income
* total_debt
* credit_score
* num_credit_cards

---

## 2. Cards Dataset

Contains card-related information for each customer.

### Key Attributes

* card_id
* client_id
* card_brand
* card_type
* card_number
* expires
* cvv
* has_chip
* num_cards_issued
* credit_limit
* acct_open_date
* year_pin_last_changed
* card_on_dark_web

---

## 3. MCC Codes Dataset

Contains merchant category mappings.

### Key Attributes

* mcc_code
* merchant_category

---

## 4. Transactions Dataset

Contains customer transaction records.

### Key Attributes

* Transaction Date
* Transaction Amount
* Merchant Name
* Merchant City
* Merchant State
* Merchant Category Code
* Transaction Type
* Transaction Status
* Card Information

---

# Project Workflow

## Step 1: Data Preparation Using Python

* Loaded raw JSON-formatted banking data using Pandas.
* Converted nested JSON data into structured tabular format.
* Exported processed data into CSV files for downstream analytics.
* Performed preliminary validation and formatting checks.

### Technologies Used

* Python
* Pandas

---

## Step 2: Data Cleaning & Validation

Performed extensive data quality checks including:

* Missing value analysis
* Duplicate record validation
* Data type validation
* Date standardization
* Business rule verification
* Referential integrity checks
* Outlier identification

---

## Step 3: Exploratory Data Analysis (EDA)

Analyzed customer, card, merchant, and transaction data to identify trends and answer business questions.

### Sample Business Questions

* How many active customers exist?
* What is the average customer credit score?
* Which customers generate the highest spending?
* What is the distribution of customer debt?
* Which merchant categories process the highest transaction value?
* Which geographic locations contribute the highest transaction volume?
* What is the transaction failure rate?
* Which customers have the highest debt-to-income ratios?

---

## Step 4: Data Modeling

Designed and implemented a Star Schema to support analytical reporting.

### Fact Table

* Fact_Transactions

### Dimension Tables

* Dim_Customers
* Dim_Cards
* Dim_Merchants
* Dim_Dates

### Benefits

* Improved analytical query performance
* Simplified reporting structure
* Enhanced scalability for dashboard development

---

## Step 5: SQL Analytics

Developed advanced SQL solutions for business analysis.

### SQL Concepts Used

* Joins
* Aggregate Functions
* CASE Statements
* Common Table Expressions (CTEs)
* Window Functions
* Ranking Functions
* Running Totals
* NTILE
* LAG
* Customer Segmentation

### SQL Objects Developed

#### Views

* Customer Summary View
* Transaction Summary View
* Merchant Performance View
* Spending Analysis View
* Risk Analysis View

#### Stored Procedures

* Customer Spending Analysis
* Monthly Transaction Report
* Merchant Category Analysis
* Failed Transaction Analysis
* Customer Segmentation Report
* High-Risk Customer Analysis

---

# Tableau Dashboards

## Executive Analytics Dashboard

Provides a high-level overview of:

* Total Customers
* Active Customers
* Total Cards
* Total Transactions
* Total Spending
* Total Deposits
* Customer Growth Trends
* Merchant Performance

---

## Customer Analytics Dashboard

Analyzes:

* Customer Demographics
* Income Distribution
* Credit Score Distribution
* Debt Analysis
* High-Risk Customers
* Spending Behavior

---

## Transaction Analytics Dashboard

Tracks:

* Transaction Volume
* Transaction Value
* Spending Trends
* Deposit Trends
* Merchant Analysis
* Transaction Type Distribution

---

## Card Analytics Dashboard

Analyzes:

* Card Portfolio Distribution
* Card Brand Performance
* Card Type Usage
* Credit Limits
* Card Spending Patterns

---

## Risk Analytics Dashboard

Monitors:

* Failed Transactions
* Failure Rates
* Debt-to-Income Ratios
* Credit Risk Indicators
* High-Risk Customers
* Merchant Risk Analysis

---

# Tools & Technologies

* Python
* Pandas
* SQL Server
* Tableau
* Data Modeling
* Star Schema Design
* Data Cleaning
* Exploratory Data Analysis (EDA)
* Advanced SQL
* Data Visualization

---

# Key Insights

* Identified customer segments based on spending behavior and financial characteristics.
* Evaluated customer risk using credit scores, debt levels, and debt-to-income ratios.
* Analyzed transaction trends across merchant categories and geographic locations.
* Measured transaction failure rates and associated risk patterns.
* Assessed card portfolio performance across brands and card types.
* Generated executive-level KPIs for customer growth and transaction performance monitoring.

# Conclusion

This project demonstrates end-to-end data analytics capabilities, including Python-based data preprocessing, SQL-based analytical modeling, Star Schema design, advanced SQL development, business intelligence reporting, and Tableau dashboard creation. The solution transforms raw banking data into meaningful customer, transaction, card, merchant, and risk insights to support data-driven decision-making.

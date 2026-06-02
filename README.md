# Marketing Analytics: ETL Pipeline, Sentiment Analysis & Conversion Funnel Diagnostics

## Project Overview

This project demonstrates an end-to-end marketing analytics workflow combining data engineering, SQL analytics, natural language processing (NLP), and business intelligence reporting.

Starting from a legacy Microsoft SQL Server backup (.bak), the project reconstructs the database in PostgreSQL, performs data quality auditing, analyzes customer sentiment using VADER NLP, and builds an interactive Power BI dashboard to identify conversion bottlenecks, engagement trends, and customer satisfaction opportunities.

---

## Business Problem

A legacy marketing database containing customer engagement, transaction, and review data was locked inside a proprietary SQL Server backup.

The business faced three key challenges:

* Declining conversion rates across products
* Falling customer engagement throughout 2025
* Limited visibility into customer sentiment and review behavior

The objective was to create a unified analytics solution capable of identifying operational bottlenecks and actionable optimization opportunities.

---

## Project Architecture

SQL Server (.bak)
↓
Restore Database in SSMS
↓
Python ETL Pipeline
↓
PostgreSQL Database
↓
SQL Cleaning & Auditing
↓
VADER Sentiment Analysis
↓
Power BI Dashboard
↓
Business Insights & Recommendations

---

## Tech Stack

### Data Engineering

* Microsoft SQL Server
* PostgreSQL
* Python
* Pandas
* SQLAlchemy

### Data Analysis

* SQL
* Common Table Expressions (CTEs)
* Window Functions

### NLP

* NLTK
* VADER Sentiment Analysis

### Business Intelligence

* Power BI
* DAX
* Power Query

---

## Key Tasks Performed

### Database Migration & ETL

* Restored a proprietary SQL Server backup (.bak) using SSMS.
* Developed a Python ETL pipeline to migrate relational data into PostgreSQL.
* Resolved schema compatibility issues through automated column normalization.

### Data Cleaning & Quality Assurance

* Identified duplicate customer journey events using SQL window functions.
* Standardized inconsistent marketing channel naming conventions.
* Converted string-based date fields into native SQL DATE formats.
* Created production-ready analytical views for reporting.

### Sentiment Analysis

* Processed customer review text using VADER sentiment scoring.
* Implemented a hybrid sentiment validation approach by comparing sentiment scores with star ratings.
* Classified reviews into Positive, Mixed Positive, Neutral, Mixed Negative, and Negative categories.

### Conversion Funnel Analysis

* Evaluated customer progression from Views → Clicks → Transactions.
* Measured monthly conversion performance across product categories.
* Identified seasonal conversion patterns and underperforming products.

---

## Key Findings

### Conversion Performance

* January recorded the highest conversion rate at 17.3%.
* October recorded the lowest conversion rate at 6.1%.
* Q4 conversion rate closed at 7.14%.
* Swim Goggles and Running Shoes consistently converted below 7%.

### Customer Engagement

* Product views declined from 1.2M+ to approximately 700K during 2025.
* Overall click-through rate reached 19.57%.
* CTR declined from 9.13% in January to 2.75% in December.
* Soccer Ball and Ice Skates generated unusually strong engagement relative to their price category.

### Customer Sentiment

* Positive sentiment reviews outnumbered negative reviews by nearly 4:1.
* 840 positive reviews versus 226 negative reviews.
* More than 21% of reviews fell into mixed or neutral sentiment categories.
* Average customer rating remained at 3.69, below the target benchmark of 4.0.

---

## Dashboard Highlights

The Power BI dashboard includes:

* Conversion Funnel Diagnostics
* Monthly Conversion Trends
* Product-Level Performance Analysis
* Customer Sentiment Distribution
* Review Rating Analysis
* Social Media Engagement Metrics
* KPI Monitoring

---

## Strategic Recommendations

### Increase Conversion Rates

* Prioritize high-performing products such as Ski Boots, Hockey Sticks, and Baseball Gloves during peak conversion periods.
* Implement targeted campaigns for underperforming products.

### Improve Engagement

* Replicate content strategies used by top-engagement products.
* Optimize call-to-action placement during historically weak engagement periods.

### Improve Customer Satisfaction

* Focus improvement efforts on mixed and negative review segments.
* Establish customer feedback loops to increase average ratings beyond 4.0.

---

## Repository Structure

```text
data/
sql/
python/
powerbi/
presentation/
dashboard_screenshots/
insights/
```

---

## Author

Krishna Devsishu

Data Analytics | SQL | Python | Power BI | NLP

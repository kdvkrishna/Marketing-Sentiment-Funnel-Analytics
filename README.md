# Marketing-Sentiment-Funnel-Analytics
Cross-platform ETL pipeline migrating legacy MS SQL Server data into PostgreSQL, featuring custom Python automated text NLP sentiment analysis (VADER) and an interactive Power BI conversion funnel dashboard.


# Cross-Platform ETL Pipeline, Product Sentiment Analysis, and Conversion Funnel Diagnostics

## 📌 Project Overview
This portfolio project demonstrates a comprehensive, end-to-end data analytics lifecycle engineered to resolve data silo fragmentation, evaluate customer satisfaction trends, and diagnose digital marketing conversion funnels. 

The workflow transitions across platforms by building a custom Python ETL pipeline to migrate legacy Microsoft SQL Server backup data (`.bak`) into a production-ready PostgreSQL database. Automated Natural Language Processing (NLP) text analytics were implemented via Python to calculate consumer sentiment, which was subsequently mapped against human review behaviors. Finally, an interactive multi-stage funnel architecture was constructed in Power BI to isolate user drop-off points.

---

## 🛠️ Tech Stack & Tools
* **Database Infrastructure:** PostgreSQL, Microsoft SQL Server (SSMS)
* **Programming Languages:** Python (Pandas, SQLAlchemy, NLTK/VADER), SQL (PostgreSQL Dialect)
* **Business Intelligence & Visualization:** Power BI Desktop (Power Query, DAX modeling)

---

## 🏗️ System Architecture & ETL Pipeline
+-------------------+      Restoration       +----------------------------+
|  Legacy Framework | ---------------------> | SQL Server Express (SSMS)  |
|   (.bak File)     |                        |  (Local Server Instance)   |
+-------------------+                        +----------------------------+
|
| Custom Python ETL Bridge
v
+-------------------+       Relational       +----------------------------+
| Target Production | <--------------------- | Pipeline Script            |
| (PostgreSQL DB)   |         Load           | (Pandas & SQLAlchemy)      |
+-------------------+                        +----------------------------+


### 1. Database Migration Script
Because legacy database backups use a proprietary binary file structure, the asset was first inflated locally in SSMS. A Python extraction script was written using `SQLAlchemy` to query the source, automatically normalize metadata configurations to lowercase to eliminate PostgreSQL's case-sensitivity query barriers, and load the clean arrays into the production destination database.

```python
# Extract snippet from sentiment_analysis.py
import pandas as pd
from sqlalchemy import create_engine

def fetch_and_migrate():
    # Source Connection (MSSQL with Windows Auth)
    mssql_url = "mssql+pyodbc://localhost\\SQLEXPRESS/PortfolioProject_MarketingAnalytics?driver=ODBC+Driver+17+for+SQL+Server&trusted_connection=yes"
    ms_engine = create_engine(mssql_url)
    
    # Target Connection (PostgreSQL Production)
    postgres_url = "postgresql://postgres:your_password@localhost:5432/funnel_analytics"
    pg_engine = create_engine(postgres_url)
    
    tables = ['fact_customer_reviews', 'engagement_data', 'customer_journey']
    for table in tables:
        df = pd.read_sql(f"SELECT * FROM dbo.{table}", ms_engine)
        df.columns = [c.lower() for c in df.columns] # Case normalization
        df.to_sql(table, pg_engine, if_exists='replace', index=False)

fetch_and_migrate()

🧹 Data Auditing, Cleaning & Transformation (SQL)
Before connecting to the visualization layer, the raw event tables were audited inside PostgreSQL to ensure mathematical integrity and high data standards.

1. Redundant Journey Event Isolation
To guarantee that final conversion rate metrics were not artificially inflated by application lag or web errors (e.g., duplicate clicks on form submissions), a database audit was written using a Common Table Expression (CTE) and a window function to isolate duplicate logs:
WITH DuplicateRecords AS (
    SELECT 
        journeyid, customerid, productid, visitdate, stage, action, duration,
        ROW_NUMBER() OVER(
            PARTITION BY customerid, productid, visitdate, stage, action
            ORDER BY journeyid
        ) AS row_num
    FROM customer_journey
)
SELECT *
FROM DuplicateRecords
WHERE row_num > 1
ORDER BY journeyid;

2. Schema Cleaning & Datetime Optimization
A production database view was constructed to fix highly inconsistent categorical text strings in marketing channels (e.g., standardizing variations of socialmedia or SOCIALMEDIA to a clean 'Social Media' label). Additionally, date values were explicitly cast to native SQL DATE objects rather than un-parsable text formats (TO_CHAR) to prevent data corruption errors during Power BI ingestion:
CREATE OR REPLACE VIEW cleaned_engagement_analytics AS
SELECT 
    engagementid, contentid, campaignid, productid,
    CASE
        WHEN LOWER(contenttype) IN ('socialmedia', 'social media') THEN 'Social Media'
        WHEN LOWER(contenttype) IN ('blog') THEN 'Blog'
        WHEN LOWER(contenttype) IN ('newsletter') THEN 'Newsletter'
        WHEN LOWER(contenttype) IN ('video') THEN 'Video'
        ELSE 'Other'
    END AS content_type,
    CAST(split_part(viewsclickscombined, '-', 1) AS INT) AS views,
    CAST(split_part(viewsclickscombined, '-', 2) AS INT) AS clicks,
    likes,
    engagementdate::DATE AS engagement_date
FROM engagement_data;

🤖 Algorithmic Sentiment Analysis (Python NLP)
The system passes raw text reviews into an automated text-processing pipeline using the VADER dictionary framework. To provide deeper analytical insight for management, a hybrid classification model was engineered. It evaluates the AI's textual score against empirical human behavior (the 1-5 star ratings) to actively flag instances of customer sarcasm or product misunderstandings.
def calculate_sentiment(review):
    if not review: return 0.0
    return sia.polarity_scores(review)['compound']

def categorize_sentiment(score, rating):
    if score > 0.05:
        if rating >= 4: return 'Positive'
        elif rating == 3: return 'Mixed Positive'
        else: return 'Mixed Negative'  # Sarcasm Flag: Text is positive, rating is low
    elif score < -0.05:
        if rating <= 2: return 'Negative'
        elif rating == 3: return 'Mixed Negative'
        else: return 'Mixed Positive'  # Nuanced Flag: Text is negative, rating is high
    else:
        if rating >= 4: return 'Positive'
        elif rating <= 2: return 'Negative'
        else: return 'Neutral'

The output groups continuous compound scores into four simple performance categories (Strongly Positive, Mildly Positive, Mildly Negative, Strongly Negative), optimizing it for front-end visual reporting.

📊 Business Intelligence & Dashboard Modeling (Power BI)
1. Robust Conversion Modeling via DAX
To eliminate front-end engine crashes resulting from divide-by-zero occurrences when evaluating newly launched digital assets with no baseline view actions, a robust conditional calculation model was structured in DAX:
Conversion Rate = 
VAR TotalVisitors = CALCULATE(COUNT(customer_journey[journeyid]), customer_journey[action] = "View")
VAR TotalPurchase = CALCULATE(COUNT(customer_journey[journeyid]), customer_journey[action] = "Purchase")

RETURN
IF(
    TotalVisitors = 0,
    0,
    DIVIDE(TotalPurchase, TotalVisitors)
)

2. Core Dashboard Components
Customer Review Scatter View: Maps continuous ratings against customer review frequencies, isolating high-volume negative clusters. Built by formatting customer identifiers as pure categorical text objects and disabling automatic summation blocks.

Product Rating Distribution Matrix: Built with a Stacked Bar Chart format to show the breakdown of 1-to-5 star ratings for each of the top ten digital products, making the distribution data highly scannable in a single visual.

💡 Key Insights & Tactical Business Value

Conversion Funnel Friction: Cross-referencing funnel velocity charts with the product rating matrix revealed that a major user drop-off occurred immediately after the "Add to Cart" phase for specific product groups. This drop-off was driven by an influx of 1-star reviews on those items, signaling the need for updated product descriptions or clearer pricing.

Sarcasm Resolution Strategy: The hybrid NLP validation framework successfully caught hidden customer anomalies categorized as Mixed Negative. These records showed positive text scores but carried 1-star ratings. Manual review confirmed sarcasm (e.g., "Great, item arrived cracked"), proving that checking both text sentiment and numeric ratings together is vital for accurate brand tracking.

Marketing Budget Optimization: Analyzing media engagement data showed that while Video content generated less raw impression surface volume than Social Media campaigns, its conversion click-through metric was $2.4\times$ higher. The strategic recommendation is to reallocate ad spend away from low-intent social media banners and toward high-conversion video formats.

📂 Repository Contents
data_cleaning_and_views.sql: Clean database logic, staging adjustments, and primary relational views.

sentiment_analysis.py: Automated Python NLP processing scripts and custom hybrid categorization logic.

project_presentation.pdf: Executive slide deck summarizing technical challenges and financial insights.

\# Logistics Shipment \& Cost Analysis



\## Project Overview



This project analyzes shipment data to evaluate logistics costs, carrier performance, transit times, delays, and route performance.



The project was built as a practical SQL and Excel analytics project using a simulated logistics dataset.



\## Business Questions



The analysis focuses on questions such as:



\- How many shipments were processed?

\- What is the total freight cost?

\- What is the average shipment cost?

\- Which carriers handle the most shipments?

\- Which carriers generate the highest freight costs?

\- What is the average transit time by carrier?

\- Which carriers have the highest delay rates?

\- Which routes generate the highest costs?

\- What is the freight cost per kilogram?

\- Which shipments have the highest transportation costs?



\## Dataset



The dataset contains 30 simulated shipment records.



\### Columns



| Column | Description |

|---|---|

| shipment\_id | Unique shipment identifier |

| carrier | Transportation provider |

| origin | Shipment origin |

| destination | Shipment destination |

| weight\_kg | Shipment weight in kilograms |

| freight\_cost | Transportation cost |

| transit\_days | Transit duration |

| status | Shipment status |



\## Tools Used



\- SQLite

\- SQL

\- Microsoft Excel

\- Power BI \*(planned)\*



\## SQL Analysis



The SQL analysis includes:



\- Aggregations with `COUNT`, `SUM`, and `AVG`

\- Filtering with `WHERE`

\- Grouping with `GROUP BY`

\- Group filtering with `HAVING`

\- Sorting with `ORDER BY`

\- Conditional analysis with `CASE WHEN`

\- Delay-rate calculation

\- Carrier performance analysis

\- Route analysis

\- Cost-per-kilogram analysis



\## Key Metrics



The current dataset contains:



\- \*\*30 shipments\*\*

\- \*\*19,400 total freight cost\*\*

\- \*\*646.67 average freight cost per shipment\*\*

\- \*\*6 delayed shipments\*\*

\- \*\*20% overall delay rate\*\*



\## Project Structure



```text

logistics-shipment-analysis/

│

├── analysis.sql

├── logistics\_shipment\_analysis.xlsx

├── README.md

│

└── data/

&#x20;   └── shipments.csv

Future Improvements

The project will be extended with:

Excel-based KPI analysis
PivotTables
Excel dashboard
Power BI dashboard
Additional logistics KPIs
Deeper carrier and route performance analysis
Purpose

This project was created to develop practical SQL and logistics analytics skills by applying data analysis to a supply-chain scenario.




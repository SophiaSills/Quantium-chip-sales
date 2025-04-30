
# Quantium Chip Sales Analysis

This project analyzes customer transactions and product data to uncover insights into chip sales patterns for Quantium. It combines R and Python scripts to process, summarize, and visualize sales performance across customer segments, time, and product types.

## 📁 Project Structure

```
quantium-chip-sales/
├── code/                   # Python and R scripts
│   ├── py/                # Python scripts (data wrangling, summaries)
│   └── r/                 # R scripts (plotting and report)
├── data/                  # Raw datasets (CSV, XLSX)
├── outputs/               # Final plots and report
│   └── charts/           # PNG visualizations
├── summaries/             # Aggregated CSV summaries
├── Quantium_Report_Chips.Rmd # RMarkdown source
└── Quantium_Chip_Sales_Analysis_Report.pdf # Final PDF report
```
## 🧾Executive Summary

This analysis investigates chip sales performance at Quantium, using merged transaction and customer behavior data. The project applies Python for data wrangling and R for visualization/reporting. Over 264,000 transactions across 1,700 stores were analyzed to uncover patterns in brand performance, customer segmentation, and seasonality. Findings reveal that sales are driven by a few dominant brands, skewed toward mainstream shoppers in older demographics, and peak strongly around the holiday season.

## 🔍 Key Insights

- **Top Brands by Total Sales:**
Kettle leads the chip category with $403,588 in sales.
Followed by:
Smiths: $273,778
Doritos: $267,806
Pringles: $221,438
Old El Paso: $91,615
These 5 brands make up over 60% of all chip sales.

- **Customer Segments:**
   Mainstream customers contribute the highest total: $750,744 (approximately 39% of sales).
   Budget shoppers: $676,212 (approximately 35%)
   Premium tier: $507,459 (approximately 26%)
   Total revenue analyzed across tiers: $1.93 million

- **Life Stages:**
  Older Singles/Couples top the chart with $402,427 in sales.
  Followed by:
  Retirees: $366,471
  Older Families: $353,767
  New Families are the lowest-spending group: $50,433
  
- **Monthly Sales Trends:**
  Highest month: December 2018 — $170,786 in chip sales.
  Lowest month: June 2018 — $27,358 (likely due to partial data).
  Noticeable seasonal peaks in November–December aligned with holiday periods.
  
- **Weekly Sales Trends:**
  Average weekly sales: $37,200
  Highest week: Dec 23–29, 2018 — $44,332
  Lowest week: June 4–10, 2018 — $30,514
  Weekly sales remained stable, with mild dips in mid-year and consistent holiday lifts.

## 🧰 Technologies Used

- **R**: `ggplot2`, `dplyr`, `zoo`, `scales`, `rmarkdown`
- **Python**: `pandas`, `matplotlib` (if used)
- **RMarkdown**: For reporting and PDF generation
- **Git/GitHub**: Version control

## 📊 Report Preview

The final report is available in the file:
```
Quantium_Chip_Sales_Analysis_Report.pdf
```

## 📦 Setup Instructions

1. Clone the repo
2. Open `Quantium_Report_Chips.Rmd` in RStudio
3. Knit to PDF (ensure `xelatex` is installed)


# Quantium Chip Sales Analysis

This project analyzes customer transaction and product data to uncover insights into chip sales patterns for Quantium. It combines R and Python scripts to process, summarize, and visualize sales performance across customer segments, time, and product types.

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

## 🔍 Key Insights

- **Top Brands:** Kettle, Smiths, Doritos lead in total sales.
- **Customer Segments:** Mainstream customers generate the most revenue.
- **Life Stages:** Older Singles/Couples are the top spenders.
- **Sales Trends:** Peaks occur during holidays; June 2018 contains partial data.

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

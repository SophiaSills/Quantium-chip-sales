import pandas as pd
df = pd.read_excel("final_dataset_merged.xlsx")

# Create new YEAR_WEEK column
df['YEAR_WEEK'] = df['DATE'].dt.strftime('%Y-%U')  # %U means week number (Sunday start)

# Group by YEAR_WEEK
weekly_sales = df.groupby('YEAR_WEEK')['TOT_SALES'].sum().reset_index()

# Save to CSV
weekly_sales.to_csv("summaries/weekly_sales.csv", index=False)

print()

# --- Monthly Sales ---
# Create YEAR_MONTH
df['YEAR_MONTH'] = df['DATE'].dt.to_period('M').astype(str)
monthly_sales = df.groupby('YEAR_MONTH')['TOT_SALES'].sum().reset_index()
monthly_sales.to_csv("summaries/monthly_sales.csv", index=False)

print()

import os
import pandas as pd

# Define safe path to input file
base_dir = os.path.abspath(os.path.join(os.path.dirname(__file__), "../../data/processed_data"))
file_path = os.path.join(base_dir, "final_dataset_merged.xlsx")

# Read the Excel file
df = pd.read_excel(file_path)

# Ensure date is in datetime format
if not pd.api.types.is_datetime64_any_dtype(df['DATE']):
    df['DATE'] = pd.to_datetime(df['DATE'], origin='1899-12-30', unit='D')

# Create new date columns
df['WEEK_START'] = df['DATE'] - pd.to_timedelta(df['DATE'].dt.weekday, unit='d')
df['YEAR_MONTH'] = df['DATE'].dt.to_period('M').astype(str)

# Ensure output directory exists
os.makedirs("summaries", exist_ok=True)

# Create and save summaries
df.groupby('WEEK_START')['TOT_SALES'].sum().reset_index().to_csv("summaries/weekly_sales.csv", index=False)
print("✅ Weekly sales summary saved.")

df.groupby('YEAR_MONTH')['TOT_SALES'].sum().reset_index().to_csv("summaries/monthly_sales.csv", index=False)
print("✅ Monthly sales summary saved.")

df.groupby('BRAND')['TOT_SALES'].sum().reset_index().sort_values(by='TOT_SALES', ascending=False).to_csv("summaries/sales_by_brand.csv", index=False)
print("✅ Sales by brand summary created.")

df.groupby('PREMIUM_CUSTOMER')['TOT_SALES'].sum().reset_index().sort_values(by='TOT_SALES', ascending=False).to_csv("summaries/sales_by_customer_premium.csv", index=False)
print("✅ Sales by premium tier saved.")

df.groupby('LIFESTAGE')['TOT_SALES'].sum().reset_index().sort_values(by='TOT_SALES', ascending=False).to_csv("summaries/sales_by_lifestage.csv", index=False)
print("✅ Sales by life stage saved.")

df.groupby('BRAND')['PROD_QTY'].sum().reset_index().sort_values(by='PROD_QTY', ascending=False).to_csv("summaries/quantity_by_brand.csv", index=False)
print("✅ Quantity by brand summary saved.")

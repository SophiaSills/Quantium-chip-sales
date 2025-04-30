import os
import pandas as pd

# Build the path to the dataset safely
base_dir = os.path.abspath(os.path.join(os.path.dirname(__file__), "../../data/processed_data"))
file_path = os.path.join(base_dir, "final_dataset_merged.xlsx")

# Load data
df = pd.read_excel(file_path)

# Convert DATE column to datetime if needed
if not pd.api.types.is_datetime64_any_dtype(df['DATE']):
    df['DATE'] = pd.to_datetime(df['DATE'], origin='1899-12-30', unit='D')

# Create WEEK_START for grouping
df['WEEK_START'] = df['DATE'] - pd.to_timedelta(df['DATE'].dt.weekday, unit='d')

# Filter out partial June week if desired
weekly_sales = df.groupby('WEEK_START')['TOT_SALES'].sum().reset_index()
weekly_sales = weekly_sales[weekly_sales['WEEK_START'] > '2018-06-10']

# Make sure output folder exists
os.makedirs("summaries", exist_ok=True)

# Save updated CSV
weekly_sales.to_csv("summaries/weekly_sales.csv", index=False)
print("✅ Weekly sales (fixed) saved to summaries/weekly_sales.csv")

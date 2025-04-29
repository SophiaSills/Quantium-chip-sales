import pandas as pd

# Load clean merged data
df = pd.read_excel("final_dataset_merged.xlsx")

# --- Check if DATE is already datetime
if not pd.api.types.is_datetime64_any_dtype(df['DATE']):
    df['DATE'] = pd.to_datetime(df['DATE'], origin='1899-12-30', unit='D')

# === Create WEEK_START and YEAR_MONTH ===
df['WEEK_START'] = df['DATE'] - pd.to_timedelta(df['DATE'].dt.weekday, unit='d')
df['YEAR_MONTH'] = df['DATE'].dt.to_period('M').astype(str)

# ===  Save Weekly Sales ===
weekly_sales = df.groupby('WEEK_START')['TOT_SALES'].sum().reset_index()
weekly_sales.to_csv("summaries/weekly_sales.csv", index=False)
print()

# === Save Monthly Sales ===
monthly_sales = df.groupby('YEAR_MONTH')['TOT_SALES'].sum().reset_index()
monthly_sales.to_csv("summaries/monthly_sales.csv", index=False)
print()

# === Save Sales by Brand ===
sales_by_brand = df.groupby('BRAND')['TOT_SALES'].sum().reset_index().sort_values(by='TOT_SALES', ascending=False)
sales_by_brand.to_csv("summaries/sales_by_brand.csv", index=False)
print("✅ Sales by brand summary created.")
print()

# === Save Sales by Premium Customer Tier ===
sales_by_premium = df.groupby('PREMIUM_CUSTOMER')['TOT_SALES'].sum().reset_index().sort_values(by='TOT_SALES', ascending=False)
sales_by_premium.to_csv("summaries/sales_by_customer_premium.csv", index=False)
print()

# === Save Sales by Life Stage ===
sales_by_lifestage = df.groupby('LIFESTAGE')['TOT_SALES'].sum().reset_index().sort_values(by='TOT_SALES', ascending=False)
sales_by_lifestage.to_csv("summaries/sales_by_lifestage.csv", index=False)
print()

# === Save Quantity by Brand ===
quantity_by_brand = df.groupby('BRAND')['PROD_QTY'].sum().reset_index().sort_values(by='PROD_QTY', ascending=False)
quantity_by_brand.to_csv("summaries/quantity_by_brand.csv", index=False)
print()

print()



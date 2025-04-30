library(readr)
library(dplyr)
library(ggplot2)
library(scales)
library(here)
library(zoo)

# Load Datasets
sales_by_brand <- read_csv(here("summaries", "sales_by_brand.csv"))
monthly_sales <- read_csv(here("summaries", "monthly_sales.csv"))
sales_by_lifestage <- read_csv(here("summaries", "sales_by_lifestage.csv"))
sales_by_premium <- read_csv(here("summaries", "sales_by_premium.csv"))
weekly_sales <- read_csv(here("summaries", "weekly_sales.csv"))

# Plot 1 Top 5 Brands

top5_brands <- sales_by_brand %>%
  arrange(desc(TOT_SALES)) %>%
  slice_head(n = 5)

plot_top_brands <- ggplot(top5_brands, aes(x = reorder(BRAND, TOT_SALES), y = TOT_SALES)) +
  geom_col(fill = "steelblue", width = 0.7) +
  geom_text(aes(label = dollar(TOT_SALES)),    # <--- Add labels
            hjust = -0.2,                      # Small offset to the right
            size = 4) +
  coord_flip() +
  scale_y_continuous(labels = dollar, expand = expansion(mult = c(0, 0.1))) +  # Extra space for labels
  labs(
    title = "Top 5 Brands by Total Sales",
    x = "Brand",
    y = "Total Sales ($)"
  ) +
  theme_minimal(base_size = 14) +
  theme(
    plot.title = element_text(face = "bold", hjust = 0.5, size = 16),
    axis.title.x = element_text(face = "bold"),
    axis.title.y = element_text(face = "bold")
  )

# Show the Plot
print(plot_top_brands)

# Save the plot
ggsave(
  here("outputs", "charts", "top_5_brands_r.png"),
  plot = plot_top_brands,
  width = 8,
  height = 5
)

# Plot 2 Monthly Sales Trend (Faceted Plot)

monthly_sales$YEAR_MONTH <- as.yearmon(monthly_sales$YEAR_MONTH, "%Y-%m")

monthly_sales$YEAR <- format(as.Date(monthly_sales$YEAR_MONTH), "%Y")

plot_monthly_sales_facet <- ggplot(monthly_sales, aes(x = YEAR_MONTH, y = TOT_SALES)) +
  geom_line(color = "steelblue", size = 1) +
  geom_point(color = "steelblue", size = 2) +
  geom_text(aes(label = dollar(TOT_SALES)), vjust = -0.8, size = 2.5) +
  scale_y_continuous(labels = dollar) +
  labs(
    title = "Monthly Sales Trend",
    x = "Month",
    y = "Total Sales ($)"
  ) +
  facet_wrap(~ YEAR, scales = "free_x") +    # <--- This splits by year automatically!
  theme_minimal(base_size = 14) +
  theme(
    plot.title = element_text(face = "bold", hjust = 0.5, size = 16),
    axis.title.x = element_text(face = "bold"),
    axis.title.y = element_text(face = "bold"),
    axis.text.x = element_text(angle = 45, hjust = 1)
  )
# Show the Plot
plot_monthly_sales_facet

# Save the plot
ggsave(
  here("outputs", "charts", "monthly_sales_trend_facet_r.png"),
  plot = plot_monthly_sales_facet,
  width = 10,
  height = 6
)

# Plot 3 Sales by Life Stage

sales_by_lifestage <- read_csv(here("summaries", "sales_by_lifestage.csv"))

plot_lifestage <- ggplot(sales_by_lifestage, aes(x = reorder(LIFESTAGE, -TOT_SALES), y = TOT_SALES)) +
  geom_col(fill = "skyblue", width = 0.7) +
  geom_text(aes(label = dollar(TOT_SALES)), vjust = -0.5, size = 3.5) +  # Label with sales $
  scale_y_continuous(labels = dollar) +
  labs(
    title = "Total Sales by Life Stage",
    x = "Life Stage",
    y = "Total Sales ($)"
  ) +
  theme_minimal(base_size = 14) +
  theme(
    plot.title = element_text(face = "bold", hjust = 0.5, size = 16),
    axis.title.x = element_text(face = "bold"),
    axis.title.y = element_text(face = "bold"),
    axis.text.x = element_text(angle = 45, hjust = 1)   # Rotate if labels are long
  )

 # Show the Plot
plot_lifestage

 # Save the Plot
ggsave(
  here("outputs", "charts", "sales_by_lifestage_r.png"),
  plot = plot_lifestage,
  width = 8,
  height = 5
)


# Plot 4 Sales by Customer Premium Tier

sales_by_premium <- read_csv(here("summaries", "sales_by_premium.csv"))

plot_premium <- ggplot(sales_by_premium, aes(x = reorder(PREMIUM_CUSTOMER, TOT_SALES), y = TOT_SALES)) +
  geom_col(fill = "coral", width = 0.7) +
  geom_text(
    aes(label = dollar(TOT_SALES)),
    hjust = -0.1,
    size = 5,
    fontface = "bold"
  ) +
  coord_flip() +  # Horizontal bars
  scale_y_continuous(labels = dollar, expand = expansion(mult = c(0, 0.2))) +
  labs(
    title = "Total Sales by Customer Premium Tier",
    x = "Customer Tier",
    y = "Total Sales ($)"
  ) +
  theme_minimal(base_size = 14) +
  theme(
    plot.title = element_text(face = "bold", size = 18, hjust = 0.5),
    axis.title.x = element_text(face = "bold"),
    axis.title.y = element_text(face = "bold"),
    plot.margin = margin(10, 40, 10, 10)  # top, right, bottom, left
  )

# --- Show the plot ---
plot_premium

ggsave(
  here("outputs", "charts", "sales_by_customer_premium_r.png"),
  plot = plot_premium,
  width = 9,
  height = 5,
  dpi = 300
)

# Plot 5 Weekly Sales Trend

# --- Load Weekly Sales ---
weekly_sales <- read_csv(here("summaries", "weekly_sales.csv"))

# --- Ensure WEEK_START is date type ---
weekly_sales$WEEK_START <- as.Date(weekly_sales$WEEK_START)

# --- Filter Out Early Partial Weeks (e.g., June 2018) ---
weekly_sales <- weekly_sales %>%
  filter(WEEK_START >= as.Date("2018-07-01"))

# --- Find Best and Worst Weeks AFTER filtering ---
best_week <- weekly_sales %>% filter(TOT_SALES == max(TOT_SALES))
worst_week <- weekly_sales %>% filter(TOT_SALES == min(TOT_SALES))

# --- Create Plot ---
plot_weekly_sales_highlight <- ggplot(weekly_sales, aes(x = WEEK_START, y = TOT_SALES)) +
  geom_line(color = "darkgreen", linewidth = 1) +
  geom_point(color = "darkgreen", size = 2) +
  
  # Highlight Best Week
  geom_point(data = best_week, mapping = aes(x = WEEK_START, y = TOT_SALES),
             color = "blue", size = 4, inherit.aes = FALSE) +
  geom_text(data = best_week, mapping = aes(x = WEEK_START, y = TOT_SALES, label = paste0("Best: ", dollar(TOT_SALES))),
            vjust = -1, color = "blue", size = 3, inherit.aes = FALSE) +
  
  # Highlight Worst Week
  geom_point(data = worst_week, mapping = aes(x = WEEK_START, y = TOT_SALES),
             color = "red", size = 4, inherit.aes = FALSE) +
  geom_text(data = worst_week, mapping = aes(x = WEEK_START, y = TOT_SALES, label = paste0("Worst: ", dollar(TOT_SALES))),
            vjust = 1.5, color = "red", size = 3, inherit.aes = FALSE) +
  
  scale_x_date(date_labels = "%b %Y", date_breaks = "1 month") +
  scale_y_continuous(labels = dollar) +
  labs(
    title = "Weekly Sales Trend for Chips (with Highlights)",
    x = "Week",
    y = "Total Sales ($)"
  ) +
  theme_minimal(base_size = 14) +
  theme(
    plot.title = element_text(face = "bold", hjust = 0.5, size = 16),
    axis.title.x = element_text(face = "bold"),
    axis.title.y = element_text(face = "bold"),
    axis.text.x = element_text(angle = 45, hjust = 1)
  )

# --- Show the plot ---
plot_weekly_sales_highlight

ggsave(
  filename = here("outputs", "charts", "weekly_sales_trend_highlight_r.png"), 
  plot = plot_weekly_sales_highlight,
  width = 10,    # inches
  height = 6,    # inches
  dpi = 300      # high resolution for professional reports
)

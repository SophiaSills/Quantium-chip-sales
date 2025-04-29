# --- Load libraries
library(tidyverse)
library(scales)
library(lubridate)
library(readr)
library(here)

# --- Load CSV Files
load_weekly_sales <- function() {
  read_csv(here("summaries", "weekly_sales.csv"))
}

load_monthly_sales <- function() {
  read_csv(here("summaries", "monthly_sales.csv"))
}

load_sales_by_brand <- function() {
  read_csv(here("summaries", "sales_by_brand.csv"))
}

load_sales_by_customer_premium <- function() {
  read_csv(here("summaries", "sales_by_customer_premium.csv"))
}

load_sales_by_lifestage <- function() {
  read_csv(here("summaries", "sales_by_lifestage.csv"))
}

load_quantity_by_brand <- function() {
  read_csv(here("summaries", "quantity_by_brand.csv"))
}


# Plot Weekly Sales
plot_weekly_sales <- function(data) {
  ggplot(data, aes(x = WEEK_START, y = TOT_SALES)) +
    geom_line(color = "darkgreen", size = 1) +
    geom_point(color = "darkgreen", size = 2) +
    geom_text(
      aes(label = ifelse(TOT_SALES == max(TOT_SALES) | TOT_SALES == min(TOT_SALES), dollar(TOT_SALES), NA)),
      vjust = -0.8, size = 3, na.rm = TRUE
    ) +
    scale_x_date(date_labels = "%b %Y", date_breaks = "1 month") +
    scale_y_continuous(labels = dollar) +
    labs(title = "Weekly Sales Trend", x = "Week", y = "Total Sales ($)") +
    theme_minimal(base_size = 14) +
    theme(
      plot.title = element_text(face = "bold", hjust = 0.5),
      axis.title = element_text(face = "bold"),
      axis.text.x = element_text(angle = 45, hjust = 1)
    )
}

# Plot Monthly Sales
plot_monthly_sales <- function(data) {
  data <- data %>% mutate(YEAR_MONTH = as.yearmon(YEAR_MONTH))
  ggplot(data, aes(x = YEAR_MONTH, y = TOT_SALES)) +
    geom_line(color = "blue", size = 1) +
    geom_point(color = "blue", size = 2) +
    scale_x_yearmon(format = "%b %Y", n = 10) +
    scale_y_continuous(labels = dollar) +
    labs(title = "Monthly Sales Trend", x = "Month", y = "Total Sales ($)") +
    theme_minimal(base_size = 14) +
    theme(
      plot.title = element_text(face = "bold", hjust = 0.5),
      axis.title = element_text(face = "bold"),
      axis.text.x = element_text(angle = 45, hjust = 1)
    )
}

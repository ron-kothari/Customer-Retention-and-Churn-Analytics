-- 1. Total Customers
SELECT COUNT(*) AS total_customers
FROM customer_retention_dataset;

-- 2. Active Customers (last purchase within 90 days)
SELECT COUNT(*) AS active_customers
FROM customer_retention_dataset
WHERE DATEDIFF(day, last_purchase_date, GETDATE()) <= 90;

-- 3. Churned Customers (no purchase in last 90 days)
SELECT COUNT(*) AS churned_customers
FROM customer_retention_dataset
WHERE DATEDIFF(day, last_purchase_date, GETDATE()) > 90;

-- 4. Repeat Customers (more than 1 order)
SELECT COUNT(*) AS repeat_customers
FROM customer_retention_dataset
WHERE total_orders > 1;

-- 5. Total Revenue
SELECT SUM(total_spent) AS total_revenue
FROM customer_retention_dataset;

-- 6. Average Order Value (AOV)
SELECT AVG(total_spent / NULLIF(total_orders,0)) AS avg_order_value
FROM customer_retention_dataset;

-- 7. Revenue by Region
SELECT region, SUM(total_spent) AS revenue
FROM customer_retention_dataset
GROUP BY region;

-- 8. Churn Rate %
SELECT
  CAST(
    (SUM(CASE WHEN churn_flag = 1 THEN 1 END) * 1.0) /
    COUNT(*) * 100 AS DECIMAL(10,2)
  ) AS churn_rate
FROM customer_retention_dataset;

-- 9. Repeat Rate %
SELECT
  CAST(
    (SUM(CASE WHEN total_orders > 1 THEN 1 END) * 1.0) /
    COUNT(*) * 100 AS DECIMAL(10,2)
  ) AS repeat_rate;

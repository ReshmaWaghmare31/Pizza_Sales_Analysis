Create database PizzaSales;
use PizzaSales;

-- 1. Total Revenue:
SELECT SUM(total_price) AS Total_Revenue FROM pizza_sales;

-- 2. Average Order Value
SELECT (SUM(total_price) / COUNT(DISTINCT order_id)) AS Avg_order_Value FROM pizza_sales;

-- 3. Total Pizzas Sold
SELECT SUM(quantity) AS Total_pizza_sold FROM pizza_sales;

-- 4. Total Orders
SELECT COUNT(DISTINCT order_id) AS Total_Orders FROM pizza_sales;

-- 5. Average Pizzas Per Order
SELECT CAST(CAST(SUM(quantity) AS DECIMAL(10,2)) / 
CAST(COUNT(DISTINCT order_id) AS DECIMAL(10,2)) AS DECIMAL(10,2))
AS Avg_Pizzas_per_order
FROM pizza_sales;

-- Daily Trend for Total Orders
select DATENAME(DW, order_date) as order_days, count(distinct(order_id)) as Total_orders
from pizza_sales
group by DATENAME(DW, order_date)
ORDER BY Total_orders desc;

select DAYNAME(order_date) as order_days, 
count(distinct order_id) as Total_orders
from pizza_sales
group by DAYNAME(order_date)
ORDER BY Total_orders desc;

-- C. Hourly Trend for Orders
SELECT HOUR(order_time) AS order_hours, 
COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY HOUR(order_time)
ORDER BY HOUR(order_time);

-- Monthly trend for orders
select DATENAME(MONTH, order_date) as month_name,COUNT(distinct(order_id)) as Total_orders
from pizza_sales
group by DATENAME(MONTH, order_date)
order by Total_orders;

SELECT monthname(order_date) as month_name, 
count(distinct(order_id)) as Total_orders
from pizza_sales
group by monthname(order_date);


-- % of Sales by Pizza Category
SELECT pizza_category, CAST(SUM(total_price) AS DECIMAL(10,2)) as total_revenue,
concat(cast(SUM(total_price) * 100 / (SELECT SUM(total_price) from pizza_sales) AS DECIMAL(10,2)),'%') AS PCT
FROM pizza_sales
GROUP BY pizza_category;





-- % of Sales by Pizza Size
SELECT pizza_size, CAST(SUM(total_price) AS DECIMAL(10,2)) as total_revenue,
concat(cast(SUM(total_price) * 100 / (SELECT SUM(total_price) from pizza_sales) AS DECIMAL(10,2)),'%') AS PCT
FROM pizza_sales
GROUP BY pizza_size
ORDER BY pizza_size;


-- Total Pizzas Sold by Pizza Category****
SELECT pizza_category, SUM(quantity) AS Total_Quantity_Sold
FROM pizza_sales
WHERE MONTH(order_date) = 2
GROUP BY pizza_category
ORDER BY Total_Quantity_Sold DESC;

-- Top 5 Best Sellers by Total Pizzas Sold
SELECT pizza_name, SUM(quantity) AS Total_Pizza_Sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Pizza_Sold DESC
LIMIT 5;


-- Bottom 5 Best Sellers by Total Pizzas Sold
SELECT pizza_name, SUM(quantity) AS Total_Pizza_Sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Pizza_Sold ASC
LIMIT 5;

-- identify highest prised pizza
select pizza_name, unit_price
from pizza_sales
order by unit_price desc
limit 1;

-- lowest prised pizza
select pizza_name, unit_price
from pizza_sales
order by unit_price asc
limit 1;

-- Top 5 sellers by Total Orders
select pizza_name, count(distinct (order_id)) as Total_Order
from pizza_sales
group by pizza_name
order by Total_Order desc
limit 5;

-- Bottom 5 sellers by Total Orders
select pizza_name, count(distinct (order_id)) as Total_Order
from pizza_sales
group by pizza_name
order by Total_Order asc
limit 5;

-- Top 5 sellers by Revenue
select pizza_name,sum(total_price) as Revenue
from pizza_sales
group by pizza_name
order by Revenue desc
limit 5;

-- Bottom 5 sellers by Revenue
select pizza_name,sum(total_price) as Revenue
from pizza_sales
group by pizza_name
order by Revenue asc
limit 5;
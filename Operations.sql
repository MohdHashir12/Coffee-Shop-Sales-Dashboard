select round(sum(unit_price * transaction_qty)) as Total_Sales
from coffee_shop_sales
where
month(transaction_date) = 3; -- march month

-- slected month / current month - may=5
-- previous month april=4

select
	month(transaction_date) as month,
    round(sum(unit_price * transaction_qty)) as total_sales,
    (sum(unit_price * transaction_qty) - lag(sum(unit_price * transaction_qty), 1)
    over (order by month(transaction_date))) / lag(sum(unit_price * transaction_qty),1)
    over (order by month(transaction_date)) * 100 as mom_increase_percentage
from
	coffee_shop_sales
where
	month(transaction_date) in (4,5)
group by
	month(transaction_date)
order by
	month(transaction_date);


select count(transaction_id) as total_orders
from coffee_shop_sales
where
month(transaction_date) = 5; -- march month

SELECT 
    MONTH(transaction_date) AS month,
    ROUND(COUNT(transaction_id)) AS total_orders,
    (COUNT(transaction_id) - LAG(COUNT(transaction_id), 1) 
    OVER (ORDER BY MONTH(transaction_date))) / LAG(COUNT(transaction_id), 1) 
    OVER (ORDER BY MONTH(transaction_date)) * 100 AS mom_increase_percentage
FROM 
    coffee_shop_sales
WHERE 
    MONTH(transaction_date) IN (4, 5) -- for April and May
GROUP BY 
    MONTH(transaction_date)
ORDER BY 
    MONTH(transaction_date);
    
    
SELECT SUM(transaction_qty) as Total_Quantity_Sold
FROM coffee_shop_sales 
WHERE MONTH(transaction_date) = 6; -- for month of (CM-May)


SELECT 
    MONTH(transaction_date) AS month,
    ROUND(SUM(transaction_qty)) AS total_quantity_sold,
    (SUM(transaction_qty) - LAG(SUM(transaction_qty), 1) 
    OVER (ORDER BY MONTH(transaction_date))) / LAG(SUM(transaction_qty), 1) 
    OVER (ORDER BY MONTH(transaction_date)) * 100 AS mom_increase_percentage
FROM 
    coffee_shop_sales
WHERE 
    MONTH(transaction_date) IN (4, 5)   -- for April and May
GROUP BY 
    MONTH(transaction_date)
ORDER BY 
    MONTH(transaction_date);
    
    select
		concat(round(sum(unit_price * transaction_qty)/1000,1), 'K') as total_sales,
        concat(round(sum(transaction_qty)/1000,1), 'K') as total_qty_sold,
        concat(round(count(transaction_id)/1000,1), 'K') as total_orders
	from coffee_shop_sales
    where
		transaction_date = '2023-03-27';


-- weekends - sat and sun
-- weekdayes - mon to fri
-- sun = 1, mon = 2 ..... sat = 7

select
	case when dayofweek(transaction_date) in (1,7) then 'Weekends'
    else 'Weekdays'
    end as day_type,
    concat(round(sum(unit_price * transaction_qty)/1000,1), 'K') as total_sales
from coffee_shop_sales
where month(transaction_date) = 2
group by
	case when dayofweek(transaction_date) in (1,7) then 'Weekends'
    else 'Weekdays'
    end;

select
	store_location,
    concat(round(sum(unit_price * transaction_qty)/1000,2),'K') as Total_sales
from coffee_shop_sales
where month(transaction_date) = 5
group by store_location
order by concat(round(sum(unit_price * transaction_qty)/1000,2),'K') desc;


select
	CONCAT(round(avg(total_sales)/1000,1),'K') as Avg_sales
from
	(
    select sum(transaction_qty * unit_price) as total_sales
    from coffee_shop_sales
    where month (transaction_date) = 5
    group by transaction_date
    ) as Internal_query;


SELECT 
    DAY(transaction_date) AS day_of_month,
    concat(ROUND(SUM(unit_price * transaction_qty)/1000,1),'K') AS total_sales
FROM 
    coffee_shop_sales
WHERE 
    MONTH(transaction_date) = 5  -- Filter for May
GROUP BY 
    DAY(transaction_date)
ORDER BY 
    DAY(transaction_date);
    
    

SELECT 
    day_of_month,
    CASE 
        WHEN total_sales > avg_sales THEN 'Above Average'
        WHEN total_sales < avg_sales THEN 'Below Average'
        ELSE 'Average'
    END AS sales_status,
    total_sales
FROM (
    SELECT 
        DAY(transaction_date) AS day_of_month,
        SUM(unit_price * transaction_qty) AS total_sales,
        AVG(SUM(unit_price * transaction_qty)) OVER () AS avg_sales
    FROM 
        coffee_shop_sales
    WHERE 
        MONTH(transaction_date) = 5  -- Filter for May
    GROUP BY 
        DAY(transaction_date)
) AS sales_data
ORDER BY 
    day_of_month;


select
	product_category,
    concat(round(sum(unit_price * transaction_qty)/1000,1),'K') as total_sales
from coffee_shop_sales
where month(transaction_date)=5
group by product_category
order by sum(unit_price * transaction_qty) desc;

select
    concat(round(sum(unit_price * transaction_qty)/1000,1),'K') as total_sales,
    sum(transaction_qty) as total_qty_sold,
    count(*) total_orders
from coffee_shop_sales
where month(transaction_date) = 5
and dayofweek(transaction_date) = 1 -- Monday
and hour(transaction_time) = 14; -- hour no 8


select
	hour(transaction_time),
    concat(round(sum(unit_price * transaction_qty)/1000,1),'K') as total_sales
from coffee_shop_sales
where month(transaction_date) = 5
group by hour(transaction_time)
order by hour(transaction_time);


SELECT 
    CASE 
        WHEN DAYOFWEEK(transaction_date) = 2 THEN 'Monday'
        WHEN DAYOFWEEK(transaction_date) = 3 THEN 'Tuesday'
        WHEN DAYOFWEEK(transaction_date) = 4 THEN 'Wednesday'
        WHEN DAYOFWEEK(transaction_date) = 5 THEN 'Thursday'
        WHEN DAYOFWEEK(transaction_date) = 6 THEN 'Friday'
        WHEN DAYOFWEEK(transaction_date) = 7 THEN 'Saturday'
        ELSE 'Sunday'
    END AS Day_of_Week,
    concat(ROUND(SUM(unit_price * transaction_qty)/1000,1),'K') AS Total_Sales
FROM 
    coffee_shop_sales
WHERE 
    MONTH(transaction_date) = 5 -- Filter for May (month number 5)
GROUP BY 
    CASE 
        WHEN DAYOFWEEK(transaction_date) = 2 THEN 'Monday'
        WHEN DAYOFWEEK(transaction_date) = 3 THEN 'Tuesday'
        WHEN DAYOFWEEK(transaction_date) = 4 THEN 'Wednesday'
        WHEN DAYOFWEEK(transaction_date) = 5 THEN 'Thursday'
        WHEN DAYOFWEEK(transaction_date) = 6 THEN 'Friday'
        WHEN DAYOFWEEK(transaction_date) = 7 THEN 'Saturday'
        ELSE 'Sunday'
    END;



SELECT 
    HOUR(transaction_time) AS Hour_of_Day,
    concat(ROUND(SUM(unit_price * transaction_qty)/1000,1),'K') AS Total_Sales
FROM 
    coffee_shop_sales
WHERE 
    MONTH(transaction_date) = 5 -- Filter for May (month number 5)
GROUP BY 
    HOUR(transaction_time)
ORDER BY 
    HOUR(transaction_time);



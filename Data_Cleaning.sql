create database Coffee_Shop_Sales_db;
use coffee_Shop_sales_db;
select * from coffee_shop_sales;

describe coffee_shop_sales;

SET SQL_SAFE_UPDATES = 0;

update coffee_shop_sales
set transaction_date = str_to_date(transaction_date, '%d-%m-%Y');

alter table coffee_shop_sales
modify column transaction_date date;

update coffee_shop_sales
set transaction_time = str_to_date(transaction_time, '%H:%i:%s');

alter table coffee_shop_sales
modify column transaction_time time;

alter table coffee_shop_sales
change column ï»¿transaction_id transaction_id INT;







--code starting line 128 doesn't work
--question on line 109

-- Part 1: Warm Up

-- 1.1 Select all rows and all columns from the categories table; order by category ID.
SELECT * FROM categories c ORDER BY c.category_id;

-- 1.2 Select name and description of each category; order by ID.
SELECT c.category_name, c.description FROM categories c
ORDER BY c.category_id;

-- 1.3 Select all values in the "city" column of the employees table; sort values descending order.
SELECT e.city FROM employees e ORDER BY e.city DESC;

-- 1.4 Select a unique set of employees' city names in descending order.
SELECT DISTINCT e.city FROM employees e
ORDER BY e.city DESC;

--1.5  Select ID and name of all discontinued products; order by name.
-- Discontinued products are labeled with 1 from workshop 1
SELECT p.product_id, 
p.product_name FROM products p
WHERE p.discontinued = 1 
ORDER BY p.product_name;


-- Part 2: Orders

-- 2.1 Select the date of each customer's first order and its corresponding customer ID; sort by customer ID.
SELECT MIN(o.order_date), 
o.customer_id FROM orders o
GROUP BY o.customer_id
ORDER BY o.customer_id;

-- 2.2 Same as previous query, but name the column of date values "first_order_date".
SELECT MIN(o.order_date) 
AS first_order_date, o.customer_id 
FROM orders o
GROUP BY o.customer_id
ORDER BY o.customer_id;

-- 2.3 Same as previous query, but sort by first_order_date instead of customer ID.
SELECT MIN(o.order_date) 
AS first_order_date, o.customer_id 
FROM orders o
GROUP BY o.customer_id
ORDER BY first_order_date;

-- 2.4 How many orders have been placed? 830
SELECT COUNT(*) AS order_count FROM orders o;

-- 2.5 How many orders has each customer made? List customer-ID, order-count pairs; sort by order-count (greatest to least).
SELECT o.customer_id, 
COUNT(*) AS order_count FROM orders o
GROUP BY o.customer_id
ORDER BY order_count DESC;

-- 2.6 What is the average cost of freight per order?
SELECT AVG(o.freight) FROM orders o;

-- 2.7 For each customer, list customer ID and the average freight cost of their orders; sort by average freight cost.
SELECT o.customer_id, 
AVG(o.freight) AS avg_freight 
FROM orders o
GROUP BY o.customer_id
ORDER BY avg_freight;

-- 2.8 For each customer, list customer ID and the total amount they have spent on freight; sort by cusotmer ID.
SELECT o.customer_id, 
SUM(o.freight) AS total_freight 
FROM orders o
GROUP BY o.customer_id
ORDER BY o.customer_id;

-- 2.9 Select the address and the order-count for the address that has received the most orders.
SELECT o.ship_address, 
COUNT(*) as order_count FROM orders o
GROUP BY o.ship_address
ORDER BY order_count DESC LIMIT 1; 

-- 2.10 Given the definitions below, get the Order ID and Order Total for the 50 most expensive orders; sort by Order Total in descending order.
-- Order Subtotal: unit_price * quantity * (1 - discount)
-- Order Total: sum of order's subtotals
SELECT od.order_id, 
SUM(od.unit_price*od.quantity*(1-od.discount)) AS order_total
FROM order_details od
GROUP BY od.order_id
ORDER BY order_total DESC LIMIT 50;


-- Part 3: Employees

-- 3.1 What are first and last name of each Sales Representative? Order by last name.
SELECT e.first_name, e.last_name FROM employees e
WHERE e.title = 'Sales Representative'
ORDER BY e.last_name;

-- 3.2 Get first name, last name, and notes for employees who don't have anyone to report to (i.e. their reports_to field is blank). Order by last name.
SELECT e.first_name, e.last_name, e.notes FROM employees e
WHERE e.reports_to IS NULL
ORDER BY e.last_name;

-- 3.3 Get first name, last name, and notes for employees who do have someone to report to. Order by last name.
SELECT e.first_name, e.last_name, e.notes FROM employees e
WHERE e.reports_to IS NOT NULL
ORDER BY e.last_name;

-- 3.4 Get first name and last name of the first employee to be hired in London.
--What if employees hired on same date?
SELECT e.first_name, e.last_name FROM employees e
WHERE e.city = 'London'
ORDER BY e.hire_date LIMIT 1;

-- 3.5 Get first name and home phone of employees whose first names begin with the letter 'A' and whose phone numbers contain the number '4'. Sort by last name.
SELECT e.first_name, e.home_phone FROM employees e
WHERE e.first_name LIKE 'A%' AND e.home_phone LIKE '%4%'
ORDER BY e.last_name;

-- 3.6 Get city name and number of Sales Representatives in each city that contains at least 2 Sales Reps. Order by the number of Sales Reps.
SELECT e.city, COUNT(*) AS num_reps 
FROM employees e
WHERE e.title = 'Sales Representative'
GROUP BY e.city
HAVING COUNT(*) > 1
ORDER BY num_reps;

-- 3.7 Get first names, last names, and hire dates of employees who were hired in 1994; sort by hire date.
SELECT e.first_name, e.last_name, e.hire_date
FROM employees e
WHERE e.hire_date BETWEEN '1994-01-01' AND '1994-12-31'
ORDER BY e.hire_date;
-- LIKE views as a string, but doesn't work on dates


-- Part 4: Mix and Match

-- 4.1 List product names that begin with the letter 'C' and their corresponding category names. Order by product ID.
SELECT p.product_name, ca.category_name 
FROM products p
JOIN categories ca 
ON p.category_id = ca.category_id
WHERE p.product_name LIKE 'C%'
ORDER BY p.product_id;

-- 4.2 Management wants a "call list" to check on customers who haven't ordered in a while.
-- List contact names, contact titles, company names, phone numbers, and last order dates for no more than 10 customers; sort by last order date (least recent first).
SELECT c.contact_name, c.contact_title, c.company_name, c.phone, o.order_date 
FROM customers c
JOIN orders o
ON o.customer_id = c.customer_id
ORDER BY o.order_date
LIMIT 10; 

-- 4.3 Management needs to know which products to order due to low stock levels.
-- Each product has an Item Deficit which is defined as the difference between its reorder_level and units_in_stock
-- A product should be ordered if it meets the following criteria:
--   1. The number of units in stock is less than or equal to its reorder-level
--   2. The product is not discontinued
--   3. The number of units on order is less than the product's Item Deficit
-- List product names, supplier company names, supplier phone numbers, and item deficits for each product that should be ordered. Sort by item deficits (greatest to least).
SELECT p.product_name, s.company_name, s.phone, (p.reorder_level-p.units_in_stock) AS item_deficit
FROM products p
JOIN suppliers s
ON p.supplier_id = s.supplier_id
WHERE p.units_in_stock <= p.reorder_level
    AND p.discontinued = 0
    AND p.units_on_order < (p.reorder_level-p.units_in_stock)
ORDER BY item_deficit DESC;

-- 4.4 List company names of suppliers who have not shipped any orders; sort alphabetically.
SELECT s.company_name FROM shippers s
WHERE s.shipper_id IN(
    SELECT s.shipper_id FROM shippers s
    EXCEPT 
    SELECT o.ship_via FROM orders o);

-- 4.5 List region description, territory description, employee last name, and employees first name for each territory and region an employee works in.
-- Remove duplicate results and sort first by region description, then territory description, then last name, and finally first name.
SELECT DISTINCT r.region_description, t.territory_description, e.last_name, e.first_name 
FROM employees e
JOIN employee_territories et
ON e.employee_id = et.employee_id
JOIN territories t
ON et.territory_id = t.territory_id 
JOIN region r
ON t.region_id = r.region_id
ORDER BY r.region_description, t.territory_description, e.last_name, e.first_name
-- WE NEED emplyees, emplyee territories, territories and region tables connected together

-- 4.6 Get ALL U.S. state names and abbreviations, along with customer company names for customers based in the USA.
-- If a state does not have any relate customers, fill in NULL for the company_name field. Order by state name. 
SELECT us.state_name, us.state_abbr, c.company_name
FROM us_states us
LEFT JOIN customers c
ON us.state_abbr = c.region
ORDER BY us.state_name;

-- 4.7 List territory ID, employee title of courtesy, and employee last name for all employees in all territories.
-- If a territory has no employees assigned, list its ID with NULL filled in for the relevant employee fields. Sort by territory ID.
SELECT t.territory_id, e.title_of_courtesy, e.last_name
FROM employees e
JOIN employee_territories et
ON et.employee_id = e.employee_id
RIGHT JOIN territories t
ON t.territory_id = et.territory_id;

-- 4.8 For each order, list the order ID and the number of unique products in said order (call this product_count). 
-- Filter to only include orders with at least 5 unique products. Sort by product_count in descending order.
SELECT od.order_id, count(*) as product_count FROM order_details od 
GROUP BY od.order_id
HAVING COUNT(*) > 4
ORDER BY product_count DESC;

-- 4.9 Management needs a list of all suppliers and customers for their holiday greetings card!
-- Provide a list with the company name, address, city, region, postal code, and country for all suppliers and customers.
-- Sort by company name.
WITH customer_addresses AS (
    SELECT
    c.company_name,
    c.address,
    c.city,
    c.region,
    c.postal_code,
    c.country
    FROM customers c
), supplier_addresses AS (
    SELECT
    s.company_name,
    s.address,
    s.city,
    s.region,
    s.postal_code,
    s.country
    FROM suppliers s
)
SELECT * FROM supplier_addresses
Union
SELECT * FROM customer_addresses
ORDER by company_name;
--code starting line 81, 136 doesn't work
--question on line 116

-- Part 1: Warm Up

-- Select all rows and all columns from the categories table; order by category ID.
SELECT * FROM categories ORDER BY category_id;

-- Select name and description of each category; order by ID.
SELECT c.category_name, c.description FROM categories c
ORDER BY c.category_id;

-- Select all values in the "city" column of the employees table; sort values descending order.
SELECT e.city FROM employees e ORDER BY e.city DESC;

-- Select a unique set of employees' city names in descending order.
SELECT DISTINCT e.city FROM employees e
ORDER BY e.city DESC;

-- Select ID and name of all discontinued products; order by name.
-- Discontinued products are labeled with 1 from workshop 1
SELECT p.product_id, 
p.product_name FROM products p
WHERE p.discontinued = 1 
ORDER BY p.product_name;


-- Part 2: Orders

-- Select the date of each customer's first order and its corresponding customer ID; sort by customer ID.
SELECT MIN(o.order_date), 
o.customer_id FROM orders o
GROUP BY o.customer_id
ORDER BY o.customer_id;

-- Same as previous query, but name the column of date values "first_order_date".
SELECT MIN(o.order_date) 
AS first_order_date, o.customer_id 
FROM orders o
GROUP BY o.customer_id
ORDER BY o.customer_id;

-- Same as previous query, but sort by first_order_date instead of customer ID.
SELECT MIN(o.order_date) 
AS first_order_date, o.customer_id 
FROM orders o
GROUP BY o.customer_id
ORDER BY first_order_date;

-- How many orders have been placed? 830
SELECT COUNT(*) AS o.order_count FROM orders o;

-- How many orders has each customer made? List customer-ID, order-count pairs; sort by order-count (greatest to least).
SELECT o.customer_id, 
COUNT(*) AS order_count FROM orders o
GROUP BY o.customer_id
ORDER BY order_count DESC;

-- What is the average cost of freight per order?
SELECT AVG(o.freight) FROM o.orders;

-- For each customer, list customer ID and the average freight cost of their orders; sort by average freight cost.
SELECT o.customer_id, 
AVG(o.freight) AS avg_freight 
FROM orders o
GROUP BY o.customer_id
ORDER BY avg_freight;

-- For each customer, list customer ID and the total amount they have spent on freight; sort by cusotmer ID.
SELECT o.customer_id, 
SUM(o.freight) AS total_freight 
FROM orders o
GROUP BY o.customer_id
ORDER BY o.customer_id;

-- Select the address and the order-count for the address that has received the most orders.
SELECT o.ship_address, 
COUNT(*) as order_count FROM orders o
GROUP BY o.ship_address
ORDER BY order_count DESC LIMIT 1; 

-- Order Subtotal: unit_price * quantity * (1 - discount)
-- Order Total: sum of order's subtotals
-- Given the definitions above, get the Order ID and Order Total for the 50 most expensive orders; sort by Order Total in descending order.
WITH order_subtotal AS (
    SELECT order_id,
    (unit_price * quantity * (1-discount))
    AS subtotal
    FROM order_details
    GROUP BY order_id 
), order_total AS (
    SELECT order_id FROM order_subtotal
    WHERE total = (SELECT SUM(subtotal) FROM order_subtotal)
)
SELECT order_id FROM order_details
WHERE order_id IN (SELECT order_id FROM order_total)
GROUP BY order_total DESC LIMIT 50;


-- Part 3: Employees

-- What are first and last name of each Sales Representative? Order by last name.
SELECT e.first_name, e.last_name FROM employees e
ORDER BY e.last_name;

-- Get first name, last name, and notes for employees who don't have anyone to report to (i.e. their reports_to field is blank). Order by last name.
SELECT e.first_name, e.last_name, e.notes FROM employees e
WHERE e.reports_to IS NULL
ORDER BY e.last_name;

-- Get first name, last name, and notes for employees who do have someone to report to. Order by last name.
SELECT e.first_name, e.last_name, e.notes FROM employees e
WHERE e.reports_to IS NOT NULL
ORDER BY e.last_name;

-- Get first name and last name of the first employee to be hired in London.
--What if employees hired on same date?
SELECT e.first_name, e.last_name FROM employees e
WHERE e.city = 'London'
ORDER BY e.hire_date LIMIT 1;

-- Get first name and home phone of employees whose first names begin with the letter 'A' and whose phone numbers contain the number '4'. Sort by last name.
SELECT e.first_name, e.home_phone FROM employees e
WHERE e.first_name LIKE 'A%' AND e.home_phone LIKE '%4%'
ORDER BY e.last_name;

-- Get city name and number of Sales Representatives in each city that contains at least 2 Sales Reps. Order by the number of Sales Reps.
SELECT e.city, COUNT(*) AS num_reps 
FROM employees e
GROUP BY e.city
HAVING COUNT(*) > 1
ORDER BY num_reps;


-- Get first names, last names, and hire dates of employees who were hired in 1994; sort by hire date.
SELECT e.first_name, e.last_name, e.hire_date
FROM employees e
WHERE e.hire_date IN (1994)
ORDER BY e.hire_date;


-- Part 4: Mix and Match

-- List product names that begin with the letter 'C' and their corresponding category names. Order by product ID.
SELECT p.product_name, p.category_id FROM products p
WHERE p.product_name LIKE 'C%'
ORDER BY p.product_id;

-- Management wants a "call list" to check on customers who haven't ordered in a while.
-- List contact names, contact titles, company names, phone numbers, and last order dates for no more than 10 customers; sort by last order date (least recent first).
SELECT contact_name, contact_title, company_name, phone

-- Management needs to know which products to order due to low stock levels.
-- Each product has an Item Deficit which is defined as the difference between its reorder_level and units_in_stock
-- A product should be ordered if it meets the following criteria:
--   1. The number of units in stock is less than or equal to its reorder-level
--   2. The product is not discontinued
--   3. The number of units on order is less than the product's Item Deficit
-- List product names, supplier company names, supplier phone numbers, and item deficits for each product that should be ordered. Sort by item deficits (greatest to least).


-- List company names of suppliers who have not shipped any orders; sort alphabetically.


-- List region description, territory description, employee last name, and employees first name for each territory and region an employee works in.
-- Remove duplicate results and sort first by region description, then territory description, then last name, and finally first name.


-- Get ALL U.S. state names and abbreviations, along with customer company names for customers based in the USA.
-- If a state does not have any relate customers, fill in NULL for the company_name field. Order by state name. 


-- List territory ID, employee title of courtesy, and employee last name for all employees in all territories.
-- If a territory has no employees assigned, list its ID with NULL filled in for the relevant employee fields. Sort by territory ID.


-- For each order, list the order ID and the number of unique products in said order (call this product_count). 
-- Filter to only include orders with at least 5 unique products. Sort by product_count in descending order.


-- Management needs a list of all suppliers and customers for their holiday greetings card!
-- Provide a list with the company name, address, city, region, postal code, and country for all suppliers and customers.
-- Sort by company name.

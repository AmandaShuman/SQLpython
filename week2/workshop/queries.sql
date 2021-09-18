-- Part 1: Warm Up

-- Select all rows and all columns from the categories table; order by category ID.


-- Select name and description of each category; order by ID.


-- Select all values in the "city" column of the employees table; sort values descending order.


-- Select a unique set of employees' city names in descending order.


-- Select ID and name of all discontinued products; order by name.



-- Part 2: Orders

-- Select the date of each customer's first order and its corresponding customer ID; sort by customer ID.


-- Same as previous query, but name the column of date values "first_order_date".


-- Same as previous query, but sort by first_order_date instead of customer ID.


-- How many orders have been placed?


-- How many orders has each customer made? List customer-ID, order-count pairs; sort by order-count (greatest to least).


-- What is the average cost of freight per order?


-- For each customer, list customer ID and the average freight cost of their orders; sort by average freight cost.


-- For each customer, list customer ID and the total amount they have spent on freight; sort by cusotmer ID.


-- Select the address and the order-count for the address that has received the most orders.


-- Order Subtotal: unit_price * quantity * (1 - discount)
-- Order Total: sum of order's subtotals
-- Given the definitions above, get the Order ID and Order Total for the 50 most expensive orders; sort by Order Total in descending order.



-- Part 3: Employees

-- What are first and last name of each Sales Representative? Order by last name.


-- Get first name, last name, and notes for employees who don't have anyone to report to (i.e. their reports_to field is blank). Order by last name.


-- Get first name, last name, and notes for employees who do have someone to report to. Order by last name.


-- Get first name and last name of the first employee to be hired in London.


-- Get first name and home phone of employees whose first names begin with the letter 'A' and whose phone numbers contain the number '4'. Sort by last name.


-- Get city name and number of Sales Representatives in each city that contains at least 2 Sales Reps. Order by the number of Sales Reps.


-- Get first names, last names, and hire dates of employees who were hired in 1994; sort by hire date.



-- Part 4: Mix and Match

-- List product names that begin with the letter 'C' and their corresponding category names. Order by product ID.


-- Management wants a "call list" to check on customers who haven't ordered in a while.
-- List contact names, contact titles, company names, phone numbers, and last order dates for no more than 10 customers; sort by last order date (least recent first).


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

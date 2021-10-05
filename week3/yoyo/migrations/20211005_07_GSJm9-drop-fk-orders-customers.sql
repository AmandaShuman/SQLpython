-- drop fk_orders_customers
-- depends: 20211005_06_HZdoL-create-orders
ALTER TABLE orders
    DROP CONSTRAINT fk_orders_customers;

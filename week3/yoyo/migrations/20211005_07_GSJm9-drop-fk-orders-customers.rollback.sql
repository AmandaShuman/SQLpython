-- drop fk_orders_customers
-- depends: 20211005_06_HZdoL-create-orders
ALTER TABLE orders
    ADD CONSTRAINT fk_orders_customers
    FOREIGN KEY (customer_id)
    REFERENCES customers(id)
    ON DELETE CASCADE;

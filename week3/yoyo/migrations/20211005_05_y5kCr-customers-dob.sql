-- customers dob
-- depends: 20211005_04_0nz4t-customers-date-of-birth-default
ALTER TABLE customers 
    RENAME COLUMN date_of_birth TO dob;

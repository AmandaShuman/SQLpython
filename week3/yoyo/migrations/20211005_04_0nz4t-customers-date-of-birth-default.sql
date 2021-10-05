-- customers date_of_birth default
-- depends: 20211005_03_b2epB-customers-date-of-birth-non-nullable
ALTER TABLE customers   
    ALTER COLUMN date_of_birth SET DEFAULT now();

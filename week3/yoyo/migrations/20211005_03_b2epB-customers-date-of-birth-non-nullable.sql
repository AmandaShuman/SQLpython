-- customers date_of_birth non-nullable
-- depends: 20211005_02_U3RtB-customers-date-of-birth
ALTER TABLE customers
    ALTER COLUMN date_of_birth SET NOT NULL;

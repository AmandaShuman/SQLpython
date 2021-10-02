/* CREATE TABLE */
CREATE TABLE cars (
	id SERIAL PRIMARY KEY,
	year INT,
	make TEXT NOT NULL,
	model TEXT NOT NULL
);

/* INSERT VALUES INTO TABLE */
INSERT INTO cars (year, make, model)​
VALUES (2020, 'Toyota', 'Prius');

INSERT INTO cars (year, make, model)​
VALUES (2012, 'Ford', 'Focus');

/* ALTER THE TABLE TO ADD A COLUMN */
ALTER TABLE cars
ADD wheel_count INT NOT NULL DEFAULT 4;

/* insert values */
INSERT INTO cars (year, make, model)
VALUES (2020, 'Nissan', 'Altima');  /* keeps wheel_count default of 4 */

INSERT INTO cars (make, model, wheel_count)
VALUES ('Elio', 'P5', 3); /* overrides default and adds [null] to year */

/* deleting values */
DELETE FROM cars
WHERE year IS null;
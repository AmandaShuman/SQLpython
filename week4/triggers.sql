-- create tables

CREATE TABLE employees (
	id SERIAL PRIMARY KEY,
	salary INTEGER NOT NULL,
	name TEXT NOT NULL
);

CREATE TABLE employees_log (
	id SERIAL PRIMARY KEY,
	description TEXT NOT NULL,
	created_at TIMESTAMP NOT NULL DEFAULT now(),
	employee_id INT NOT NULL,
	CONSTRAINT fk_emp_log_to_emp
	FOREIGN KEY(employee_id)
		REFERENCES employees(id)
	ON DELETE CASCADE
	
);

-- CREATE FUNCTION AND TRIGGER

-- logging new employees
CREATE FUNCTION log_new_employee() RETURNS trigger AS $$
    BEGIN
		INSERT INTO employees_log (description, employee_id) VALUES (
			'Employee created.',
			NEW.id -- -> employees.id
		);
        RETURN NEW;
    END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER log_new_employee AFTER INSERT ON employees
    FOR EACH ROW EXECUTE FUNCTION log_new_employee();

INSERT INTO employees (salary, name) values (55000, 'Alice');
INSERT INTO employees (salary, name) values (66000, 'Bob');

-- displays everything from the employees table alongside the generated description and created_at values
SELECT e.*, log.description, log.created_at
FROM employees_log log
JOIN employees e ON log.employee_id = e.id;


-- log salary updates
CREATE FUNCTION log_salary_update() RETURNS trigger AS $$
    BEGIN
		INSERT INTO employees_log (description, employee_id) VALUES (
			-- || operator joins values as strings
			'Salary updated from '||OLD.salary||' to '||NEW.salary,
			NEW.id
		);
        RETURN NEW;
    END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER log_salary_update AFTER UPDATE OF salary ON employees
    FOR EACH ROW EXECUTE FUNCTION log_salary_update();

UPDATE employees SET salary = 80000 WHERE name = 'Alice';

SELECT e.*, log.description, log.created_at
FROM employees_log log
JOIN employees e ON log.employee_id = e.id;


-- verify that the query above doesn't change when only doing a name change
UPDATE employees SET name = 'Alice B. Cool' WHERE name = 'Alice';

SELECT e.*, log.description, log.created_at
FROM employees_log log
JOIN employees e
ON log.employee_id = e.id;


-- remove tables and functions to clean up week 4?
DROP TABLE employees CASCADE;
DROP TABLE employees_log;
DROP FUNCTION log_new_employee;
DROP FUNCTION log_salary_update;
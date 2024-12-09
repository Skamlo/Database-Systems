-- task 1
INSERT INTO employees VALUES (300, 'Snow', 'Jack', 'PROFESSOR', 100, DATE '2013-05-01', 4750, NULL, 30);
INSERT INTO employees VALUES (310, 'Cook', 'Robin', 'PROFESSOR', 100, DATE '2016-09-15', 3500, 1250, 40);
INSERT INTO employees VALUES (320, 'Dormand', 'Francis', 'ASSISTANT', 110, DATE '2018-01-01', 3900, NULL, 40);

SELECT *
FROM employees
WHERE emp_id >= 300;

-- task 2
INSERT INTO departments
VALUES (70, 'DATABASE SYSTEMS', NULL);

SELECT *
FROM departments
WHERE dept_id = 70;

-- task 3
UPDATE employees
SET dept_id = 70
WHERE emp_id >= 300;

SELECT emp.surname, emp.name, emp.salary, emp.add_salary
FROM departments dept
INNER JOIN employees emp ON dept.dept_id = emp.dept_id
WHERE dept.dept_name = 'DATABASE SYSTEMS'
ORDER BY emp.surname;

-- task 4
UPDATE employees emp
SET
    emp.salary = emp.salary * 1.1,
    emp.add_salary = CASE
        WHEN emp.add_salary IS NULL THEN 100
        ELSE emp.add_salary * 1.2
    END
WHERE emp.dept_id IN (
    SELECT dept.dept_id
    FROM departments dept
    WHERE dept.dept_name = 'DATABASE SYSTEMS'
);

SELECT
    surname,
    name,
    salary,
    add_salary
FROM employees;

-- task 5
UPDATE employees emp
SET
    emp.salary = emp.salary + 0.1 * (
        SELECT AVG(emp_avg.salary)
        FROM employees emp_avg
        JOIN departments dept_avg ON emp_avg.dept_id = dept_avg.dept_id
        WHERE dept_avg.dept_name = 'ADMINISTRATION'
    )
WHERE emp.dept_id IN (
    SELECT dept.dept_id
    FROM departments dept
    WHERE dept.dept_name = 'DATABASE SYSTEMS'
);

SELECT
    surname,
    name,
    salary,
    add_salary
FROM employees;

-- task 6
DELETE FROM departments
WHERE dept_name = 'DATABASE SYSTEMS';

--This code doesn't work because they are trying to delete childs rows in a related table.

-- task 7
DELETE FROM employees
WHERE
    dept_id IN (
        SELECT dept_id
        FROM departments
        WHERE dept_name = 'DATABASE SYSTEMS'
    ) AND
    salary < 5000;

UPDATE employees
SET dept_id = NULL
WHERE dept_id = 70;

SELECT * FROM employees;

-- task 8
DELETE FROM departments
WHERE dept_name = 'DATABASE SYSTEMS';

SELECT * FROM departments;

-- task 9
DELETE FROM employees
WHERE
    name = 'Jack' AND
    surname = 'Snow';

SELECT * FROM employees;

-- task 1
INSERT INTO employees
VALUES
(300, 'Snow', 'Jack', 'PROFESSOR', 100, '2013-05-01', 4750, NULL, 30),
(310, 'Cook', 'Robin', 'PROFESSOR', 100, '2016-09-15', 3500, 1250, 40),
(320, 'Dormand', 'Francis', 'ASSISTANT', 110, '2018-01-01', 3900, NULL, 40);

SELECT *
FROM employees
WHERE emp_id >= 300;

-- task 2
INSERT INTO departments
VALUES
(70, 'DATABASE SYSTEMS', NULL);

SELECT *
FROM departments
WHERE dept_id = 70;

-- task 3
UPDATE employees
SET dept_id = 70
WHERE emp_id >= 300;

SELECT emp.surname, emp.name, emp.salary, emp.add_salary
FROM departments AS dept
INNER JOIN employees AS emp ON dept.dept_id = emp.dept_id
WHERE dept.dept_name = 'DATABASE SYSTEMS'
ORDER BY emp.surname;

-- task 4


-- task 5


-- task 6


-- task 7


-- task 8


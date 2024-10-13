-- task 1
SELECT * FROM departments;

-- taks 2
SELECT * FROM employees;

-- task 3
SELECT surname, job, salary * 12
FROM employees;

-- task 4
SELECT surname, job, salary * 12 AS yearly_income
FROM employees;

-- task 5
SELECT surname, job, salary + coalesce(add_salary, 0) AS monthly_income
FROM employees
ORDER BY monthly_income;

-- task 6
SELECT name || ' ' || surname AS assistants
FROM employees
WHERE job = 'ASSISTANT'
ORDER BY assistants;

-- task 7
SELECT name || ' ' || surname AS employee, job, salary, dept_id
FROM employees
WHERE dept_id IN (30, 40)
ORDER BY salary DESC;

-- task 8
SELECT name || ' ' || surname AS employee, job, salary
FROM employees
WHERE salary BETWEEN 1000 AND 2000
ORDER BY salary;

-- task 9
SELECT name, surname
FROM employees
WHERE surname LIKE '%son';

-- task 10
SELECT name, surname
FROM employees
WHERE dept_id IS NULL;

-- task 11
SELECT name, surname, boss_id, salary
FROM employees
WHERE NOT boss_id IS NULL AND salary > 2000;

-- task 12
SELECT name, surname, dept_id
FROM employees
WHERE dept_id = 20 AND (surname LIKE 'W%' OR surname LIKE '%son');

-- task 13
SELECT name, surname, salary + coalesce(add_salary, 0) AS monthly_salary
FROM employees
WHERE salary + coalesce(add_salary, 0) > 4000;

-- task 14
SELECT 'Employee ' || name || ' ' || surname || ' works as ' || job || ' and earns ' || salary + coalesce(add_salary, 0)
FROM employees
ORDER BY surname, name;

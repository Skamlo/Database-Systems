-- task 1
SELECT
	MIN(salary) AS minimum_salary,
	MAX(salary) AS maximum_salary,
	MAX(salary) - MIN(salary) AS difference
FROM employees;

-- task 2
SELECT COUNT(*) AS employees_without_dept
FROM employees
WHERE dept_id IS NULL;

-- task 3
SELECT COUNT(*) AS professors
FROM employees
WHERE job LIKE 'PROFESSOR';

-- task 4
SELECT job, ROUND(AVG(salary), 2) AS job_average_salary
FROM employees
GROUP BY job
ORDER BY job_average_salary DESC;

-- task 5
SELECT
	job,
	ROUND(AVG(salary + coalesce(add_salary, 0)), 2) AS job_average_salary,
	COUNT(*) AS employees
FROM employees
GROUP BY job
ORDER BY job_average_salary DESC;

-- task 6
SELECT
	job,
	ROUND(AVG(salary + coalesce(add_salary, 0)), 2) AS job_average_salary,
	COUNT(*) AS employees
FROM employees
GROUP BY job
HAVING COUNT(*) > 1
ORDER BY job_average_salary DESC;

-- task 7
SELECT
    dept_id,
    COUNT(*) AS employees_with_add_salary
FROM employees
WHERE
	dept_id IS NOT NULL
	AND
	add_salary IS NOT NULL
GROUP BY dept_id
ORDER BY dept_id;

-- task 8
SELECT
    dept_id,
    COUNT(*) AS employees_with_add_salary,
	ROUND(AVG(add_salary), 2) AS avg_add_salary,
	SUM(add_salary) AS sum_of_add_salaries
FROM employees
WHERE
	dept_id IS NOT NULL
	AND
	add_salary IS NOT NULL
GROUP BY dept_id
ORDER BY dept_id;

-- task 9
SELECT
	boss_id,
	COUNT(*) AS number_of_subordinates
FROM employees
WHERE boss_id IS NOT NULL
GROUP BY boss_id
ORDER BY boss_id;

-- task 10
SELECT
	EXTRACT(YEAR FROM hire_date) AS year_of_employment,
	COUNT(*) AS number_of_employees
FROM employees
GROUP BY EXTRACT(YEAR FROM hire_date)
ORDER BY EXTRACT(YEAR FROM hire_date);

-- task 11
SELECT
	LENGTH(surname) AS surname_length,
	COUNT(*) AS number_of_surnames
FROM employees
GROUP BY surname_length
ORDER BY surname_length;

-- task 12
SELECT COUNT(*) AS surnames_with_a
FROM employees
WHERE LOWER(surname) LIKE '%a%';

SELECT COUNT(*) AS surnames_with_e
FROM employees
WHERE LOWER(surname) LIKE '%e%';

-- task 13
SELECT
(
    SELECT COUNT(*)
    FROM employees
    WHERE LOWER(surname) LIKE '%a%'
) AS surnames_with_a,
(
    SELECT COUNT(*)
    FROM employees
    WHERE LOWER(surname) LIKE '%e%'
) AS surnames_with_e
FROM dual;

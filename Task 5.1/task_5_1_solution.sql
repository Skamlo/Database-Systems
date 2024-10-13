-- task 1
SELECT emp.name, emp.surname, dept.dept_name, dept.address
FROM employees emp
LEFT JOIN departments dept ON emp.dept_id = dept.dept_id
WHERE emp.dept_id IS NOT NULL
ORDER BY emp.surname, emp.name;

-- task 2
SELECT 'Employee ' || emp.name || ' ' || emp.surname || ' works in ' || dept.dept_name || ' located at ' || dept.address AS sentence
FROM employees emp
LEFT JOIN departments dept ON emp.dept_id = dept.dept_id
WHERE emp.dept_id IS NOT NULL
ORDER BY emp.surname, emp.name;

-- task 3
SELECT emp.surname, emp.salary
FROM employees emp
INNER JOIN departments dept ON emp.dept_id = dept.dept_id
WHERE dept.address LIKE '47TH STR'
ORDER BY emp.surname;

-- task 4
SELECT 
	COUNT(*) AS employees_at_47th_str,
	ROUND(AVG(emp.salary), 2) AS avg_salary
FROM employees emp
INNER JOIN departments dept ON emp.dept_id = dept.dept_id
WHERE dept.address LIKE '47TH STR';

-- task 5
SELECT
	emp.surname,
	emp.job,
	emp.salary,
	jobs.min_salary AS job_min_salary,
	jobs.max_salary AS job_max_salary
FROM employees emp
INNER JOIN jobs ON emp.job = jobs.name
ORDER BY emp.surname;

-- task 6
SELECT
	emp.surname,
	emp.job,
	emp.salary,
	jobs.min_salary AS job_min_salary,
	jobs.max_salary AS job_max_salary
FROM employees emp
INNER JOIN jobs ON emp.job = jobs.name
WHERE emp.salary < jobs.min_salary OR emp.salary > jobs.max_salary
ORDER BY emp.surname;

-- task 7
SELECT
	emp.surname,
	emp.job,
	emp.salary,
	(SELECT min_salary FROM jobs WHERE name = 'ASSISTANT') AS job_min_salary,
	(SELECT max_salary FROM jobs WHERE name = 'ASSISTANT') AS job_max_salary
FROM employees emp
INNER JOIN jobs ON emp.job = jobs.name
WHERE
    emp.salary >= (SELECT min_salary FROM jobs WHERE name = 'ASSISTANT')
    AND
    emp.salary <= (SELECT max_salary FROM jobs WHERE name = 'ASSISTANT')
ORDER BY emp.surname;

-- task 8
SELECT
	dept.dept_name,
	COUNT(*) AS employees_at_dept,
	SUM(emp.salary) AS salaries_at_dept
FROM employees emp
INNER JOIN departments dept ON emp.dept_id = dept.dept_id
GROUP BY dept.dept_name
ORDER BY dept.dept_name;

-- task 9
SELECT
	dept.dept_name,
	COUNT(*) AS employees_at_dept,
	SUM(emp.salary) AS salaries_at_dept
FROM employees emp
INNER JOIN departments dept ON emp.dept_id = dept.dept_id
GROUP BY dept.dept_name
HAVING COUNT(*) >= 2
ORDER BY dept.dept_name;

-- task 10
SELECT
	dept.dept_name AS department,
	CASE
		WHEN COUNT(*) BETWEEN 1 AND 2 THEN 'small'
		WHEN COUNT(*) BETWEEN 3 AND 6 THEN 'medium'
		WHEN COUNT(*) >= 7 THEN 'big'
	END AS label
FROM employees emp
INNER JOIN departments dept ON emp.dept_id = dept.dept_id
GROUP BY dept.dept_name
ORDER BY dept.dept_name;

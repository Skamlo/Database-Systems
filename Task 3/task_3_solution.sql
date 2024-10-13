-- task 1
SELECT
	surname,
	salary,
	CASE
		WHEN salary < 1500 THEN 'low paid'
		WHEN salary BETWEEN 1500 AND 3000 THEN 'average paid'
		ELSE 'well paid'
	END AS label
FROM employees
ORDER BY surname;

-- task 2
SELECT DISTINCT boss_id
FROM employees
WHERE boss_id IS NOT NULL
ORDER BY boss_id;

-- task 3
SELECT DISTINCT dept_id, job
FROM employees
WHERE dept_id IS NOT NULL
ORDER BY dept_id, job;

-- task 4
SELECT DISTINCT EXTRACT(YEAR FROM hire_date) as years
FROM employees
ORDER BY years;

-- task 5
SELECT DISTINCT dept_id FROM departments
EXCEPT
SELECT DISTINCT dept_id FROM employees;

-- task 6
(
	SELECT surname, salary, 'low paid' AS label
	FROM employees
	WHERE salary < 1500
	
	UNION

	SELECT surname, salary, 'average paid' AS label
	FROM employees
	WHERE salary BETWEEN 1500 AND 3000
	
	UNION
	
	SELECT surname, salary, 'well paid' AS label
	FROM employees
	WHERE salary > 3000
) ORDER BY surname;

-- task 1
WITH JohnsonDepartment AS
(
	SELECT dept.dept_id, dept.dept_name
	FROM employees emp
	INNER JOIN departments dept ON emp.dept_id = dept.dept_id
	WHERE emp.surname LIKE 'Johnson'
)

SELECT emp.surname, emp.job
FROM employees emp
INNER JOIN JohnsonDepartment dept ON emp.dept_id = dept.dept_id
WHERE NOT emp.surname LIKE 'Johnson'
ORDER BY emp.surname;

-- task 2
WITH JohnsonDepartment AS
(
	SELECT dept.dept_id, dept.dept_name
	FROM employees emp
	INNER JOIN departments dept ON emp.dept_id = dept.dept_id
	WHERE emp.surname LIKE 'Johnson'
)

SELECT emp.surname, emp.job, dept.dept_name
FROM employees emp
INNER JOIN JohnsonDepartment dept ON emp.dept_id = dept.dept_id
WHERE NOT emp.surname LIKE 'Johnson'
ORDER BY emp.surname;

-- task 3
SELECT surname, job, hire_date
FROM employees
WHERE job LIKE 'LECTURER'
ORDER BY hire_date
FETCH FIRST 1 ROWS ONLY;

-- task 4
SELECT
	dept.dept_name AS department,
	MAX(emp.surname) AS surname,
	MAX(emp.hire_date) AS hire_date
FROM departments dept
INNER JOIN employees emp ON dept.dept_id = emp.dept_id
GROUP BY dept.dept_name
ORDER BY dept.dept_name;

-- task 5
SELECT dept.dept_id, dept.dept_name, dept.address
FROM departments dept
LEFT JOIN employees emp ON dept.dept_id = emp.dept_id
WHERE emp.emp_id IS NULL;

-- task 6
WITH ProfessorsWithPHDStudent AS
(
	SELECT boss_emp.emp_id
	FROM employees emp
	INNER JOIN employees boss_emp ON emp.boss_id = boss_emp.emp_id
	WHERE
		boss_emp.job LIKE 'PROFESSOR'
		AND
		emp.job LIKE 'PHD STUDENT'
)

SELECT emp.surname, emp.job, emp.salary
FROM employees emp
LEFT JOIN ProfessorsWithPHDStudent prof ON emp.emp_id = prof.emp_id
WHERE
	prof.emp_id IS NULL
	AND
	emp.job LIKE 'PROFESSOR'
ORDER BY emp.surname;

-- task 7
SELECT dept.dept_name, COUNT(*) AS num_of_empl
FROM departments dept
INNER JOIN employees emp ON emp.dept_id = dept.dept_id
GROUP BY dept.dept_name
HAVING COUNT(*) > (
	SELECT COUNT(*)
	FROM departments dept
	INNER JOIN employees emp ON dept.dept_id = emp.dept_id
	WHERE dept.dept_name LIKE 'ADMINISTRATION'
)
ORDER BY dept.dept_name;

-- task 8
SELECT
    EXTRACT(YEAR FROM hire_date) AS year,
    COUNT(*) AS number_of_professors
FROM employees
WHERE job LIKE 'PROFESSOR'
GROUP BY EXTRACT(YEAR FROM hire_date)
ORDER BY number_of_professors, year;

-- task 9
SELECT
	dept.dept_name AS department,
	SUM(emp.salary + coalesce(emp.add_salary, 0)) AS max_sum
FROM departments dept
INNER JOIN employees emp ON dept.dept_id = emp.dept_id
GROUP BY dept.dept_name
ORDER BY max_sum DESC
FETCH FIRST 1 ROWS ONLY;

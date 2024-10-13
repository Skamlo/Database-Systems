-- task 1
SELECT emp.name, emp.surname, dept.dept_name, dept.address
FROM employees emp
LEFT JOIN departments dept ON emp.dept_id = dept.dept_id
ORDER BY emp.surname;

-- task 2
SELECT
	emp.name,
	emp.surname,
	CASE
		WHEN dept.dept_name IS NULL THEN 'no department'
		ELSE dept.dept_name
	END AS dept_name,
	CASE
		WHEN dept.address IS NULL THEN 'no department'
		ELSE dept.address
	END AS address
FROM employees emp
LEFT JOIN departments dept ON emp.dept_id = dept.dept_id
ORDER BY emp.surname;

-- task 3
(
    SELECT
        emp.name,
        emp.surname,
        CASE
            WHEN dept.dept_name IS NULL THEN 'no department'
            ELSE dept.dept_name
        END AS dept_name,
        CASE
            WHEN dept.dept_name IS NULL THEN 'no department'
            ELSE dept.address
        END AS address
    FROM employees emp
    LEFT JOIN departments dept ON emp.dept_id = dept.dept_id

    UNION

    SELECT
        'no employee' AS name,
        'no employee' AS surname,
        dept.dept_name,
        dept.address
    FROM employees emp
    RIGHT JOIN departments dept ON emp.dept_id = dept.dept_id
    WHERE emp.name IS NULL
) ORDER BY surname, name;

-- task 4
(
	SELECT
		dept.dept_name,
		COUNT(*) AS employees_at_dept,
		SUM(salary) AS salaries_at_dept
	FROM departments dept
	LEFT JOIN employees emp ON emp.dept_id = dept.dept_id
	WHERE emp.surname IS NOT NULL
	GROUP BY dept.dept_name
	
	UNION
	
	SELECT
		dept.dept_name,
		0 AS employees_at_dept,
		NULL AS salaries_at_dept
	FROM departments dept
	LEFT JOIN employees emp ON emp.dept_id = dept.dept_id
	WHERE emp.surname IS NULL
	GROUP BY dept.dept_name
) ORDER BY dept_name;

-- task 5
SELECT
	emp.surname AS employee,
	CASE
		WHEN boss.surname IS NULL THEN 'no boss'
		ELSE boss.surname
	END AS boss
FROM employees emp
LEFT JOIN employees boss ON boss.emp_id = emp.boss_id
ORDER BY employee;

-- task 6
WITH EmployeesAndBosses AS (
	SELECT
		emp.surname AS employee,
		CASE
			WHEN boss_emp.surname IS NULL THEN 'no boss'
			ELSE boss_emp.surname
		END AS boss
	FROM employees emp
	LEFT JOIN employees boss_emp ON boss_emp.emp_id = emp.boss_id
)

SELECT *
FROM EmployeesAndBosses
WHERE boss IN ('Wilson', 'Smith', 'no boss')
ORDER BY employee;

-- task 7
SELECT
	emp.surname AS employee,
	emp.salary * 12 + coalesce(emp.add_salary, 0) AS emp_annual_salary, 
	(boss_emp.salary - emp.salary) * 12 + coalesce(boss_emp.add_salary, 0) - coalesce(emp.add_salary, 0) AS less_than_boss
FROM employees emp
LEFT JOIN employees boss_emp ON emp.boss_id = boss_emp.emp_id
WHERE boss_emp.salary IS NOT NULL
ORDER BY employee;

-- task 8
SELECT boss_emp.surname AS boss, COUNT(emp.surname) AS subordinates
FROM employees boss_emp
LEFT JOIN employees emp ON boss_emp.emp_id = emp.boss_id
GROUP BY boss_emp.surname
ORDER BY boss_emp.surname;

-- task 9
WITH Emps AS (
	SELECT emp.name, emp.surname, emp.emp_id, emp.boss_id, dept.dept_name
	FROM employees emp
	LEFT JOIN departments dept ON emp.dept_id = dept.dept_id
	WHERE  dept_name IS NOT NULL
)

SELECT
	emp.name || ' ' || emp.surname AS employee,
	emp.dept_name AS employee_department,
	boss_emp.name || ' ' || emp.surname AS boss,
	boss_emp.dept_name AS boss_department
FROM Emps emp
LEFT JOIN Emps boss_emp ON emp.boss_id = boss_emp.emp_id
WHERE boss_emp.name || ' ' || emp.surname IS NOT NULL
ORDER BY employee;

-- task 10
WITH Emps AS (
	SELECT emp.name, emp.surname, emp.emp_id, emp.boss_id, dept.dept_name
	FROM employees emp
	LEFT JOIN departments dept ON emp.dept_id = dept.dept_id
)

SELECT
	emp.name || ' ' || emp.surname AS employee,
	CASE
		WHEN emp.dept_name IS NULL THEN 'no department'
		ELSE emp.dept_name
	END AS employee_department,
	CASE
		WHEN boss_emp.name IS NULL THEN 'no boss'
		ELSE boss_emp.name || ' ' || emp.surname
	END AS boss,
	CASE
		WHEN boss_emp.dept_name IS NULL THEN 'no department'
		ELSE boss_emp.dept_name
	END AS boss_department
FROM Emps emp
LEFT JOIN Emps boss_emp ON emp.boss_id = boss_emp.emp_id
ORDER BY employee;

-- task 11
WITH emps_n AS (SELECT COUNT(*) AS emp_count FROM employees),
     dept_n AS (SELECT COUNT(*) AS dept_count FROM departments),
     jobs_n AS (SELECT COUNT(*) AS job_count FROM jobs)

SELECT emp_count * dept_count * job_count AS rows_of_cartesian_product
FROM emps_n, dept_n, jobs_n;

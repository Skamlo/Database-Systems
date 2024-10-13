-- task 1
WITH AverageSalary AS (
	SELECT job, ROUND(AVG(salary), 2) AS avg_salary
	FROM employees
	GROUP BY job
)

SELECT emp.surname, emp.job, emp.salary, avg_sal.avg_salary AS avg_sal_for_job
FROM employees emp
INNER JOIN AverageSalary avg_sal ON emp.job = avg_sal.job
WHERE emp.salary > avg_sal.avg_salary
ORDER BY emp.surname;

-- task 2
WITH DepartmentsSumSalary AS (
	SELECT dept.dept_name, SUM(emp.salary) AS sum_of_sal
	FROM departments dept
	INNER JOIN employees emp ON dept.dept_id = emp.dept_id
	GROUP BY dept.dept_name
)

SELECT *
FROM DepartmentsSumSalary
ORDER BY sum_of_sal DESC
FETCH FIRST 1 ROWS ONLY;

-- task 3
WITH BossesSalary AS (
	SELECT DISTINCT
		boss_emp.emp_id,
		boss_emp.surname,
		boss_emp.salary
	FROM employees boss_emp
	INNER JOIN employees emp ON boss_emp.emp_id = emp.boss_id
)

SELECT
	emp.surname,
	emp.salary,
	boss_emp.surname AS boss_name,
	boss_emp.salary AS boss_salary
FROM employees emp
INNER JOIN BossesSalary boss_emp ON emp.boss_id = boss_emp.emp_id
WHERE emp.salary >= boss_emp.salary * 0.6
ORDER BY emp.surname;

-- task 4
SELECT surname, hire_date
FROM employees
ORDER BY hire_date
FETCH FIRST 1 ROWS ONLY;

-- task 5
WITH OldestEmployee AS (
	SELECT surname, hire_date
	FROM employees
	ORDER BY hire_date
	FETCH FIRST 1 ROWS ONLY
)

SELECT
	surname,
	hire_date - (SELECT hire_date FROM OldestEmployee) AS num_of_days
FROM employees
ORDER BY num_of_days;

-- task 6
SELECT
	surname || ' earns ' ||
	CASE
		WHEN salary < 1499.99 THEN 'one'
		WHEN salary BETWEEN 1500 AND 2499.99 THEN 'tow'
		WHEN salary BETWEEN 2500 AND 3499.99 THEN 'three'
		WHEN salary BETWEEN 3500 AND 4499.99 THEN 'four'
		WHEN salary BETWEEN 4500 AND 5499.99 THEN 'five'
		ELSE 'more than five'
	END
	|| ' grand' AS Sentence
FROM employees
ORDER BY surname;

-- task 7
SELECT
    name || ' ' || surname AS employee,
    SYS_CONNECT_BY_PATH(name || ' ' || surname, ' -> ') AS hierarchy
FROM employees
START WITH name = 'John' AND surname = 'Smith'
CONNECT BY PRIOR emp_id = boss_id
ORDER BY hierarchy;

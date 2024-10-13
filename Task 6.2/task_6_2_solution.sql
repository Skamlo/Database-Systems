-- task 1
SELECT dept.dept_id, dept.dept_name, dept.address
FROM departments dept
WHERE (
	SELECT COUNT(*)
	FROM employees emp
	WHERE emp.dept_id = dept.dept_id
) = 0;

-- task 2
SELECT surname, job, salary
FROM employees emp1
WHERE salary > (
	SELECT AVG(salary)
	FROM employees emp2
	WHERE emp1.job = emp2.job
)
ORDER BY surname;

-- task 3
SELECT emp1.surname, emp1.job, emp1.salary,
ROUND((
	SELECT AVG(salary)
	FROM employees emp2
	WHERE emp1.job = emp2.job
), 2)
FROM employees emp1
WHERE salary > (
	SELECT AVG(salary)
	FROM employees emp2
	WHERE emp1.job = emp2.job
)
ORDER BY surname;

-- task 4
SELECT emp.surname, emp.job, emp.salary
FROM employees emp
WHERE emp.salary >= (
	SELECT boss_emp.salary
	FROM employees boss_emp
	WHERE emp.boss_id = boss_emp.emp_id
) * 0.6
ORDER BY emp.surname;

-- task 5
SELECT MAX(dept_salaries.total_salary) AS max_sum
FROM (
    SELECT dept_id, SUM(salary) AS total_salary
    FROM employees
    GROUP BY dept_id
) dept_salaries;

-- task 6
SELECT dept_salaries.dept_name, dept_salaries.total_salary AS sum_of_sal
FROM (
    SELECT dept.dept_name, SUM(emp.salary) AS total_salary
    FROM employees emp
    JOIN departments dept ON emp.dept_id = dept.dept_id
    GROUP BY dept.dept_name
) dept_salaries
ORDER BY dept_salaries.total_salary DESC
FETCH FIRST 1 ROWS ONLY;

-- task 7
SELECT
	dept_name AS department,
	MAX(surname) AS employee,
	MAX(salary) AS max_salary
FROM (
	SELECT emp.surname, dept.dept_name, emp.salary
	FROM employees emp
	INNER JOIN departments dept ON emp.dept_id = dept.dept_id
)
GROUP BY dept_name
ORDER BY dept_name;

-- task 8
SELECT emp.surname, emp.salary
FROM employees emp
WHERE 3 > (
    SELECT COUNT(*)
    FROM employees sub_emp
    WHERE sub_emp.salary > emp.salary
)
ORDER BY emp.salary DESC;

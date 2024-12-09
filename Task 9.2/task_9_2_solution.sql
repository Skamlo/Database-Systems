-- CONSTRAINTS
-- task 1
-- In the Projects table, constraints include a primary key on project_id, a NOT NULL
-- constraint on project_name and start_date, a UNIQUE constraint on project_name, and
-- CHECK constraints ensuring budget > 0 and end_date > start_date. In the Employees
-- table, EMP_ID, SURNAME, NAME, and JOB are not nullable.

-- task 2
ALTER TABLE projects
ADD CONSTRAINT uk_projects_name UNIQUE (project_name);

ALTER TABLE projects
MODIFY (start_date NOT NULL);

ALTER TABLE projects
ADD CONSTRAINT chk_projects_end_start_date 
CHECK (end_date > start_date);

ALTER TABLE projects
ADD CONSTRAINT chk_projects_budget
CHECK (budget > 0);

ALTER TABLE projects
ADD number_of_employees NUMBER DEFAULT 0;

ALTER TABLE projects
ADD CONSTRAINT chk_projects_no_of_emp 
CHECK (number_of_employees >= 0);

-- task 3
UPDATE projects
SET NUMBER_OF_EMP = 0
WHERE NUMBER_OF_EMP IS NULL;

ALTER TABLE projects
MODIFY NUMBER_OF_EMP NOT NULL;

-- task 4
ALTER TABLE projects
ADD manager_id NUMBER(4) CONSTRAINT projects_fk_emps REFERENCES employees(emp_id);

-- task 5
UPDATE projects
SET manager_id = 420
WHERE project_name = 'Advanced Data Analysis';
-- It didn't work because "parent key not found"

-- task 6
UPDATE projects
SET manager_id = (
    SELECT emp_id
    FROM employees
    WHERE name = 'Mark' AND surname = 'Clark'
)
WHERE project_name = 'Advanced Data Analysis';

DELETE FROM employees
WHERE name = 'Mark' AND surname = 'Clark';
-- It didn't work because "child record found"

-- task 7
CREATE TABLE Assignments (
    project_id NUMBER NOT NULL,
    emp_id NUMBER(4) NOT NULL,
    function VARCHAR2(100) NOT NULL CHECK (function IN ('designer', 'programmer', 'tester')),
    start_date DATE DEFAULT SYSDATE NOT NULL,
    end_date DATE,
    salary NUMBER(8,2) NOT NULL CHECK (salary > 0),
    CONSTRAINT pk_assignments PRIMARY KEY (project_id, emp_id, start_date),
    CONSTRAINT fk_project FOREIGN KEY (project_id) REFERENCES projects(project_id),
    CONSTRAINT fk_employee FOREIGN KEY (emp_id) REFERENCES employees(emp_id)
);

-- task 8
INSERT INTO Assignments (project_id, emp_id, function, start_date, end_date, salary)
VALUES (3, 100, 'designer', TO_DATE('2024-01-01', 'YYYY-MM-DD'), TO_DATE('2024-06-30', 'YYYY-MM-DD'), 100000.00);

INSERT INTO Assignments (project_id, emp_id, function, start_date, end_date, salary)
VALUES (3, 200, 'programmer', TO_DATE('2024-03-01', 'YYYY-MM-DD'), TO_DATE('2024-09-30', 'YYYY-MM-DD'), 1400.00);

INSERT INTO Assignments (project_id, emp_id, function, start_date, end_date, salary)
VALUES (2, 220, 'tester', TO_DATE('2024-02-01', 'YYYY-MM-DD'), TO_DATE('2024-08-31', 'YYYY-MM-DD'), 5600.00);

INSERT INTO Assignments (project_id, emp_id, function, start_date, end_date, salary)
VALUES (100, 140, 'designer', TO_DATE('2024-05-01', 'YYYY-MM-DD'), TO_DATE('2024-11-30', 'YYYY-MM-DD'), 4200.00);

-- task 9
INSERT INTO Assignments (project_id, emp_id, function, start_date, end_date, salary)
VALUES (100, 120, 'manager', TO_DATE('2024-01-01', 'YYYY-MM-DD'), TO_DATE('2024-06-30', 'YYYY-MM-DD'), 5000.00)

-- task 10
SELECT constraint_name
FROM user_constraints
WHERE table_name = 'ASSIGNMENTS'
  AND constraint_type = 'C';

ALTER TABLE Assignments
DROP CONSTRAINT SYS_C*******;

INSERT INTO Assignments (project_id, emp_id, function, start_date, end_date, salary)
VALUES (100, 120, 'manager', TO_DATE('2024-01-01', 'YYYY-MM-DD'), TO_DATE('2024-06-30', 'YYYY-MM-DD'), 5000.00)

-- VIEWS
-- task 1
CREATE VIEW professors AS
SELECT
    name,
    surname,
    hire_date,
    salary,
    add_salary,
    CASE
        WHEN add_salary IS NULL THEN 0.0
        ELSE ROUND(add_salary / salary * 100, 2)
    END AS add_percent
FROM employees
WHERE job = 'PROFESSOR'
ORDER BY surname, name;

SELECT * FROM professors;

-- task 2
CREATE VIEW departments_totals AS
SELECT
    dept.dept_id,
    dept.dept_name department,
    ROUND(AVG(emp.salary), 2) avg_salary,
    COUNT(emp.dept_id) num_of_employees
FROM departments dept
LEFT JOIN employees emp ON dept.dept_id = emp.dept_id
GROUP BY dept.dept_id, dept.dept_name;

SELECT * FROM departments_totals;

-- task 3
SELECT
    emp.surname,
    emp.name,
    emp.salary,
    dept.department,
    dept.avg_salary,
    ABS(emp.salary - dept.avg_salary) diff
FROM employees emp
INNER JOIN departments_totals dept ON emp.dept_id = dept.dept_id
WHERE emp.salary > dept.avg_salary
ORDER BY emp.surname, emp.name;

-- task 4
SELECT  department, num_of_employees
FROM departments_totals
ORDER BY num_of_employees DESC
FETCH FIRST 1 ROWS ONLY;

-- task 5
CREATE VIEW emps_and_bosses AS
SELECT
    emp1.surname || ' ' || emp1.name employee,
    emp1.salary emp_salary,
    emp2.surname || ' ' || emp2.name boss,
    emp2.salary boss_salary
FROM employees emp1
INNER JOIN employees emp2 ON emp1.boss_id = emp2.emp_id
WHERE emp1.salary < emp2.salary
ORDER BY employee, boss;

SELECT * FROM emps_and_bosses;

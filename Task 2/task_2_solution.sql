-- task 1
SELECT surname, emp_id, UPPER(SUBSTR(surname, 1, 2)) || emp_id AS login
FROM employees
ORDER BY surname;

-- task 2
SELECT surname
FROM employees
WHERE
	surname LIKE '%l%'
	OR
	surname LIKE '%L%'
ORDER BY surname;

-- task 3
SELECT surname
FROM employees
WHERE
	SUBSTR(surname, 1, ROUND(LENGTH(surname)/2)) LIKE '%l%'
	OR
	SUBSTR(surname, 1, ROUND(LENGTH(surname)/2)) LIKE '%L%'
ORDER BY surname;

-- task 4
SELECT
	surname,
	salary AS original_salary,
	ROUND(salary * 1.15, 0) AS increased_salary
FROM employees
ORDER BY surname;

-- task 5
SELECT TO_CHAR(SYSDATE, 'Day') AS "Today is"
FROM dual;

-- task 6
SELECT TO_CHAR(TO_DATE('2004-01-16', 'YYYY-MM-DD'), 'Day') AS "I was born on"
FROM dual;

-- task 7
SELECT surname, TO_CHAR(hire_date, 'FMDD FMMonth YYYY, Day') AS hire_date 
FROM employees
ORDER BY surname;

-- task 8
SELECT
    surname,
    job,
    '+' || LPAD(FLOOR(MONTHS_BETWEEN(TO_DATE('2000-01-01', 'YYYY-MM-DD'), hire_date) / 12), 2, '0') || '-' ||
    LPAD(MOD(FLOOR(MONTHS_BETWEEN(TO_DATE('2000-01-01', 'YYYY-MM-DD'), hire_date)), 12), 2, '0') AS work_experience
FROM employees
WHERE job IN ('PROFESSOR', 'LECTURER', 'ASSISTANT')
ORDER BY hire_date;

-- task 9
SELECT
    surname,
    job,
    '+' || LPAD(FLOOR(MONTHS_BETWEEN(TO_DATE('2000-01-01', 'YYYY-MM-DD'), hire_date) / 12), 2, '0') || '-' ||
    LPAD(MOD(FLOOR(MONTHS_BETWEEN(TO_DATE('2000-01-01', 'YYYY-MM-DD'), hire_date)), 12), 2, '0') AS work_experience
FROM employees
WHERE
    job IN ('PROFESSOR', 'LECTURER', 'ASSISTANT') AND
    hire_date < TO_DATE('1990-01-01', 'YYYY-MM-DD')
ORDER BY hire_date;

-- task 10
SELECT
    surname,
    job,
    FLOOR(MONTHS_BETWEEN(TO_DATE('2000-01-01', 'YYYY-MM-DD'), hire_date) / 12) AS work_experience
FROM employees
WHERE
    job IN ('PROFESSOR', 'LECTURER', 'ASSISTANT') AND
    hire_date < TO_DATE('1990-01-01', 'YYYY-MM-DD')
ORDER BY hire_date;

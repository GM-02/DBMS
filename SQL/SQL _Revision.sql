create database revision;
use revision;
CREATE TABLE EMPLOYEES(
ID INT PRIMARY KEY,
NAME varchar(50) NOT NULL,
DEPARTMENT varchar(10),
SALARY INT NOT NULL,
REG_DATE DATETIME DEFAULT CURRENT_TIMESTAMP,
PHONE BIGINT NOT NULL
);
INSERT INTO employees(ID,NAME,DEPARTMENT, SALARY,PHONE)
VALUES
(100,'GM','IT',90000,923013225511),
(101, 'Arif Khan', 'IT', 85000, 923001234567),
(102, 'Ayesha Ahmed', 'HR', 72000, 923129876543),
(103, 'Zainab Fatima', 'Finance', 95000, 923214567890),
(104, 'Bilal Siddiqui', 'IT', 68000, 923335551234),
(105, 'Sana Malik', 'Marketing', 60000, 923457778888),
(106, 'Hamza Ali', 'Sales', 55000, 923014449999),
(107, 'Mariam Raza', 'HR', 74000, 923152223333),
(108, 'Mustafa Omar', 'Finance', 110000, 923228881111),
(109, 'Hania Imran', 'Marketing', 63000, 923346662222),
(110, 'Usman Yusuf', 'IT', 90000, 923461117777);

SELECT * FROM employees;

SELECT NAME,SALARY FROM employees;

UPDATE employees SET SALARY=100000 where id=100

DELETE FROM employees
 where id=110

SELECT *FROM employees
 WHERE DEPARTMENT='IT' AND SALARY>70000

SELECT * FROM employees
 WHERE DEPARTMENT IN('IT','HR')

SELECT *FROM employees
 WHERE NAME LIKE 'A%'

SELECT * FROM employees 
ORDER BY SALARY DESC;

SELECT * FROM employees
 ORDER BY SALARY ASC LIMIT 5;

SELECT COUNT(*) FROM employees;
 
 SELECT AVG(SALARY) FROM employees;
 
 SELECT MAX(SALARY) FROM employees;
 
 SELECT DEPARTMENT,COUNT(*)
 FROM employees 
 GROUP BY DEPARTMENT
 
 SELECT DEPARTMENT, AVG(SALARY)
 FROM employees
 GROUP BY DEPARTMENT
 HAVING AVG(SALARY)>80000;
 
 /* 
STARTING JOIN FROM HERE 
*/
 
CREATE TABLE PROJECTS (
    PROJECT_ID INT PRIMARY KEY,
    PROJECT_NAME VARCHAR(50) NOT NULL,
    BUDGET INT,
    EMP_ID INT, -- Connects to EMPLOYEES.ID
    STATUS VARCHAR(20) DEFAULT 'Not Started', -- Tracks progress (e.g., 'Active', 'Completed')
    START_DATE DATE,                          -- Practice with date filtering
    END_DATE DATE,                            -- Practice calculating durations
    CLIENT_NAME VARCHAR(50)                   -- Practice text filtering (LIKE)
);
INSERT INTO PROJECTS (PROJECT_ID, PROJECT_NAME, BUDGET, EMP_ID, STATUS, START_DATE, END_DATE, CLIENT_NAME) VALUES
(101, 'Website Redesign', 15000, 100, 'Active', '2026-01-15', '2026-06-30', 'Acme Corp'),
(102, 'HR Automation', 5000, 108, 'Completed', '2025-09-01', '2025-12-15', 'Internal'),
(103, 'Mobile App', 40000, 107, 'Active', '2026-03-01', '2026-11-30', 'Global Tech'),
(104, 'Data Security', 25000, 106, 'On Hold', '2026-05-01', NULL, 'SafeData Inc'),
(105, 'Office Renovation', 109, NULL, 'Not Started', NULL, NULL, 'Internal');

 select * FROM PROJECTS

SELECT E.NAME, P.PROJECT_NAME  
FROM EMPLOYEES E
INNER JOIN PROJECTS P
ON E.ID = P.EMP_ID;

SELECT E.NAME, P.BUDGET
FROM EMPLOYEES E
LEFT JOIN PROJECTS P
ON E.ID = P.EMP_ID;

SELECT E.NAME 
FROM EMPLOYEES E 
LEFT JOIN  PROJECTS P 
ON E.ID = P.EMP_ID
WHERE P.EMP_ID IS NULL;

SELECT E.NAME 
FROM EMPLOYEES E 
RIGHT JOIN  PROJECTS P 
ON E.ID = P.EMP_ID
WHERE P.EMP_ID IS NULL;

SELECT NAME, SALARY
FROM employees
WHERE SALARY > (
    SELECT AVG(salary)
    FROM employees
);

SELECT name, salary,
CASE
    WHEN salary >= 100000 THEN 'High'
    WHEN salary >= 60000 THEN 'Medium'
    ELSE 'Low'
END AS salary_level
FROM employees;


WITH high_salary AS (
    SELECT *
    FROM employees
    WHERE salary > 80000
)
SELECT *
FROM high_salary;


SELECT name, salary,
       RANK() OVER (ORDER BY salary DESC) AS salary_rank
FROM employees;




--INDEX
CREATE INDEX idx_employee_name
ON employees(name);






--TRANSACTION
START TRANSACTION;

UPDATE accounts
SET balance = balance - 100
WHERE id = 1;

UPDATE accounts
SET balance = balance + 100
WHERE id = 2;

COMMIT;





--View

CREATE VIEW employee_summary AS
SELECT name, department, salary
FROM employees;

SELECT *
FROM employee_summary;
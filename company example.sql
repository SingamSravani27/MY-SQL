DROP DATABASE IF EXISTS company;

CREATE DATABASE company;
USE company;

CREATE TABLE department (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(50)
);
desc department;
CREATE TABLE city (
    city_id INT PRIMARY KEY,
    city_name VARCHAR(50)
);
desc city;
CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(50),
    city VARCHAR(50),
    department VARCHAR(50),
    salary DECIMAL(10,2)
);
desc employees;
CREATE TABLE salary (
    salary_id INT PRIMARY KEY,
    employee_id INT,
    salary DECIMAL(10,2),
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
);

desc employees;

INSERT INTO employees
(employee_id, employee_name, city, department, salary)
VALUES
(101, 'Ravi', 'Hyderabad', 'IT', 50000),
(102, 'Priya', 'Chennai', 'HR', 40000),
(103, 'Arun', 'Bangalore', 'Finance', 60000),
(104, 'Sneha', 'Hyderabad', 'IT', 55000),
(105, 'Kiran', 'Mumbai', 'Sales', 45000),
(106, 'Anjali', 'Delhi', 'HR', 42000),
(107, 'Rahul', 'Hyderabad', 'Finance', 65000),
(108, 'Pooja', 'Chennai', 'IT', 52000);

-- 1. find the tota salary of all employees suing sum()
SELECT SUM(salary) AS total_salary
FROM employees;

-- 2.find the average salary of employees using avg()
SELECT AVG(salary) AS average_salary
FROM employees;

-- 3. find the highest salary using max()
SELECT MAX(salary) AS highest_salary
FROM employees;

-- 4. find the lowest salary using min()
SELECT MIN(salary) AS lowest_salary
FROM employees;

-- 5. find the number of employees using count()
SELECT COUNT(employee_id) AS number_of_employees
FROM employees;

-- 6. find the total salary department-wise using group by
SELECT department, SUM(salary) AS total_salary
FROM employees
GROUP BY department;

-- 7. find the avg salary department-wise
SELECT department, AVG(salary) AS average_salary
FROM employees
GROUP BY department;

-- 8. find the highest salary in each department
SELECT department, MAX(salary) AS highest_salary
FROM employees
GROUP BY department;

-- 9. find the lowest salary in each department
SELECT department, MIN(salary) AS lowest_salary
FROM employees
GROUP BY department;

-- 10. find the number of employees in each department
SELECT department, COUNT(employee_id) AS number_of_employees
FROM employees
GROUP BY department;

-- 11. display departments having more than 3 employees using having
SELECT department, COUNT(employee_id) AS number_of_employees
FROM employees
GROUP BY department
HAVING COUNT(employee_id) > 3;

-- 12.display departments whose avg salary is greater than 40000
SELECT department, AVG(salary) AS average_salary
FROM employees
GROUP BY department
HAVING AVG(salary) > 40000;

-- 13. find the department having highest total salary
SELECT department, SUM(salary) AS total_salary
FROM employees
GROUP BY department
ORDER BY total_salary DESC
LIMIT 1;

-- 14. find the department having lowest average salary
SELECT department, AVG(salary) AS average_salary
FROM employees
GROUP BY department
ORDER BY average_salary ASC
LIMIT 1;

-- 15. Display the city-wise number of employees, sorted by employee count ascending
SELECT city, COUNT(employee_id) AS employee_count
FROM employees
GROUP BY city
ORDER BY employee_count ASC;

-- 16. Find the department-wise total salary, but display only department where total salary is greater than 1,00,000
SELECT department, SUM(salary) AS total_salary
FROM employees
GROUP BY department
HAVING SUM(salary) > 100000;

-- 17. Display employees sorted by salary in descending order using ORDER BY
SELECT *
FROM employees
ORDER BY salary DESC;

-- 18. Display employees whose salary is greater than 30,000 and sort them by salary in ascending order using WHERE and ORDER BY 
SELECT *
FROM employees
WHERE salary > 30000
ORDER BY salary ASC;

-- 19. Find the second-highest salary using ORDER BY and LIMIT
SELECT salary
FROM employees
ORDER BY salary DESC
LIMIT 1 OFFSET 1;

-- 20. Display the top 3 highest-paid employees using ORDER BY and LIMIT
SELECT *
FROM employees
ORDER BY salary DESC
LIMIT 3;

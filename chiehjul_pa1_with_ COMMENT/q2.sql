# Find all male employees and sort the result by employee number.

SELECT *
FROM employees.employees where gender = 'M' order by emp_no;
# Find all employees’ employee number, birth date, gender. 
# Sort the result by employee’s birth date then employ number.

SELECT emp_no, birth_date, gender 
FROM employees.employees order by birth_date, emp_no;
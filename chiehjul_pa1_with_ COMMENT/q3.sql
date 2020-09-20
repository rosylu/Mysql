# Find all employees’ last name with their salaries in different periods. 
# Sort the result by last name, from date.

SELECT emp.last_name, sal.salary, sal.from_date, sal.to_date
FROM  employees.employees emp right join employees.salaries sal on emp.emp_no = sal.emp_no 
order by emp.last_name, sal.from_date, sal.to_date, sal.salary ;
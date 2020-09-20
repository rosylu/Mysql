# Assuming every employee is supervised by the manager of their current de- partment. 
# Find all employees’ current manager and the start date with their employee number and sort the result by employee number.

SELECT emp.emp_no as emp, mgr.emp_no as mgr, emp.from_date
FROM  (
	SELECT *
	FROM employees.dept_emp
	where to_date >= current_date
) emp left join (
	SELECT *
	FROM employees.dept_manager
	where to_date >= current_date
) mgr on emp.dept_no = mgr.dept_no
order by emp.emp_no;

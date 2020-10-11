select man.emp_no, dep.dept_name
from employees.dept_manager man JOIN employees.departments dep ON man.dept_no = dep.dept_no
where exists(
    SELECT *
	FROM (
		SELECT dept_no, min(datediff(to_date, from_date)) as diff
		FROM employees.dept_manager 
		group by dept_no
    ) man_diff
    where man_diff.diff = datediff(to_date, from_date)
)
order by man.emp_no;
SELECT depname.dept_name, depnum.cnt
FROM (
	SELECT dept_no, count(*)-1 as cnt
	FROM employees.dept_manager
	group by dept_no
) depnum join employees.departments depname on depnum.dept_no = depname.dept_no
where depnum.cnt > 1
order by depname.dept_name; 
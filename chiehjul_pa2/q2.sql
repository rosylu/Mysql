SELECT dep.dept_name, emp_tit.title, count(*) as cnt
FROM 
(
	SELECT emp.dept_no, emp.emp_no, tit.title
	FROM employees.dept_emp emp JOIN 
    (
		SELECT emp_no, title FROM employees.titles tit
		WHERE year(tit.to_date) = '9999'
	)
    tit ON emp.emp_no = tit.emp_no
	WHERE year(emp.to_date) = '9999'
) 
emp_tit JOIN employees.departments dep ON emp_tit.dept_no = dep.dept_no
GROUP BY dep.dept_name, emp_tit.title
order by dep.dept_name, emp_tit.title;

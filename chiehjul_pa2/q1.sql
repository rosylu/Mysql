SELECT 
    e1,e2
FROM
	(SELECT 
        emp.emp_no AS e1, salary AS e1_sa
    FROM
	(
		select emp.emp_no, emp.birth_date, salary
		from employees.employees emp, employees.salaries sal
		where emp.emp_no=sal.emp_no AND YEAR(sal.to_date) = '9999' AND emp.emp_no<100000
	) emp
    JOIN employees.dept_emp dep ON dep.emp_no = emp.emp_no
    WHERE
        dep.dept_no = 'd002'
            AND YEAR(emp.birth_date) = '1956'
            AND YEAR(dep.to_date) = '9999')  E1,
	(SELECT 
        emp.emp_no AS e2, salary AS e2_sa
    FROM
	(
		select emp.emp_no, emp.birth_date, salary
		from employees.employees emp, employees.salaries sal
		where emp.emp_no=sal.emp_no AND YEAR(sal.to_date) = '9999' AND emp.emp_no<100000
	) emp
    JOIN employees.dept_emp dep ON dep.emp_no = emp.emp_no
    WHERE
        dep.dept_no = 'd002'
            AND YEAR(emp.birth_date) = '1956'
            AND YEAR(dep.to_date) = '9999') E2
WHERE
    e1 > e2 AND e1_sa < e2_sa
order by e1,e2;
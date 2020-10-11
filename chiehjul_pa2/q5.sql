Select tit.emp_no, tit.on_date, tit.o_title, tit.n_title, sal.o_salary, sal.n_salary
from (
	SELECT t1.emp_no, t1.to_date as on_date, t1.title as o_title, t2.title as n_title
	FROM employees.titles t1 , employees.titles t2
	where t1.title <> t2.title AND t1.emp_no = t2.emp_no AND t1.to_date = t2.from_date
) tit join (
	SELECT s1.emp_no, s2.from_date as change_date, s1.salary as o_salary, s2.salary as n_salary, s1.salary-s2.salary as diff
	FROM employees.salaries s1 join employees.salaries s2 on s1.to_date = s2.from_date AND s1.emp_no = s2.emp_no
	where s1.salary > s2.salary
) sal on tit.emp_no = sal.emp_no AND sal.change_date = tit.on_date
order by tit.emp_no;
# List the number of employees in each department and return it only if the number is greater than 20000. 
# Sort the result by department name.

SELECT dep.dept_name, count(*) as noe
<<<<<<< HEAD
FROM employees.dept_emp emp right join employees.departments dep on emp.dept_no = dep.dept_no
where emp.to_date > CURRENT_TIMESTAMP
group by dep.dept_name having noe > 20000
order by dep.dept_name;
=======
FROM employees.dept_emp emp join employees.departments dep on emp.dept_no = dep.dept_no
where emp.to_date > CURRENT_TIMESTAMP
group by dep.dept_name having noe > 20000
order by dep.dept_name;
>>>>>>> master

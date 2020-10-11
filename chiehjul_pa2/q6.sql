SELECT emp_no, (
  select count(*)
  from employees.salaries s2
  where (year(s2.to_date) = '9999' AND s2.emp_no < 20000 AND s2.emp_no <> s1.emp_no)
  AND s2.salary <= s1.salary
  )*100/(
  select count(*)-1
  from employees.salaries
  where (year(to_date) = '9999' AND emp_no < 20000)
  ) as percentile
FROM (
  Select emp_no, salary
  FROM employees.salaries
  WHERE year(to_date) = '9999' AND emp_no < 20000
  ) s1
order by emp_no
;
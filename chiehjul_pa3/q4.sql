With recursive pro(src, dst, years, dir) as (
(
	SELECT t1.title as src, t2.title as dst, 
    cast(AVG(YEAR(t2.from_date) - YEAR(t1.from_date)+1) as decimal(7,4))  as years, cast(concat(t1.title, ',', t2.title) as CHAR(100))
	FROM employees.titles t1, employees.titles t2
	WHERE t1.emp_no = t2.emp_no AND t1.title <> t2.title AND t1.to_date = t2.from_date
    Group by src, dst
)
UNION ALL
(
	Select pro.src, ori_pro.dst, ori_pro.years+pro.years, concat(pro.dir, ',', ori_pro.dst)
    from (
		SELECT t1.title as src, t2.title as dst, cast(AVG(YEAR(t2.from_date) - YEAR(t1.from_date)+1) as decimal(7,4))  as years
		FROM employees.titles t1, employees.titles t2
		WHERE t1.emp_no = t2.emp_no AND t1.title <> t2.title AND t1.to_date = t2.from_date
		Group by src, dst
    ) ori_pro, pro 
    where pro.dst = ori_pro.src and not find_in_set(ori_pro.dst Collate utf8mb4_0900_ai_ci, pro.dir Collate utf8mb4_0900_ai_ci) 
)
)
Select src, dst, cast(min(years) as decimal(7,4))  as years from pro 
group by src, dst
order by src, dst;
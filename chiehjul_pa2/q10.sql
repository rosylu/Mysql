SELECT *
FROM (
	SELECT pay.customer_id, SUM(amount) as total, COUNT(amount) as n_rent
	FROM sakila.payment pay join sakila.rental ren on pay.rental_id = ren.rental_id 
	group by pay.customer_id
	order by pay.customer_id 
) all_info
WHERE total > 100;
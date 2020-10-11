SELECT *
FROM (
	SELECT f.film_id , replacement_cost-earn as to_breakeven
	FROM (
		SELECT inv.film_id, sum(pay.amount) as earn
		FROM sakila.rental ren, sakila.payment pay, sakila.inventory inv
		where ren.rental_id = pay.rental_id AND inv.inventory_id = ren.inventory_id
		group by inv.film_id
		) f_earn, sakila.film f
	WHERE  f.film_id = f_earn.film_id AND (replacement_cost-earn) > 0
	order by to_breakeven limit 5,5
    ) l_10
order by film_id;
    
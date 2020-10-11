SELECT f1, f2, count(*) as cnt
FROM (
	SELECT r1.customer_id, r1.rental_date as r1_rd, r1.film_id as f1,
		r2.rental_date as r2_rd, r2.film_id as f2
	FROM (
		SELECT film_id, customer_id, rental_date
		FROM sakila.inventory inv, sakila.rental ren
		WHERE  inv.inventory_id = ren.inventory_id
	) r1, (
		SELECT film_id, customer_id, rental_date
		FROM sakila.inventory inv, sakila.rental ren
		WHERE  inv.inventory_id = ren.inventory_id
	) r2
	WHERE  r1.customer_id = r2.customer_id AND r1.rental_date < r2.rental_date AND r1.film_id <> r2.film_id
    ) fil_map
Where not exists(
	Select *
    FROM (
		SELECT film_id, customer_id, rental_date
		FROM sakila.inventory inv, sakila.rental ren
		WHERE  inv.inventory_id = ren.inventory_id
	) r3
	WHERE (fil_map.customer_id = r3.customer_id AND fil_map.r1_rd < r3.rental_date )
    AND  fil_map.r2_rd > r3.rental_date
)
group by f1, f2
order by cnt DESC, f1 ASC, f2 ASC;

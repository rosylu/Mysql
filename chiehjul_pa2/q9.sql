SELECT ren_d.film_id, fil.length, ren_d.avg_days
FROM (
	SELECT film_id, SUM(DATEDIFF(return_date,rental_date))/COUNT(DATEDIFF(return_date,rental_date)) as avg_days
	FROM sakila.inventory inv, sakila.rental ren
	WHERE  inv.inventory_id = ren.inventory_id
    GROUP BY film_id
    ) ren_d, sakila.film fil
WHERE ren_d.film_id = fil.film_id;